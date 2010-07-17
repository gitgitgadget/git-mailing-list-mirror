From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git submodule add: Remove old docs about implicit -f
Date: Sat, 17 Jul 2010 18:26:15 +0200
Message-ID: <4C41D9A7.7000508@web.de>
References: <4C41C82F.8030200@web.de> <1279382025-24814-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 17 18:26:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaADW-0003VK-5R
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760041Ab0GQQ0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 12:26:17 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:47847 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348Ab0GQQ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 12:26:17 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 63F9D16473B6F;
	Sat, 17 Jul 2010 18:26:16 +0200 (CEST)
Received: from [80.128.59.5] (helo=[192.168.178.29])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OaADQ-0000Ll-00; Sat, 17 Jul 2010 18:26:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1279382025-24814-1-git-send-email-avarab@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18YC5/kVIL7hiKiFHceXSAKc9fQr8tsuP0WUTnB
	QsyjN+TthaenuU6XDnJYqMqEZP6aHya6i8PVGD8KEtoYVNlM5a
	FVeWaHfOFepNXq3dd3iw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151193>

Am 17.07.2010 17:53, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> git submodule add no longer implicitly adds with --force. Remove
> references to the old functionality in the documentation.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---

> This amended patch removes some obsolete documentation that you
> missed.

Yeah, thanks!

    Acked-by: Jens Lehmann <Jens.Lehmann@web.de>


>> +               echo >&2 "The following path is ignored by one of yo=
ur .gitignore files:" &&
>> +               echo >&2 $path &&
>> +               echo >&2 "Use -f if you really want to add it."
>=20
> Is the "it" intentional? We currently say "them" in git add regardles=
s
> of how many things are being added, so perhaps we should say "it"
> there too for singulars.

Yes, the "it" is intentional. While "git add" may be called with one
or more files, "git submodule add" can only be called with one path.
That's why I chose the singular form here.
