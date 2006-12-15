X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Enable reflogs by default in any repository with a
 working directory.
Date: Fri, 15 Dec 2006 01:13:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612150112010.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061214224117.GA26374@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 15 Dec 2006 00:14:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214224117.GA26374@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34449>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0iT-00073e-AP for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752058AbWLOAOS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWLOAOS
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:14:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:56979 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752060AbWLOAOR
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 19:14:17 -0500
Received: (qmail invoked by alias); 15 Dec 2006 00:13:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 15 Dec 2006 01:13:52 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Shawn O. Pearce wrote:

> +int is_bare_git_dir (const char *dir)
> +{
> +	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
> +		return 0;
> +	const char *s = strrchr(dir, '/');
> +	return !s || strcmp(s + 1, DEFAULT_GIT_DIR_ENVIRONMENT);
>  }

This function does not really determine if the repo is bare. I have no 
better name for it, though.

Ciao,
Dscho
