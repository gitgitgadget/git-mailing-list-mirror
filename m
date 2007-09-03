From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Export format_commit_message()
Date: Mon, 3 Sep 2007 19:35:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709031934480.28586@racer.site>
References: <46DC4D2C.8070109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Sep 03 20:36:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISGmN-0007eV-L9
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 20:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbXICSf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 14:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbXICSf6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 14:35:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:36108 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752502AbXICSf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 14:35:57 -0400
Received: (qmail invoked by alias); 03 Sep 2007 18:35:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 03 Sep 2007 20:35:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i/94OpqfiF6uJyKoAUvJddePHOvgHbDhEo2XxFt
	+0o2RUJi1lQ8XN
X-X-Sender: gene099@racer.site
In-Reply-To: <46DC4D2C.8070109@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57500>

Hi,

On Mon, 3 Sep 2007, Ren? Scharfe wrote:

> -static long format_commit_message(const struct commit *commit,
> -		const char *msg, char **buf_p, unsigned long *space_p)
> +long format_commit_message(const struct commit *commit, const void *template,
> +                           char **buf_p, unsigned long *space_p)

I am quite sure that this breaks compilation in C++.

Besides, "format" is so much more descriptive here IMHO.  What is so wrong 
with "format" for you?

Ciao,
Dscho
