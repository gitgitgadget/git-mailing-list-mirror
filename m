From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] tests: Use skip_all=* to skip tests
Date: Fri, 09 Jul 2010 11:33:15 +0200
Message-ID: <4C36ECDB.9090707@drmicha.warpmail.net>
References: <1278551766-27569-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 11:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX9yb-000133-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 11:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab0GIJe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 05:34:28 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54793 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752690Ab0GIJe1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 05:34:27 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D2EF616AE1D;
	Fri,  9 Jul 2010 05:34:17 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 09 Jul 2010 05:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=1bIovra63Fz5rw/mhqQhGI4Kc+I=; b=QG4ZNAoD31N0ugHTlt4j5nhDjmdq14h4BEW9Ns0oB4twjANJ/Y7KnIlJ/io1VviRqKqvVH4zyoO9obCRrdp+ik21G0EEy6d7Suw71ptuipM63UQMx8+VZOFjotXdvYlfxEMYJ77UWlcwfG65xC7GW+nrQIFPRnpOac/TP01/SaU=
X-Sasl-enc: c2xpypJ5X2WimEt8iCMl1S/c6ERqxK4uxDbdergstMIh 1278668049
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 06E465FF97;
	Fri,  9 Jul 2010 05:34:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <1278551766-27569-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150648>

After trying out tests with prove (I like it!) I was just about to make
a patch before I saw this...

So, this does what it should, at least with my set of prerequisites.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 08.07.2010 0=
3:16:
> Change tests to skip with skip_all=3D* + test_done instead of using s=
ay
> + test_done.

I didn't understand this at all at first, only after I was about to
write that patch myself. Maybe 'with skip_all=3D"reason"' or
'skip_all=3D<reason>' etc.?

>=20
> This is a follow-up to "tests: Skip tests in a way that makes sense
> under TAP" (fadb5156e4). I missed these cases when prepearing that

"preparing", although that last sentence sounds more like "after ---
material".

> patch, hopefully this is all of them.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

No comments to the patch itself, it works :)

Michael
