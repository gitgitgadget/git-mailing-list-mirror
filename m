From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possible BUG in 'git config'
Date: Sun, 11 Feb 2007 17:24:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702111720260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550702110613q315e1f7es4ca1a88b92e4c3e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, GIT list <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGHVZ-0004yq-Pn
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbXBKQYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbXBKQYz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:24:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:50286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbXBKQYy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:24:54 -0500
Received: (qmail invoked by alias); 11 Feb 2007 16:24:53 -0000
X-Provags-ID: V01U2FsdGVkX1+CpBgI+C6CmPOpSh4mhOkBcjeZc81j0ifkGZP7CG
	m37w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550702110613q315e1f7es4ca1a88b92e4c3e9@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39289>

Hi,

On Sun, 11 Feb 2007, Marco Costalba wrote:

> I would expect git repo-config user.name returns an empty string, 
> because user.name is defined _only_ in global config file ~/.gitconfig

The whole point of ~/.gitconfig is to store variables to be seen in _all_ 
repositories.

> How it is possible to know if a variable is stored in local config file?

If you _have_ to, you can use

	$ GIT_CONFIG=.git/config git config -l

but I _strongly_ suggest you rethink your workflow if you need that.

$HOME/.gitconfig _really_ is only meant to make it unnecessary to set a 
variable in _all_ your repositories, and you can even override (although 
not unset) the variables locally.

So I am certain that you made a mistake when you need to ignore the 
settings in $HOME/.gitconfig.

Hth,
Dscho
