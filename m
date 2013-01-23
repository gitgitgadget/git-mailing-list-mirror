From: "Stefan Schulze" <algroth@gmx.de>
Subject: AW: Moving commits from one branch to another
Date: Wed, 23 Jan 2013 15:13:19 +0100
Message-ID: <000b01cdf973$cc685fc0$65391f40$@de>
References: <000a01cdf961$bcf773d0$36e65b70$@de> <20130123121203.GM7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 15:13:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty15E-0005x4-JD
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 15:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab3AWONX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 09:13:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:57260 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755508Ab3AWONW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 09:13:22 -0500
Received: from mailout-de.gmx.net ([10.1.76.10]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MEphU-1Ti1j10UmY-00G1NF for
 <git@vger.kernel.org>; Wed, 23 Jan 2013 15:13:21 +0100
Received: (qmail invoked by alias); 23 Jan 2013 14:13:21 -0000
Received: from unknown (EHLO AINBSP0006) [62.154.226.26]
  by mail.gmx.net (mp010) with SMTP; 23 Jan 2013 15:13:21 +0100
X-Authenticated: #2258612
X-Provags-ID: V01U2FsdGVkX1+2YPcdlJS2kI8/8Ssc3BJyTiOZ6WkPBbam/w8lDV
	0fCCl7ejWzowXA
In-Reply-To: <20130123121203.GM7498@serenity.lan>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: Ac35YuN9yZv1h3DtRZqHe40ch6q0DgAEBQaw
Content-Language: de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214321>

> > Is there any way to move/copy commits from one branch to another
> > without a common base-commit and without a forced push of master?
>
> Did you try "git rebase" with "--onto"?  You probably want something
> like this:
> 
>     git rebase --onto svnbranch publishedToSvn master

I already tried this some days ago, but wasn't sure about the result. The
resulting history looks exactly what I expected, but all the commits are on
master after executing this commands and svnbranch only contains the
original two commits (svn-commit creating the root directory and the
cherry-picked commit from master)

Does the current branch matter if I call git-rebase with the
<branch>-argument?
