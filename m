From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sun, 25 Sep 2005 20:56:03 +0200
Message-ID: <200509252056.04403.Josef.Weidendorfer@gmx.de>
References: <20050925070719.67119.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 25 20:57:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJbfi-0008Ne-GZ
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 20:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVIYS4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 14:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVIYS4Q
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 14:56:16 -0400
Received: from pop.gmx.de ([213.165.64.20]:63630 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932266AbVIYS4Q (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 14:56:16 -0400
Received: (qmail invoked by alias); 25 Sep 2005 18:56:14 -0000
Received: from p5496A955.dip0.t-ipconnect.de (EHLO linux) [84.150.169.85]
  by mail.gmx.net (mp013) with SMTP; 25 Sep 2005 20:56:14 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20050925070719.67119.qmail@web26309.mail.ukl.yahoo.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9274>

On Sunday 25 September 2005 09:07, Marco Costalba wrote:
> >> src/rangeselectbase.h QSettings: error creating /.qt
> >>QSettings: error creating /.qt
> ...
> QSettings are there from day one :-<
> I am not able to let them disappear.....very bad. In any case should be
> harmless.

These errors seam to appear because scons does NOT pass through the $HOME
environment variable to subprocesses. "moc", which is producing these
errors, obviously wants to access some config options in $HOME/.qt/.

Somebody knows how to change this?

Josef
