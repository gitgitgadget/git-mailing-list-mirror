From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Submodules as first class citizens (was Re: Moving to subtrees
 for plugins?)
Date: Thu, 11 Jun 2015 20:56:59 +0200
Message-ID: <5579D9FB.8050104@web.de>
References: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com> <D2BB8369-E552-4AC3-967E-8F963206E03C@gmail.com> <5573E40A.3020502@gmail.com> <5577330E.3060803@web.de> <CABURp0qf3TCB5ofKG4=MHz1VP4_g8Es8=s9aefW4Sr2b6ZCz_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Repo Discussion <repo-discuss@googlegroups.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Phil Hord <hordp@cisco.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 20:57:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z37fK-0004xu-2h
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 20:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810AbbFKS5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 14:57:19 -0400
Received: from mout.web.de ([212.227.17.11]:63950 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293AbbFKS5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 14:57:09 -0400
Received: from [192.168.178.41] ([79.211.111.226]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MF3jD-1Yo0YR1iAd-00GGgI; Thu, 11 Jun 2015 20:57:00
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CABURp0qf3TCB5ofKG4=MHz1VP4_g8Es8=s9aefW4Sr2b6ZCz_A@mail.gmail.com>
X-Provags-ID: V03:K0:5IH9rkrsO60qXPUrZk9N9E44RGFLMmW+bN5hO8vDTRSIEcSs9Z8
 YReJKmQAk969tqIBLJGgzQs8MX9OTUxIzdfMcYqIse34xmG0RLr2gguuW2nnFqbO2ufMVfB
 8WvsD3nPdcrCY3dabtT7qPC53D4fOnFLb6Ha2aO/AOeLOxdoj1IIkGh+Iy76KDApVS13GLA
 +JkC2j+IQGk/FN1y9Vm3g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271450>

Am 11.06.2015 um 18:11 schrieb Phil Hord:
> On Tue, Jun 9, 2015 at 2:40 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 07.06.2015 um 08:26 schrieb Stefan Beller:
>>>
>>> On 06.06.2015 12:53, Luca Milanesio wrote:
>>>>>
>>>>> On 6 Jun 2015, at 18:49, Phil Hord <phil.hord@gmail.com> wrote:
>>>>> On Fri, Jun 5, 2015, 2:58 AM lucamilanesio <luca.milanesio@gmail.com>
>>>>> wrote:
>>>>>>
>>>>>> Ideally, as a "git clone --recursive" already exists, I would like to
>>>>>> see a "git diff --recursive" that goes through the submodules as well
>>>>>> :-)
>>>>>>
>>>>>> Something possibly to propose to the Git mailing list?
>>
>>
>> Such an option makes lots of sense to me (though "--recurse-submodules"
>> should be its name for consistency reasons). This could be an alias for
>> "--submodule=full", as the "--submodule" option controls the format of
>> submodule diffs.
>
> To me, --recurse-submodules means submodules are still not first-class
> citizens.  But let's put that aside for a moment; I don't care about
> the switch name too much as long as I can configure
> 'diff.recurse-submodules = true'.

After somebody implemented the 'full' mode for 'diff --submodule',
setting 'diff.submodule' to 'full' would make --recurse-submodules the
default for diff (unless recursing into the submodules is overridden
by either the global 'diff.ignoreSubmodules' or the per-submodule
'submodule.<name>.ignore' setting of course).

> [The following is rather long.  I'm sorry for that.  Feel free to look
> away when it gets too vague.]

Sorry, that was too long for todays git time budget ;-)
