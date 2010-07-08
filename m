From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC] war on echo in scripts
Date: Fri, 09 Jul 2010 00:57:37 +0200
Message-ID: <m2k4p58tum.fsf@igel.home>
References: <20100706225522.GA31048@genesis.frugalware.org>
	<7vpqyz278o.fsf@alter.siamese.dyndns.org>
	<20100707091633.GB31048@genesis.frugalware.org>
	<AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
	<20100707094620.GC31048@genesis.frugalware.org>
	<7v7hl6stna.fsf@alter.siamese.dyndns.org>
	<20100708103552.GF31048@genesis.frugalware.org>
	<20100708171418.GA18229@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 00:57:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX02O-0002r4-6Q
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 00:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708Ab0GHW5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 18:57:43 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39522 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184Ab0GHW5m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 18:57:42 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id D076A1C15792;
	Fri,  9 Jul 2010 00:57:39 +0200 (CEST)
Received: from igel.home (ppp-88-217-105-23.dynamic.mnet-online.de [88.217.105.23])
	by mail.mnet-online.de (Postfix) with ESMTP id 9134C1C00151;
	Fri,  9 Jul 2010 00:57:39 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 0ABBCCA297; Fri,  9 Jul 2010 00:57:38 +0200 (CEST)
X-Yow: This MUST be a good party -- My RIB CAGE is being painfully
 pressed up against someone's MARTINI!!
In-Reply-To: <20100708171418.GA18229@burratino> (Jonathan Nieder's message of
	"Thu, 8 Jul 2010 12:14:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150617>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/contrib/examples/git-clone.sh b/contrib/examples/git-clone.sh
> index 547228e..e85ccda 100755
> --- a/contrib/examples/git-clone.sh
> +++ b/contrib/examples/git-clone.sh
> @@ -28,7 +28,7 @@ use-separate-remote  compatibility, do not use
>  no-separate-remote   compatibility, do not use"
>  
>  die() {
> -	echo >&2 "$@"
> +	printf >&2 '%s\n' "$@"

You probably want to use "$*" here, though it wouldn't matter for the
uses of die in this file.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
