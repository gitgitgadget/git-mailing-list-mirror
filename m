From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Delaying 2.0 final
Date: Sun, 18 May 2014 08:36:06 +0800
Message-ID: <CANYiYbFrg3FeR+iBhY5gFR3G1u9WO2G0bRiqKoF90imfZJg8yA@mail.gmail.com>
References: <xmqqd2fd8hs9.fsf@gitster.dls.corp.google.com>
	<CANYiYbHYkCBmVfgpW8=1EZF4VkUuZM6kFuZP6fA2f7Wt9au5ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jean-Noel Avila <jn.avila@free.fr>,
	=?UTF-8?Q?Gr=C3=A9goire_Paris?= <postmaster@greg0ire.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 18 02:36:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlp5K-000235-4P
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 02:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbaERAgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 20:36:09 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:56463 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaERAgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 20:36:08 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so6486885wgg.30
        for <git@vger.kernel.org>; Sat, 17 May 2014 17:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=81eQEpbj8Dfnwr58KMQ6jL469/5k2Aiq0IVyumXiei4=;
        b=NKsNmGsnoMYEY0Hdzx7fcXF863bkL0gLlQVRWUdeD6PehTGGIHStUnPMpGvD6tDdat
         mkGJq2drNyaSwzimoNgyszRyLEAfTl0mKZ3+GVBwMNlEBYVT3iwqDTMwL6AqWz3oOtO2
         wBrlSVEkjtEtaFWuP96AjborX9UvhkVPrVTUMyZkWFTJ5m8Kpaly8TbvT4+ggY40R85P
         luoAe+cmhS0rW0oyH1f0SwEYFRP7FbocXwKW+kacmvmKVD0ae5cK/7PslQH1qJwrMw7S
         AxETBTOuBzBYiSnsgkhWFgj+VGe6li/WNlszM2MbI/L4HLT4mB5ENzzPvsA185xPclQq
         EiMg==
X-Received: by 10.180.7.198 with SMTP id l6mr5365301wia.52.1400373366477; Sat,
 17 May 2014 17:36:06 -0700 (PDT)
Received: by 10.194.104.9 with HTTP; Sat, 17 May 2014 17:36:06 -0700 (PDT)
In-Reply-To: <CANYiYbHYkCBmVfgpW8=1EZF4VkUuZM6kFuZP6fA2f7Wt9au5ig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249494>

2014-05-18 8:31 GMT+08:00 Jiang Xin <worldhello.net@gmail.com>:
> 2014-05-17 6:45 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
>> As we seem to have a few regressions we may want to fix, I will not
>> be cutting the 2.0 final today (https://tinyurl.com/gitCal).
>>
>> I queued the following near the bottom of 'pu' (these are also
>> merged to 'next' to keep pu^{/match.next} in sync with next), and
>> plan to cut 2.0.0-rc4 early next week.
>>
>
> So the update window is still open? Please pull this.
>
> The following changes since commit 6308767f0bb58116cb405e1f4f77f5dfc1589920:
>
>   Merge branch 'fc/prompt-zsh-read-from-file' (2014-05-13 11:53:14 -0700)
>
> are available in the git repository at:
>
>
>   git://github.com/git-l10n/git-po

It should be:

    git://github.com/git-l10n/git-po master

Next time I should run git request-pull like this:

    git request-pull kernel/master git-po HEAD:master

-- 
Jiang Xin
