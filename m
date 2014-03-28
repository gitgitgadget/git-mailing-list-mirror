From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Documentation/submodule: Fix submodule.<name> -> .<path>
 typos
Date: Fri, 28 Mar 2014 17:55:18 +0100
Message-ID: <5335A976.6050908@web.de>
References: <f86f6b48f1c840d50d00c591a296821e0a18ee0d.1395954229.git.wking@tremily.us> <5334B0F4.60103@web.de> <20140328020648.GB25485@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTa46-0006qb-2b
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 17:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbaC1Qza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 12:55:30 -0400
Received: from mout.web.de ([212.227.15.14]:62291 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbaC1Qz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 12:55:29 -0400
Received: from [192.168.178.41] ([84.132.146.169]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MVLsk-1WZgAj2hiw-00YiPG; Fri, 28 Mar 2014 17:55:19
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140328020648.GB25485@odin.tremily.us>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:N4b+uANlcC1dBhnR8mEJTNm/LX+BIdsP+PBzQ8hmWFVyUPYwjHg
 LaaTb7t1U/oobAmhKPkjZb+ZitW9nFAn/iR1B7t7hQahJJ1w2VfrQMPbzhj5SBN7IzYlDFQ
 v00DKJKA/Tpa/yUleFZkN3vA8+OrLipkp3kKQfo/V+gJR8V82PmxlT/SWWg9Y7yT8tES0z3
 W/D5q4Xu/Yx9xzcNax4GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245394>

I just noticed that the two patches Junio added to pu have a reworded
commit message I'm perfectly happy with.

Thanks all.

Am 28.03.2014 03:06, schrieb W. Trevor King:
> On Fri, Mar 28, 2014 at 12:15:00AM +0100, Jens Lehmann wrote:
>> Am 27.03.2014 22:06, schrieb W. Trevor King:
>>> The transition from submodule.<path>.* to submodule.<name>.* happened
>>> in 73b0898d (Teach "git submodule add" the --name option, 2012-09-30),
>>> which landed in v1.8.1-rc0 on 2012-12-03.
>>
>> Nope, the distinction between path and name is way older (AFAIK it
>> is there from day one). That was just the point in time where you
>> could choose a different name without editing .gitmodules. And the
>> fact that the name is initialized with the path confused a lot of
>> people.
> 
> Before 73b0898d, cmd_add used:
> 
>   git config -f .gitmodules submodule."$sm_path".path "$sm_path"
> 
> and similar, so I used submodule.<path>.branch in my initial
> documentation of this patch (v5 of that series) [1].  By the final v8
> (which rebased onto the then-current master with 73b0898d), the
> surrounding calls were [2]:
> 
>   git config -f .gitmodules submodule."$sm_name".path "$sm_path"
> 
> but I missed the update to <name> in my rebasing.  I suppose I could
> have used <name> instead of <path> in my initial v5 patch, but I was
> one of the folks confused by the old name == path behavior ;).
> 
>>> This patch is against master, because 23d25e48 hasn't landed in maint
>>> yet.  If you want, I can split this into two patches, one against
>>> maint fixing the b9289227 typo and another against master fixing the
>>> 23d25e48 typo.
>>
>> This fixes the only two usages of 'submodule.<path>.*' in the
>> Documentation I can see in current master.
> 
> Right.  However, this patch won't apply to the maint branch (where
> 23d25e48 hasn't landed).  I'm just saying that we may want to split
> this patch in half and push the fix for b9289227 in a maintenance
> release.  On the other hand, we've survived since 2012 with the
> current docs, so *not* splitting this patch apart works for me too.
> 
> Cheers,
> Trevor
> 
> [1]: http://article.gmane.org/gmane.comp.version-control.git/210763
> [2]: http://article.gmane.org/gmane.comp.version-control.git/211832
> 
