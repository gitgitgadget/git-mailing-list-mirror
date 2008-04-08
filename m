From: Teemu Likonen <tlikonen@iki.fi>
Subject: "gitk" and "git log --graph": Strange behaviour with --follow
Date: Tue, 8 Apr 2008 19:42:08 +0300
Message-ID: <20080408164208.GA13871@mithlond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Tue Apr 08 18:45:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjGuR-0006E0-Fs
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 18:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYDHQmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 12:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYDHQmN
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 12:42:13 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:59915 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752453AbYDHQmM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2008 12:42:12 -0400
Received: from mithlond (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96004B6FB8; Tue, 8 Apr 2008 18:42:09 +0200
Received: from dtw by mithlond with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JjGtd-0005gb-02; Tue, 08 Apr 2008 19:42:09 +0300
Mail-Followup-To: Adam Simpkins <adam@adamsimpkins.net>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79008>

I found something very strange in graphical history tools "gitk" and
"git log --graph" when used with --follow. In Git repository compare the
following:

  $ gitk -- utf8.c
  $ gitk --follow -- utf8.c

The output of "git log --graph" is somewhat similar:

  $ git log --graph --pretty=oneline -- utf8.c
  $ git log --graph --pretty=oneline --follow -- utf8.c

All I can say is that the output is not intuitive at _all_. Almost all
the commits are in separate history lines.
