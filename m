From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: Re: ls-tree with non-english characters
Date: Tue, 26 Jul 2011 13:39:16 +0200
Message-ID: <4E2EA764.60304@intland.com>
References: <4E2E8B33.6070900@intland.com> <20110726151739.51be3f55@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alexey Shumkin <ashu@rarus.ru>
X-From: git-owner@vger.kernel.org Tue Jul 26 13:39:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlfyw-0003KT-11
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 13:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379Ab1GZLjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 07:39:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:53425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab1GZLjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 07:39:21 -0400
Received: from [192.168.1.100] (77-234-81-149.pool.digikabel.hu [77.234.81.149])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MRDEV-1Qqw5C351r-00UZof; Tue, 26 Jul 2011 13:39:18 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <20110726151739.51be3f55@ashu.dyn.rarus.ru>
X-Provags-ID: V02:K0:5nMBNMzXXmOivNBGm7tL7Sr41NdrAak4UHK8pMNNPsa
 Mlit9qC4khZSuyoB0SJQVG1xu1EC0AZR2u1DxE8JMw7jM6isp5
 ySZOtXy0KxzOGLcnGpdQFgI7iTPHxsfAc9jrfd8G1K3vkacVSV
 PMoLJq1ZF7hH20moMXH2Ozmc6Muao4IjCcLHfzV/bkzz1q22HT
 FQwZIiwV6SxOvF02Jl/ffjEDkQEFNg7eUyWf+V9ASU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177858>

Dear Alaxey,

thanks, I didn't know about this configuration option.

Regards,
=C3=81kos Tajti

2011.07.26. 13:17 keltez=C3=A9ssel, Alexey Shumkin =C3=ADrta:
> =D0=92 Tue, 26 Jul 2011 11:38:59 +0200
> Tajti =C3=81kos<akos.tajti@intland.com>  =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
>
>> Dear List,
>>
>> I tried to use git ls-tree but on blob names containing non-english
>> characters I get a strange output. For example:
>>
>> =C3=A1kos=C5=B1 ->  \303\241kos\305\261
>>
>> There's no mention of this format in the manual of ls-tree. Could yo=
u
>> please help me on resolving this cryptic string to the original form=
?
>>
>> Thanks in advance,
>> =C3=81kos Tajti
> Russian Windows git users know this feature
>
> git config [--global] core.quotepath false
> resolves it
>
> and, yes, man git-config
