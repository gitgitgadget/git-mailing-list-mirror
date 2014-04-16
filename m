From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Wed, 16 Apr 2014 06:48:04 +0200
Message-ID: <534E0B84.6070602@web.de>
References: <201404072130.15686.tboegi@web.de> <alpine.DEB.2.00.1404152009020.29301@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXI=?= =?UTF-8?B?c2hhdXNlbg==?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:48:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaHlk-0001k8-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 06:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbaDPEsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2014 00:48:15 -0400
Received: from mout.web.de ([212.227.17.11]:62760 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbaDPEsO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 00:48:14 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LtkCj-1X06QD3gYP-0116vq; Wed, 16 Apr 2014 06:48:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <alpine.DEB.2.00.1404152009020.29301@ds9.cixit.se>
X-Provags-ID: V03:K0:KWFI1/Fpv/+xlwiUKJCdl/zktVFMA3ady/2B26/ljPRSdQuQ/I2
 Qzd1L5HF5mtq6hRiIYujR0XHMLb7L/8JCweSurGDZjjYFGlw01Dv9A90lT6CTUqQcKuyYkI
 UjTvY157M9aTpkPwcrc0kO08+HAeDq/NhnHbIuwxuPSHNnQPmIvTjKwQXPYIRpiF4+RVNfa
 iLx5dpsA5oPhFLWJvms9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246315>

On 15.04.14 21:10, Peter Krefting wrote:
> Torsten B=C3=B6gershausen:
>=20
>> diff --git a/utf8.c b/utf8.c
>> index a831d50..77c28d4 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>=20
> Is there a script that generates this code from the Unicode database =
files, or did you hand-update it?
>=20
Some of the code points which have "0 length on the display" are called
"combining", others are called "vowels" or "accents".
E.g. 5BF is not marked any of them, but if you look at the glyph, it sh=
ould
be combining (please correct me if that is wrong).

If I could have found a file which indicates for each code point, what =
it
is, I could write a script.

So yes, it is updated by hand.
