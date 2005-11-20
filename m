From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Mon, 21 Nov 2005 00:26:30 +0100
Message-ID: <200511210026.30280.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Nov 21 00:31:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edydy-00013J-Ph
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 00:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVKTXan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 18:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVKTXan
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 18:30:43 -0500
Received: from mail.gmx.de ([213.165.64.20]:5776 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932125AbVKTXan (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Nov 2005 18:30:43 -0500
Received: (qmail invoked by alias); 20 Nov 2005 23:30:41 -0000
Received: from p5496B4ED.dip0.t-ipconnect.de (EHLO linux) [84.150.180.237]
  by mail.gmx.net (mp011) with SMTP; 21 Nov 2005 00:30:41 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12409>

On Sunday 20 November 2005 19:09, Linus Torvalds wrote:
> 	[branches.origin]
> 		url = master.kernel.org:/pub/scm/git/git.git
> 		pull = master:origin

Two things:
* base names are case insensitive. Repository shortcuts are case
sensitive (and head names, too)
* to get rid of .git/branches/XXX, XXX has to be allowed as
base name. But XXX can contain anything a head name can (including ".").

Not really a problem. Use the ' for ' syntax:

[remotes]
	url = master.kernel.org:/pub/scm/git/git.git for origin
	pull = master:origin for origin

Not really nice. We can not have "for" as head name.

Josef
