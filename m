From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: Re: ls-tree with non-english characters
Date: Tue, 26 Jul 2011 13:30:22 +0200
Message-ID: <4E2EA54E.9030204@intland.com>
References: <4E2E8B33.6070900@intland.com> <20110726103927.GA31625@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jul 26 13:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlfqK-0007sY-If
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 13:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab1GZLa1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 07:30:27 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:56507 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab1GZLa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 07:30:26 -0400
Received: from [192.168.1.100] (77-234-81-149.pool.digikabel.hu [77.234.81.149])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MaDyS-1R19MO2eVs-00Kc4e; Tue, 26 Jul 2011 13:30:24 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <20110726103927.GA31625@goldbirke>
X-Provags-ID: V02:K0:Bq4gtc6pEM8R62m0NaXvuT5kQisCVg7gnmjWvnvLhiv
 6hTZ8MGOnvVEz8Yqt4xEcCTgxmDagfOFLEqRWIt/bKNwf0fKcm
 1x4/3m3DzaLeuXmL0LRa7EfrAsreoOzK8LYABF3Gl+PmI/RpCO
 NFpJc8NiU1CSzu1TwLgFibjVwqGEaeS+YrLD+QcEOsCbcpTlU+
 mEIoaciZHa6tLwTzmAcl4pasT10KPHTlwbeZlAS7yg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177856>

Thanks, G=C3=A1bor, you helped a lot!

Regards,
=C3=81kos

2011.07.26. 12:39 keltez=C3=A9ssel, SZEDER G=C3=A1bor =C3=ADrta:
> Szervusz =C3=81kos,
>
>
> On Tue, Jul 26, 2011 at 11:38:59AM +0200, Tajti =C3=81kos wrote:
>> I tried to use git ls-tree but on blob names containing non-english
>> characters I get a strange output. For example:
>>
>> =C3=A1kos=C5=B1 ->  \303\241kos\305\261
>>
>> There's no mention of this format in the manual of ls-tree. Could yo=
u please
>> help me on resolving this cryptic string to the original form?
> Try with the -z option, it seems to do more than the documentation
> suggests:
>
>    $ git ls-tree HEAD
> 100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	"\303\241rv\303\=
255zt\305\261r\305\221"
>    $ git ls-tree -z HEAD
> 100644 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391	=C3=A1rv=C3=ADzt=
=C5=B1r=C5=91
>
>
> G=C3=A1bor
>
