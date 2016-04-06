From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] diff: run arguments through precompose_argv
Date: Wed, 6 Apr 2016 09:47:32 +0200
Message-ID: <5704BF14.9060100@web.de>
References: <1459802325-22056-1-git-send-email-alex@fournova.com>
 <1459802325-22056-2-git-send-email-alex@fournova.com>
 <xmqqzit80yov.fsf@gitster.mtv.corp.google.com> <57040EE0.40503@kdbg.org>
 <C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Alexander Rinass <alex@fournova.com>, Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 09:48:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aniC5-0002fy-Pw
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 09:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbcDFHr7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 03:47:59 -0400
Received: from mout.web.de ([212.227.17.11]:58374 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbcDFHr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 03:47:58 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0M4qWn-1bkBSN0u8D-00yzQ4; Wed, 06 Apr 2016 09:47:34
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <C52E38F0-B0F2-4769-A2C7-798D0CD99B47@fournova.com>
X-Provags-ID: V03:K0:ukk6ai4sbF+APNDYIYnSnNA2HmeMKWmJMcFS6BqKkF1QaqrGqlf
 GL5PyvUClPcAIhIx85nRKGfNRz/OmmgpY4YTzgV82B83VrN2YaYWGcAh/oPzNONitG5+108
 eZpB3MUqeTQ5yKN+HSM4GsiNyP/d+rLIklsQ4ZcUP+ihSofH1+9pIWtvcic/AstEv0UKvsk
 Ztq/9AE3FvCnH0N5+vVNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ofahf1RZJ18=:6mugUZE3hMDDiA5jqjIfYP
 tTpSc/1SDHzit9t1CrorZ8mQmgET0GORcrYghm76QJLDnbyT7bHZ3ZgYpbLWQbQGIPjoA4b96
 pwTdFciSU04peLUWHpBeDxpM7kQGAJr1qunJLmvTPmUQ1AaTflv8UX+X+bEP06qbi+DrcN071
 HRXBBQmoSJ4VBPixtZMnPQBrnf6WYj1tVOaP12BIMt4EprlYxKaX3kvUO+O0f7Fx7hOZseOJL
 Jc6T6hiTpcRJ3O2FCX+xmkXTMDz/wqYJQdyLFJEO7yytY+/PMuyYf5bZU3g2FUteWRom3CQ4+
 W+vi117WAT4LX+URrTdhrSQeeSDyz8wPRDBvbtzFj6V5dtKSH0AU2UIkA6lqQaHaKrZjFo+VK
 Mxx+X/7y4SP59bFt3PG6///B61FfTMxRCQ/OzAdy/1+wp0GfDVJhmrcvdXL9XmIEjI6XDKWTo
 hytr5RA+48Ssf6QCknJ4VI18cOXIEvxQSi/UA17eaGEzfMQQAdw+IXFCJSDhH85nPt+AhKKCx
 48bc72N6pX+hK1c3Th+CGiPpyEhZ+yeN5zo4Kbez22vFxM0wSTdQOJei+RxLTPc7mHymiz8bW
 2VzOl9tsFRMkxHb9+kk1GVVdlr0dWYJEJk3D2/esnhVNozCCe+QyL8Fmw5s2c+D6J9SougSo5
 gMVj0cTQmPt6I3rzKVVw+OH1QMIyOR5KVV6T5izG5mAVQp9Ow+4xQosfNhBQhcHnt7SDSFgfl
 ipzcJcl+v68z0hqpvBe1t6/g7GrUcbAwH6yysxBWJayy+J0JLDSnrh88r/Y67bBs1dQIywkL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290833>

On 06.04.16 08:51, Alexander Rinass wrote:
>=20
>> On 05 Apr 2016, at 21:15, Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Am 05.04.2016 um 19:09 schrieb Junio C Hamano:
>>>> Thanks-to: Torsten Bo=CC=88gershausen <tboegi@web.de>
>>
>> I sense NFD disease: The combining diaresis should combine with the =
o, not the g. Here is a correct line to copy-and-paste if you like:
>>
>> Thanks-to: Torsten B=C3=B6gershausen <tboegi@web.de>
>>
>> -- Hannes
>=20
> Thanks for reviewing and catching the NFD encoding error.
>=20
> I will send in a patch v2 with the correct NFC encoding.
>=20
> Would you also like me to alter the commit message as mentioned by Ju=
nio?
>=20
> I could rewrite the sentence:
>=20
> =E2=80=9CAs a result, no diff is displayed when feeding such a file p=
ath to the
> diff command.=E2=80=9D
>=20
> into simply saying:
>=20
> =E2=80=9CAs a result, no diff is displayed.=E2=80=9D
>=20
> However, I don't read the original message as it would imply that onl=
y
> file paths are affected by the precompose_argv call.=20
>=20
> Are there other suggestions on improving the commit message?
May be something like this, (but this is highly a personal taste questi=
on)

When running diff commands, file paths containing decomposed unicode co=
de points
are not converted to precomposed unicode form under Mac OS X.

As a result, no diff is displayed.

Opposite to most builtin commands, the diff builtin is missing the
parse_options call, which internally runs arguments through the
precompose_argv call, which ensures all arguments are in precomposed
unicode form.

=46ix the problem by adding a precompose_argv call to diff, diff-index,=
 diff-files and diff-tree.

Signed-off-by: Alexander Rinass <alex@fournova.com>
Helped-By: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-By: Junio C Hamano <gitster@pobox.com>
