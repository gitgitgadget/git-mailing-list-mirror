From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 1/3] strbuf: Add =?UTF-8?Q?strbuf=5Fvaddf=20function?=
Date: Sun, 11 Apr 2010 13:59:15 +0100
Message-ID: <2668f8f72053fad18f62033e82767b75@212.159.54.234>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <20100411113733.80010.78232.julian@quantumfyre.co.uk> <n2i40aa078e1004110542kcfba8b6dw8848cd8f5647fda7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 14:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0wl4-0003t2-Gl
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 14:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab0DKM7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 08:59:18 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:44247 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab0DKM7R (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 08:59:17 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id C5203819C6D7;
	Sun, 11 Apr 2010 13:59:10 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8377520CEF1;
	Sun, 11 Apr 2010 13:59:16 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xnBJ6HN6FzwF; Sun, 11 Apr 2010 13:59:16 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id CB155A91DC;
	Sun, 11 Apr 2010 13:59:15 +0100 (BST)
In-Reply-To: <n2i40aa078e1004110542kcfba8b6dw8848cd8f5647fda7@mail.gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144647>

On Sun, 11 Apr 2010 14:42:29 +0200, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Sun, Apr 11, 2010 at 1:37 PM, Julian Phillips
> <julian@quantumfyre.co.uk> wrote:
>> +void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list args)
>> +{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0int len;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0va_list ap;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strbuf_avail(sb))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_grow(s=
b, 64);
>> - =C2=A0 =C2=A0 =C2=A0 va_start(ap, fmt);
>> + =C2=A0 =C2=A0 =C2=A0 va_copy(ap, args);
>=20
> Isn't va_copy C99?

Indeed.

Hi ho, hi ho, It's off to a custom implementation I go ...

Ho hum. =20

--=20
Julian
