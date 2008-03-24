From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Spanish translation of gitk.
Date: Mon, 24 Mar 2008 12:08:26 +0100
Message-ID: <F90B5D52-0E47-4231-A9D3-4078C5EB6594@wincent.com>
References: <1206316703-15481-1-git-send-email-sgala@apache.org> <9D1D2D11-8C2E-4B8E-BB75-59D155AFF6BF@wincent.com> <loom.20080324T091855-5@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santiago Gala <sgala@apache.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 12:10:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdkYy-0007Y0-NP
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 12:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757799AbYCXLJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 07:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757844AbYCXLJF
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 07:09:05 -0400
Received: from wincent.com ([72.3.236.74]:39875 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757652AbYCXLJE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 07:09:04 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2OB8SaD007300;
	Mon, 24 Mar 2008 06:08:29 -0500
In-Reply-To: <loom.20080324T091855-5@post.gmane.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78023>

El 24/3/2008, a las 11:07, Santiago Gala escribi=F3:

> Wincent Colaiuta <win <at> wincent.com> writes:
>
>> Great job on the translation! Some feedback follows:
>>
>> El 24/3/2008, a las 0:58, sgala <at> marlow.memojo.com escribi=F3:
>>
>>> +#: gitk:275
>>> +msgid "Can't parse git log output:"
>>> +msgstr "No puedo analizar la salida de git log:"
>>
>> Wouldn't it be normal to use an impersonal form there? ie. "No se
>> puede analizar" instead of "No puedo analizar"
>
> Well, "no se puede" has 3 more characters than "no puedo", this was =20
> the
> primary reason why I switched to the first person form. Spanish is =20
> way more
> verbose than English.

Yes, I know, in many cases it is.

> what about "Error analizando la salida de git log:"?
> it is impersonal and shorter than the original one.

I think that's better. The first person form really stands out like a =20
sore thumb because basically _all_ of the output from the computer is =20
in an impersonal form, and all of a sudden the computer starts telling =
=20
you "_I_ couldn't process this!" as though it were a person.

If you really care about length, you _might_ consider saving 3 more =20
chars with:

"Error al leer la salida de git log"

But that's arguably starting to drift further away from the original =20
English meaning (parse -> read as opposed to parse -> analyze).

Cheers,
Wincent
