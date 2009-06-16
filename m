From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: git diff looping?
Date: Mon, 15 Jun 2009 21:44:57 -0500
Message-ID: <20090616024457.GA9513@unpythonic.net>
References: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 04:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGOfb-0002fq-Kg
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 04:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbZFPCo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 22:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbZFPCo4
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 22:44:56 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:43873 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751261AbZFPCoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 22:44:55 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id 947BD114919; Mon, 15 Jun 2009 21:44:57 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <3ae83b000906151837r186221f2q1f8a670f13841877@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121651>

It's apples and oranges, but I had no problem on
    $ git --version
    git version 1.5.4.3
    $ uname -a
    Linux platte 2.6.24-24-generic #1 SMP Wed Apr 15 15:11:35 UTC 2009 x86_64 GNU/Linux
or 
    $ /usr/src/git/git --version
    git version 1.6.3.2.31.g7af0

    $ git clone git://repo.or.cz/egit.git
    $ cd egit
    $ git diff v0.4.0 | wc -l
    47943

    $ /usr/src/git/git diff v0.4.0 | wc -l
    47943

Jeff
