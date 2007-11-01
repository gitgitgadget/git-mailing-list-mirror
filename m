From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clone obey "--" (end argument parsing)
Date: Thu, 01 Nov 2007 13:39:58 -0700
Message-ID: <7vve8laee9.fsf@gitster.siamese.dyndns.org>
References: <20071101195418.607DA4F95F@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: shd@jolt.modeemi.cs.tut.fi (Heikki Orsila)
X-From: git-owner@vger.kernel.org Thu Nov 01 21:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IngqE-0003FK-9p
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 21:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbXKAUkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 16:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbXKAUkF
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:40:05 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:43080 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbXKAUkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:40:03 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3FFB72EF;
	Thu,  1 Nov 2007 16:40:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B2C9890C75;
	Thu,  1 Nov 2007 16:40:21 -0400 (EDT)
In-Reply-To: <20071101195418.607DA4F95F@jolt.modeemi.cs.tut.fi> (Heikki
	Orsila's message of "Thu, 1 Nov 2007 21:54:18 +0200 (EET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62992>

shd@jolt.modeemi.cs.tut.fi (Heikki Orsila) writes:

> Oops. Reposting the patch.
>
> This patch handles "--" argument for git-clone.
>
> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
>
>>From bd2d661c565062eacc80dda90f3978303308f9bb Mon Sep 17 00:00:00 2001
> From: Heikki Orsila <heikki.orsila@iki.fi>
> Date: Thu, 1 Nov 2007 16:21:39 +0200
> Subject: [PATCH] Make git-clone obey "--" (end argument parsing)
>
> ---
>  Documentation/git-clone.txt |    2 +-
>  git-clone.sh                |    5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 253f4f0..7fdcd42 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git-clone' [--template=<template_directory>]
>  	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare]
>  	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
> -	  [--depth <depth>] <repository> [<directory>]
> +	  [--depth <depth>] [--] <repository> [<directory>]

I do not think this breaks anything, but does it _help_
anything in practice?

What kind of breakage does this patch fix?
