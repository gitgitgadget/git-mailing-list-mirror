From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Change the spelling of "wordregex".
Date: Wed, 21 Jan 2009 09:26:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210925430.7929@racer>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de> <200901202146.58651.bss@iguanasuicide.net> <200901202259.54886.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:28:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYRU-0004mW-TW
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:28:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137AbZAUI0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 03:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756825AbZAUI0o
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:26:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:44383 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756624AbZAUI0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:26:44 -0500
Received: (qmail invoked by alias); 21 Jan 2009 08:26:42 -0000
Received: from pD9EB3014.dip0.t-ipconnect.de (EHLO noname) [217.235.48.20]
  by mail.gmx.net (mp006) with SMTP; 21 Jan 2009 09:26:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Igk88iVoIbhCyUYBAeillHJhP5HDI2IqxpN/ZBQ
	az1XGy/Qt5aXy2
X-X-Sender: gene099@racer
In-Reply-To: <200901202259.54886.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106577>

Hi,

On Tue, 20 Jan 2009, Boyd Stephen Smith Jr. wrote:

> diff --git a/userdiff.c b/userdiff.c
> index 2b55509..d556da9 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -6,8 +6,8 @@ static struct userdiff_driver *drivers;
>  static int ndrivers;
>  static int drivers_alloc;
>  
> -#define PATTERNS(name, pattern, wordregex)			\
> -	{ name, NULL, -1, { pattern, REG_EXTENDED }, wordregex }
> +#define PATTERNS(name, pattern, word_regex)			\
> +	{ name, NULL, -1, { pattern, REG_EXTENDED }, word_regex }
>  static struct userdiff_driver builtin_drivers[] = {
>  PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
>  	 "[^<>= \t]+|[^[:space:]]|[\x80-\xff]+"),

In general, it is an awesomly good idea to imitate code that is already 
there.  That literally guarantees consistency (which is Good, as you 
know).

And Thomas just imitated "xfuncname", which just so happens to be without 
an "_".

Ciao,
Dscho
