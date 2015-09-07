From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Pinning of submodules
Date: Mon, 7 Sep 2015 22:13:16 +0200
Message-ID: <55EDEFDC.3040605@web.de>
References: <55E78522.1030107@gmail.com> <55E78780.2040801@gmail.com>
 <CAPig+cQ6Ls1iasVsTwbpqGWt9=7gBuWjWAPmSMJCStsdPUwCgg@mail.gmail.com>
 <55ECB956.1080909@gmail.com>
 <CAPig+cRwAjTF6_rT8+nhbsZTYcZqneWSZ_LTCo9z2m5+SEGwWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Mark Levedahl <mlevedahl@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Anders Ro <anders.ronnbrant@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 22:13:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ2nX-00025H-Qd
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 22:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbbIGUNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 16:13:30 -0400
Received: from mout.web.de ([212.227.17.12]:50865 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbbIGUN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 16:13:28 -0400
Received: from [192.168.178.41] ([79.211.117.250]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MPYB3-1ZdBWi3B45-004kiD; Mon, 07 Sep 2015 22:13:21
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <CAPig+cRwAjTF6_rT8+nhbsZTYcZqneWSZ_LTCo9z2m5+SEGwWg@mail.gmail.com>
X-Provags-ID: V03:K0:t8fQwDLDAChINctHKbK3PTdMYmpHpchzPzEzvKL2hUIG68faqV4
 FU7s+X+r0FG3Xqh45KKS0CdhT9bzDnHCP0bKQqHRBnszr8wWrOzeBVBZ3a9OJqjIdgex6lA
 OPcEPzoLzpA+bRA+vS5g/32TpNHiivQsIe+abZwSinvlJcBskN9y9tLYJxr3sGqbMGptqbk
 Jl2WKaCE4tuJFXC3pkGlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MsWXxPxG7/0=:6HqcOJLUsIaK3PWt7gRwbv
 dVTq0dfJ1F+yQhOAUeETR+xuJuX2EffuIf7ZzApH09HnoxBux8jB6S2JIc5WdDrxEM326/x/Q
 3sGNIVuAoFTHmhX1erCf5vf+AlFrofHv7xXERfhNQeQaeU/NOzo61YCHfUgzjLJV4mHMiMmsM
 VHoq5GT9AR3hK4qVG5mzii0+2QNRgsVGgjvTOu4OLZbUYwqlIwtXF99lQ4QvhjwS4QljKoPcd
 m2A1WGsdACa3pWxWSM0EPI6wbwKQJ+01PMsF4d1ZaGfNvaPAMP5dBMhXnyrbiy4wW8AA4SI9P
 xNw/uAnDPEg/CBy7X6YjV3XzxUD2VrRzegtoW2Y489P8kcH81h2w4ysfqb5Yw1mIDL90Qeipw
 uMTqtQ2viRe/F8OtaNXTyL0sS0dnvYcznGzheywjR+gcc4zdDYHoCIwTuehwNYFqi4S8dbjh5
 NzWyYAJxeVh3K5PdMRQcGtCYy61S5POY/zYgAk07OCaVQm8rcgSGErQ8LaIDGZxAEaX4SmCmV
 S7KhsCn8eCFmaQbJyf9eTKDzDJznBfIO7+xwOrqO9EdySc+ZMARsosixYf8IkRba45K3ukemA
 A8FxQA/QThyB9GaAcMziuJngaHORrUVJbnc7fieFalQp4AwR03kXqs5KR3BkOQbZHMySl081o
 UM7bGbCE5MZzcWXMKAeqAS5Nqz97kx1fmDxYI6U3j8B6sEkfpehIMzpvIIxu3AIf7u/UmuR4K
 J4ngCY7xGmKrN4y2CcRs49olMOjn6+KY8iupwA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277476>

Am 07.09.2015 um 01:43 schrieb Eric Sunshine:
> On Sun, Sep 6, 2015 at 6:08 PM, Anders Ro <anders.ronnbrant@gmail.com> wrote:
>> On 04/09/15 07:02, Eric Sunshine wrote:
>>> On Wed, Sep 2, 2015 at 7:34 PM, Anders Ro <anders.ronnbrant@gmail.com> wrote:
>>>> git-submodule.sh: pin submodule when branch name is '@'
>>>>
>>>> Setting branch name to '@' for a submodule will disable 'git submodule
>>>> update --remote' calls for that specific submodule. I.e. instead of
>>>> follow the unspecified default choice of master, nothing is being
>>>> updated. This is useful when multiple submodules exist but not all
>>>> should follow the remote branch head.
>>>
>>> With the disclaimer that I'm not a submodule user (to which the
>>> answer might be obvious): What benefit is there in using a magic
>>> value like this ("@") over, say, an explicit configuration setting?
>>
>>  From what I have understood (not a submodule expert yet) the '@' is an
>> invalid branch name and should therefore not collide with any current
>> branches. My idea was to disable the '--remote' option when the user
>> have explicitly set an invalid branch name to not modify any current
>> behaviour. Though having an explicit option is of course more
>> clarifying. The current behaviour though is that empty branch name means
>> "follow master" which is somewhat unintuitive.
>
> My concern in asking was that some future person might come up with
> another scenario which also wants to use a "magic value" and would
> have to invent / arrive at another "illegal" representation. Hence, an
> explicit setting might be more appropriate. However, as stated, I
> don't even use submodules, so I may be far off the mark. I've cc'd a
> few of the submodule maintainers with the hope that they will chime
> in.

Added Trevor to the CC, who is the original author of --remote (see
06b1abb5b).

While I believe that adding such functionality makes perfect sense,
I do not find it terribly obvious that setting the branch to '@' will
make --remote skip this submodule. I wouldn't care so much if we'd
only use this value internally, but this is user visible (and has to
be set by the user if she wants to skip a submodule in --remote).

Setting the branch to an empty value feels a bit more natural, but
I'm not so sure our config handling supports that well (we seem to
assume in quite some places that empty equals unset). So I tend to
prefer a new option for that.
