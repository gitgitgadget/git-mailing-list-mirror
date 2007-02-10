From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 15:19:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFt5E-0004PN-2c
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXBJOUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXBJOUE
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:20:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:49742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932189AbXBJOUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:20:01 -0500
Received: (qmail invoked by alias); 10 Feb 2007 14:19:59 -0000
X-Provags-ID: V01U2FsdGVkX193kx5Q+nR3cymwgSpspR9/oEFjzuPBczk2HleaKC
	8sWA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39217>

Hi,

On Fri, 9 Feb 2007, Marco Costalba wrote:

> I just need to know if current working directory is clean and report 
> back to qgit user, so read-only access would be ok for me.

So, why don't you just do a

	git diff --name-only HEAD

and check for an empty output???

No need for a patch to Git (so late in the -rc phase), or backwards 
incompatibility...

Ciao,
Dscho
