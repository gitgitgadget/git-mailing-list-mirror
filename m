From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH 2/2] clone: respect url.insteadOf setting in global configs
Date: Sun, 29 Jun 2008 22:12:49 +0200
Message-ID: <770C18A6-429E-49C0-BCF3-C2B229AAF5F9@ai.rug.nl>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.DEB.1.00.0806271355520.9925@racer>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3HQ-0007VY-GK
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758703AbYF2UMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758356AbYF2UMw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:12:52 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:38756 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758159AbYF2UMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:12:51 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6203.online.nl (SMTP Server) with ESMTP id 7DEA21C00088;
	Sun, 29 Jun 2008 22:12:50 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6203.online.nl (SMTP Server) with ESMTP id 493721C00081;
	Sun, 29 Jun 2008 22:12:50 +0200 (CEST)
X-ME-UUID: 20080629201250299.493721C00081@mwinf6203.online.nl
In-Reply-To: <alpine.DEB.1.00.0806271355520.9925@racer>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86824>


On 27 jun 2008, at 14:56, Johannes Schindelin wrote:

> When we call "git clone" with a url that has a rewrite rule in either
> $HOME/.gitconfig or /etc/gitconfig, the URL can be different from
> what the command line expects it to be.
>
> So, let's use the URL as the remote structure has it, not the literal
> string from the command line.
>
> Noticed by Pieter de Bie.


This works great, thanks for the quick patch! :)

- Pieter
