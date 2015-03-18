From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 15:48:42 +0100
Message-ID: <5509904A.2000606@aegee.org>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com> <55098A49.1020003@aegee.org> <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 15:49:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYFIE-0006sK-MW
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 15:49:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbbCROty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 10:49:54 -0400
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:44444 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbCROtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 10:49:53 -0400
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1YYFI7-0001XE-7f; Wed, 18 Mar 2015 15:49:51 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.0 smtp.aegee.org t2IEnvBP001560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1426690197; i=dkim+MSA-tls@aegee.org;
	bh=aOsylbvlxP98dNAenk1WzuT50kpES30269kTo7qUaI4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dk8/Uwwi4L+VcXtBZnRPkamoGCbF15oIAEMn+UXajvKdv5CPWuC5Oem3hYUNG8IEY
	 k0nTJXK4+JcaEkQMRhOc0yCLCbZO8Y5YDdAUoVKTsQ2xO84GxXrpuqdsGyxmpVRHog
	 l+AJy1MipgHXt3C7x5pV8851l5pd6SZcRBqyGICUKaB0qousIOMxEKC19qmVcWSl8D
	 pAIoGhWmdf8cjc58MuU+Nvv2uwItCYxMAPFVU3w2yC4V2MwHP/Okk5U7V+QlrNummA
	 CwuYGXLDtLbuoIImFUF9AHzGFsjR8sJmXlWNeTpGLmH+xJpqbF0Cq+EaU1fZnAKZ0d
	 sTf/uEAqRfGTvunzDxkzzN3mOALYGdvQlABEB8K5sp4MHPebSYcvAaMtg3bintpUKD
	 3twue/6FouAIStegAkGe4HuzVp5//YGUUlXTR30gC+dURhP9OzOco+N0PwhZhq1gKP
	 IpeRtGyCZgdAUJb+cMEcotzsPboO+2dnwJigZzePikClqv1c4AghSxtOEuIgC86ZKq
	 ThdtTiix9W0zltLPW5d482pt2K+FBRRM5QNBqoyRXV/25F1PiTk+m+U1Y4ATIUaaah
	 Oj9tBTBHVMYEn5x1cHhFrGFf/xf+NCcTDpbjClPYE1ZVccWAd/Fv3bwYjuo 
Received: from [192.168.0.6] (zuhause [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.15.1/8.15.1) with ESMTPSA id t2IEnvBP001560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 18 Mar 2015 14:49:57 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.98.6 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265735>

Hello Duy,

#ls .git/objects/17/*  | wc -l
30

30 * 256 =3D 7 680 > 6 700

And now?  Do I have to run git gc --aggressive ?

Kind regards
   Dilian


On 18.03.2015 15:33, Duy Nguyen wrote:
> On Wed, Mar 18, 2015 at 9:23 PM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=
=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
> <dilyan.palauzov@aegee.org> wrote:
>> Hello,
>>
>> # git gc --auto
>> Auto packing the repository in background for optimum performance.
>> See "git help gc" for manual housekeeping.
>>
>> and calls in the background:
>>
>> 25618     1  0 32451   884   1 14:20 ?        00:00:00 git gc --auto
>> 25639 25618 51 49076 49428   0 14:20 ?        00:00:07 git prune --e=
xpire
>> 2.weeks.ago
>>
>> # git count-objects -v
>> count: 6039
>
> loose number threshold is 6700, unless you tweaked something. But
> there's a tweak, we'll come back to this.
>
>> size: 65464
>> in-pack: 185432
>> packs: 1
>
> Pack threshold is 50, You only have one pack, good
>
> OK back to the "count 6039" above. You have that many loose objects.
> But 'git gc' is lazier than 'git count-objects'. It assume a flat
> distribution, and only counts the number of objects in .git/objects/1=
7
> directory only, then extrapolate for the total number.
>
> So can you see how many files you have in this directory
> .git/objects/17? That number, multiplied by 256, should be greater
> than 6700. If that's the case "git gc" laziness is the problem. If
> not, I made some mistake in analyzing this and we'll start again.
>
