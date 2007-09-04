From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Functions for updating refs.
Date: Tue, 4 Sep 2007 14:45:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041444070.28586@racer.site>
References: <46DD6020.4050401@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:45:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISYj6-0001mb-J8
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 15:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbXIDNpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 09:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbXIDNpv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 09:45:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:44757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752264AbXIDNpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 09:45:50 -0400
Received: (qmail invoked by alias); 04 Sep 2007 13:45:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 04 Sep 2007 15:45:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ivj9k2++I9kG+1HH3lxA5v2AiGEAwW16hj3OB+C
	v2KhvJwTEQ4yF5
X-X-Sender: gene099@racer.site
In-Reply-To: <46DD6020.4050401@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57567>

Hi,

On Tue, 4 Sep 2007, Carlos Rica wrote:

> Signed-off-by: Carlos Rica <jasampler@gmail.com>
> ---
> 
>    They are designed to be reused also from other builtins,
>    like the recently changed builtin-tag.c and the upcoming
>    builtin-reset.c, and perhaps also from builtin-fetch--tool.c.

This should go into the commit message.

> +int update_ref_or_die(const char *action, const char *refname,
> +				const unsigned char *sha1,
> +				const unsigned char *oldval, int flags)

Should this not be "void"?  And should it not use update_ref_or_error()?

Otherwise I like it.

Ciao,
Dscho
