From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere: remove duplicated functions
Date: Sat, 14 Feb 2009 19:47:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902141944030.10279@pacific.mpi-cbg.de>
References: <1234628284-4246-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1617186044-1234637256=:10279"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 19:48:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYPZ4-0007Qe-1E
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 19:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZBNSqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 13:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbZBNSqo
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 13:46:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:37076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751269AbZBNSqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 13:46:43 -0500
Received: (qmail invoked by alias); 14 Feb 2009 18:46:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 14 Feb 2009 19:46:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Hlyw9ZA+Hs8KdAY2QizDmZbYv8xLa1/oFNcJsOG
	LZHkcL+5AeDC+n
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234628284-4246-1-git-send-email-szeder@ira.uka.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109890>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1617186044-1234637256=:10279
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Feb 2009, SZEDER Gábor wrote:

> diff --git a/rerere.h b/rerere.h
> index f9b0386..45b5087 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -5,5 +5,7 @@
>  
>  extern int setup_rerere(struct string_list *);
>  extern int rerere(void);
> +extern const char *rr_path(const char *name, const char *file);
> +extern int has_resolution(const char *name);

You might argue that rr_path() is a unique enough name (although I'd 
rather name it rerere_path() instead), but has_resolution() is not a good 
description of what the function does when it lives in the global name 
space.  has_rerere_resolution() (with "hex" instead of "name", to make it 
obvious what the parameter actually _is_) should be a much better name.

Thanks,
Dscho

--8323328-1617186044-1234637256=:10279--
