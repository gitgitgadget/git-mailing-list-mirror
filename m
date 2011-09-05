From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: Re: Special characters in file name
Date: Mon, 05 Sep 2011 15:33:52 +0200
Message-ID: <4E64CFC0.8030704@intland.com>
References: <4E60C6D0.7090609@intland.com>	<loom.20110902T143646-347@post.gmane.org>	<20110903144617.GA17893@elie> <20110904000933.195d5bf4@zappedws> <4E64BD3D.6060900@intland.com> <4E64CBB0.7020902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <zapped@mail.ru>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 15:34:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ZJM-0004ue-Of
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 15:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab1IENeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Sep 2011 09:34:01 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:59549 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322Ab1IENeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 09:34:00 -0400
Received: from [192.168.1.101] (94-21-178-53.pool.digikabel.hu [94.21.178.53])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lx3Ub-1RG4s72BzN-017BZD; Mon, 05 Sep 2011 15:33:54 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.21) Gecko/20110830 Thunderbird/3.1.13
In-Reply-To: <4E64CBB0.7020902@viscovery.net>
X-Provags-ID: V02:K0:G02OBgCcTVsqlflLo3Kagqt/dawgmTR8YCeiM+hQCQd
 NFbpStFYhwhn3/gAi3QcK7hfov2U7XEHwfw5vN03yRN0uHRYRc
 Fp7jDevbRkTx0dRSRkDRjY1+HzlQzRCyRO4PdVFjIS+d8lyTu0
 q+bJ4AA+BkurqPoAqtnHwnCNZLAxG6OTwqDybrmODg21R+5lNA
 10en7uoYZ06Nbk8QAxc5KpG9uEuM4k5H2JvFwMogZAOwcX0xpy
 XXkZgDqejBL0BsSd9ojnE/gB0bndZguAIrK+xKftd2xZPwaaKO
 BsQWMdnHDw5gtIMwjE1dsPjrH3NsXMDHtFHkDwLDMLLthFC3uL
 STgx9aJnEjTm6xKJ8eA4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180742>

Thank you very much, setting LESSCHARSET solved this last problem!

=C3=81kos

2011.09.05. 15:16 keltez=C3=A9ssel, Johannes Sixt =C3=ADrta:
> Am 9/5/2011 14:14, schrieb Tajti =C3=81kos:
>> Thanks four your answer. However, it didn't help. After setting the
>> core.quotepath option to false I get this:
>>
>> diff --git a/<E1>rv<ED>zt<FB>r<F5>  b/<E1>rv<ED>zt<FB>r<F5>
>>
>> Is there a solution?
> This is because the output goes through the pager (less), which treat=
s
> non-ASCII characters.
>
> Tweak your settings (LESSCHARSET) or use a different or no pager.
>
> -- Hannes
