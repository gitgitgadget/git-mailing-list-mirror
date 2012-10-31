From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't understand the behaviour of git-diff --submodule
Date: Wed, 31 Oct 2012 08:36:20 +0100
Message-ID: <CAC9WiBiT963AN_vy-34Tn_LpTOt4DQ_i-_xb6utFdm6_YHtDrA@mail.gmail.com>
References: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com>
	<508ADFAE.1050800@web.de>
	<CAC9WiBjiHLJggUzmmx4sPpXNNq=Kz0TOZAzmRShc1AZcPjGvig@mail.gmail.com>
	<508AED26.3090805@web.de>
	<CAC9WiBhZWJihPToMawPCxEVkTKL0e-GzUw3qneJMUx-WqSNbjw@mail.gmail.com>
	<508C6823.5060800@web.de>
	<509043DA.6040606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 08:36:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTSqo-0003Un-C4
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 08:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934284Ab2JaHgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 03:36:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47459 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab2JaHgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 03:36:21 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1135695obb.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CMeoaVEW6bdKmFoOP7SG5UCBQquYw4Nhx6viZCtbntY=;
        b=tVSUfyGynrLyCXaBlcnl0e0GyXPTEJ0ns619oE2+kjVXptLk85geox7Ufsx7LxY61k
         kcOmJ+NfYoO2t/h6BefcaJuFD5DGeuYHhO5+TquM1+r1zikMx39tg5DrybKuPEAt1d1f
         qEaAR8SoqqOsJTW1RxAnu3xwDTELhn8GSStz8fTKV6x4z2C3cZHbaGfj5tHcGKg0nZkx
         s2/ZZjQhaHSb68+7CaJEKnvVsa1c5iOISmF/Lh1SLYBiPQd8lr3VqUTa5ywBGUVqvmvQ
         xC0BwH/I3tRc9QeQGIzh5NNfjnRCmM5I5A2BJPUSMdCwGDmWIKcBYkRR7CG5bqL1pO29
         ukoA==
Received: by 10.60.19.162 with SMTP id g2mr31484081oee.73.1351668980214; Wed,
 31 Oct 2012 00:36:20 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Wed, 31 Oct 2012 00:36:20 -0700 (PDT)
In-Reply-To: <509043DA.6040606@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208800>

Hi,

On Tue, Oct 30, 2012 at 10:17 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 28.10.2012 01:02, schrieb Jens Lehmann:
>> Am 26.10.2012 22:43, schrieb Francis Moreau:
>>> On Fri, Oct 26, 2012 at 10:05 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> [...]
>>>>
>>>> That is weird, "git diff --submodule" should show that too. Is there
>>>> anything unusual about your setup? (The only explanation I can come
>>>> up with after checking the code is that your submodule has neither a
>>>> .git directory nor a gitfile or the objects directory in there doesn't
>>>> contain these commits)
>>>
>>> Oh now you're asking, I think the submodule has been added by using
>>> the --reference option of git-submodule-add.
>>>
>>>   $ cd configs
>>>   $ cat .git
>>>   gitdir: ../.git/modules/configs
>>
>> Thanks, I suspect the --reference option makes the difference here,
>> I'll check that as soon as I find some time.
>
> Since 1.7.11 and 1.7.10.3 git does handle submodules with alternates
> (which is what --reference uses) correctly. What version are you
> seeing this problem with?

git version 1.7.10.4

Thanks.
-- 
Francis
