From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 16:51:13 +0200 (CEST)
Message-ID: <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Pieter de Bie" <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Oct 15 16:50:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq7hW-0001qg-Rv
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 16:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217AbYJOOsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 10:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756205AbYJOOsN
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 10:48:13 -0400
Received: from mail.codewut.de ([78.47.135.140]:34519 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756196AbYJOOsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 10:48:12 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 9B2AE7BEF1; Wed, 15 Oct 2008 16:51:15 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id 654967BE67;
	Wed, 15 Oct 2008 16:51:13 +0200 (CEST)
Received: from 194.127.8.17
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Wed, 15 Oct 2008 16:51:13 +0200 (CEST)
In-Reply-To: <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98276>

> Works for me on Leopard
>
> Vienna:a pieter$ git submodule add ~/projects/GitX/ gitx
> Initialized empty Git repository in /Users/pieter/a/gitx/.git/
> Vienna:a pieter$ git st
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #	new file:   .gitmodules
> #	new file:   gitx
> #
> Vienna:a pieter$ git --version
> git version 1.6.0.2.415.gf9137

My git version "1.6.0.2" says:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   .gitmodules
#	new file:   lib
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	lib/
git --version
git version 1.6.0.2

Git was build from macports.

Yours,
Lars
