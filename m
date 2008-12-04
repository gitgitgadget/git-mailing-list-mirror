From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 1/4] add strbuf_expand_dict_cb(), a helper for simple
	cases
Date: Thu, 04 Dec 2008 14:30:29 -0600
Message-ID: <1228422630.32534.4.camel@ld0161-tx32>
References: <4928912A.5050307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Kre-0005Yz-1O
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 21:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbYLDUak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 15:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbYLDUak
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 15:30:40 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:39535 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbYLDUaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 15:30:39 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id mB4KUVPp004724;
	Thu, 4 Dec 2008 13:30:31 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id mB4KUU0Z002563;
	Thu, 4 Dec 2008 14:30:30 -0600 (CST)
In-Reply-To: <4928912A.5050307@lsrfire.ath.cx>
X-Mailer: Evolution 2.0.2 (2.0.2-35.el4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102365>

On Sun, 2008-11-23 at 00:09 +0100, Ren=C3=A9 Scharfe wrote:
> The new callback function strbuf_expand_dict_cb() can be used togethe=
r
> with strbuf_expand() if there is only a small number of placeholders
> for static replacement texts.  It expects its dictionary as an array =
of
> placeholder+value pairs as context parameter, terminated by an entry
> with the placeholder member set to NULL.
>=20
> The new helper is intended to aid converting the remaining calls of
> interpolate().  strbuf_expand() is smaller, more flexible and can be
> used to go faster than interpolate(), so it should replace the latter=
=2E
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---

Acked-by: Jon Loeliger <jdl@freescale.com>

jdl
