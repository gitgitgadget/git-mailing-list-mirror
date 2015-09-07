From: Olaf Hering <olaf@aepfle.de>
Subject: Re: bash completion lacks options
Date: Mon, 7 Sep 2015 17:36:19 +0200
Message-ID: <55EDAEF3.7000503@aepfle.de>
References: <20150907150757.GA6720@aepfle.de>
 <CACBZZX4aZo_hn07Pho2GtBVNWm7WHLbV6xSi_r-BjW97QWNqEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 17:42:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYyZD-0005yb-GZ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 17:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbbIGPml convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2015 11:42:41 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:48947 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbbIGPmg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 11:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1441640554; l=462;
	s=domk; d=aepfle.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:From:Cc:References:To:Subject;
	bh=vZVLw/Bg4L/V529RihcUwu66WCpiujMticYdPIE70Hs=;
	b=FWvTLY9uX8l7FwdiMkQdpX5e+uX9PJ9UyTjtR470Nbt/NhMbcrg9c3U36mJ1Z1ZKDaU
	AFIFCYqH5cqEoiHJZT+enflxbn/lKb9DsQzr17HjHkI/OicW+50MeEcG80Zmd36qgtPoh
	Q6szkswFahCVzVwFWb/j7+Kv0zbIbW7vAEs=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+zrwiavkK6tmQaLfsxs2aAREi5Yt9N5U0bMZsfB9ke958Ej4Y673Lt+BWQLuDb19F
X-RZG-CLASS-ID: mo00
Received: from probook.fritz.box ([2001:a62:46:a201:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.11 AUTH)
	with ESMTPSA id g06ab7r87FaJ5ak
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate);
	Mon, 7 Sep 2015 17:36:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <CACBZZX4aZo_hn07Pho2GtBVNWm7WHLbV6xSi_r-BjW97QWNqEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277467>

Am 07.09.2015 um 17:34 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Mon, Sep 7, 2015 at 5:07 PM, Olaf Hering <olaf@aepfle.de> wrote:

>> https://github.com/libguestfs/libguestfs/commit/0306c98d319d189281af=
3c15101c8d343e400f13
>=20
> This is an interesting approach, but wouldn't help with git-send-emai=
l
> in particular, it's a Perl script, so there's no ELF section to parse=
=2E

format-patch is a ELF binary, a link to git itself as I notice
just now.

Olaf
