From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: t0090-cache-tree fails due to wc whitespace
Date: Wed, 14 Dec 2011 16:54:03 +0100
Message-ID: <m2ehw7jgis.fsf@igel.home>
References: <7F1792D2-8ED4-4546-8ED4-52B95E0AE9FC@silverinsanity.com>
	<201112141643.06656.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rar9r-00036R-S1
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120Ab1LNPyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 10:54:11 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:43283 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1LNPyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 10:54:09 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 142611C0F570;
	Wed, 14 Dec 2011 16:54:04 +0100 (CET)
X-Auth-Info: OrLtakAlgVyaHR3Br3jLAJ8x8eetfgqBou+f+gAZfBI=
Received: from igel.home (ppp-88-217-105-12.dynamic.mnet-online.de [88.217.105.12])
	by mail.mnet-online.de (Postfix) with ESMTPA id 7EBFF1C00088;
	Wed, 14 Dec 2011 16:54:04 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id E7534CA29C; Wed, 14 Dec 2011 16:54:03 +0100 (CET)
X-Yow: I was making donuts and now I'm on a bus!
In-Reply-To: <201112141643.06656.trast@student.ethz.ch> (Thomas Rast's message
	of "Wed, 14 Dec 2011 16:43:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187135>

Thomas Rast <trast@student.ethz.ch> writes:

> (Oddly, according to 'man 1p wc' here, the POSIXly correct format in
> the absence of options is
>
>   "%d %d %d %s\n", <newlines>, <words>, <bytes>, <file>
>
> Taking it literally would mean no padding/alignment whatsoever.
> Neither GNU wc on my Linux exactly conforms to this.)

A space in the format string stands for one or more <blank>s.  If only =
a
single <space> is allowed the standard uses =F0=9D=9A=AB.

Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
