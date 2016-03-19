From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: [PATCH/GSoC] pull: implement --[no-]autostash for usage when rebasing
Date: Sat, 19 Mar 2016 20:01:38 +0530
Message-ID: <CAJj6+1F6eAyhs8xxtukKw+sCE63ASq=K+hxtH8VC95FEuNKGBQ@mail.gmail.com>
References: <1458395862-5113-1-git-send-email-chirayudesai1@gmail.com>
	<CAJj6+1ECzKw9jnO1wGZqSyrJ0V=G3TzzE5YKhSKzVO1kqXpXPw@mail.gmail.com>
	<56ED60FD.1030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 15:31:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahHuq-0003FZ-OL
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 15:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbcCSObk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 10:31:40 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36747 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbcCSObj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 10:31:39 -0400
Received: by mail-io0-f172.google.com with SMTP id 124so15483928iov.3
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BFDsXCsgG3a9xkko6ypeo4cbK8uahvpOnbOspPOow4s=;
        b=B8JdzO53nuXmoDJxrHj/tFqzkS3eKI65VnMlEy4QcoRPPIniZv7RZc2u0SMeNCnxPJ
         DMu7wCQrG98CbpTY+VkZJa87TrDq3LJWUdWk5kNjycshFHvHFe6xwjPccFqzdzEH0phv
         HE4i+xzuhIb4IWXs0O+PDuNrHzxZWxbXFV6dnzOiaqYdIcipjdtqi+bk2gdVDJwlHcG2
         S23VO+fE732kdx4jDF3Kw0QydtTCkmNzqLNIiabogIqfYhP9fwqYhkINrMeaQ+u7yeOy
         2vdinyA1miSoUu3byhqYhgtFAetdMEoCoq/jezRh5x0PtAoHU4D6QR8xqxoCckrNTJ22
         fwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BFDsXCsgG3a9xkko6ypeo4cbK8uahvpOnbOspPOow4s=;
        b=DLXDD2t00nNZHTbO7xp8noU4Z0F8Sj8FZnflc+TxE3/Uw0r9DYWcEz4YXx0M4pJjv+
         GhSFvqa//MBFURDtaBCh0AZW/DIoNj88MNJ992BsBRAjOXJjpOF8FoG5zGagVqmJubRj
         pDsGMSo9Fp3AuYIenEFhgpGDxE69U4OFFOupC1Z486aVoGuqUqfs5crbBv10j1cK6LiP
         MK9mbsIz6K8gfJuExUVPXiUdXtljCxA42MFLZkk6bM/OcGac3a1CxDXZnapCdbf3TLBF
         7YcQ74+q/ScemV7MVie4hQ/LkNoG1DgwAyemc/1E7HMUOjFDM0j3Q3VN/H0aghloAVuB
         v1RQ==
X-Gm-Message-State: AD7BkJIk5qyBKb6wplvX57abWbBSH52do/qfKIoI/NQmRBcQ7+zX0J/HTR6n5QRNTfYGK7z6BgawGTUnw72KIA==
X-Received: by 10.107.134.94 with SMTP id i91mr21278444iod.95.1458397898556;
 Sat, 19 Mar 2016 07:31:38 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Sat, 19 Mar 2016 07:31:38 -0700 (PDT)
In-Reply-To: <56ED60FD.1030005@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289309>

Apologies, I did not see the patch, I looked for threads with GSoC in
their titles but missed looking for "rebase" / this microproject. I'll
go through the list and make sure it hasn't been picked yet.

As for the GSoC project idea, I was thinking of "Git remote
whitelist/blacklist", and writing another e-mail to this list for
discussion, however I felt that it might be a little less to do as a
whole for GSoC, so I was trying to pick something else to do alongwith
this.

I'll make sure I check the existing applications and threads.

Thanks,
Chirayu Desai

On Sat, Mar 19, 2016 at 7:53 PM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>
> On Saturday 19 March 2016 07:38 PM, Chirayu Desai wrote:
>> Hello everyone,
>>
>> I want to participate in GSoC, and this is my microproject to get familiar
>> with git development.
>>
>> I am a first year student, enrolled in the Computer Engineering program at
>> Silver Oak College of Engineering and Technology, Ahmedabad, India.
>> I have worked on open source software in the past, and have used git quite
>> a bit during that time. I'll include more details in my proposal, which
>> I'll send here when done.
>> I understand that this might be a bit late to get started, and I'll try my
>> best to get this patch in a good state and get the proposal ready ASAP.
>>
>> As for the change, I spent a lot more time trying to get the test right
>> than doing the actual change, most of it trying to get familiar with the
>> test framework and figuring out what to use. It didn't take much time
>> though, overall.
>>
>> I'm adding a few inline comments as I have a few questions.
> Hi,
>
> Thanks for the patch. I believe there already is work in progress on this (See
> [1] and [2]). You may want to try another microproject. It may also be a good
> idea to mention which GSoC project idea you would like to work on, as there
> already may be other proposals on their way.
>
>
> Thanks and regards,
> Sidhant Sharma
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/287568/focus=287569
> [2] http://thread.gmane.org/gmane.comp.version-control.git/289127/focus=289222
>
