From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Altering Previous Commits' Author Field.
Date: Tue, 24 Feb 2009 22:43:49 +0100
Message-ID: <200902242243.49612.robin.rosenberg.lists@dewire.com>
References: <c115fd3c0902241329i2455bc8bj62ec41856773be30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:45:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc55g-00067p-UR
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 22:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642AbZBXVnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756718AbZBXVnz
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 16:43:55 -0500
Received: from mail.dewire.com ([83.140.172.130]:20350 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbZBXVny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 16:43:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 397FB147E9FC;
	Tue, 24 Feb 2009 22:43:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LddQMKkhy+EY; Tue, 24 Feb 2009 22:43:50 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 1FB55147E9F9;
	Tue, 24 Feb 2009 22:43:50 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <c115fd3c0902241329i2455bc8bj62ec41856773be30@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111347>

tisdag 24 februari 2009 22:29:15 skrev Tim Visher <tim.visher@gmail.com>:
> Hello Everyone,
> 
> I have two identities that git knows me as, one for personal and the
> other for work.  I just realized that I project I've been doing some
> work on at work was using the global config file on that box because I
> had forgotten to a project specific config to change my identity.  Is
> there any way for me to edit the history so that the Author of all of
> those commits is changed to my personal identity?

If you haven't published your branch you can use git-filter-branch to
rewrite using the --env-filter "export GIT_AUTHOR_NAME=...  etc"

-- robin
