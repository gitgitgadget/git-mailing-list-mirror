From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Sun, 19 May 2013 07:00:12 -0500
Message-ID: <CAMP44s3OCPZYK8Cm25hLLGVOcQ5VAZ103-apHeDf3+gR5GjOcA@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
	<CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
	<7vobca3465.fsf@alter.siamese.dyndns.org>
	<7vzjvu1jes.fsf@alter.siamese.dyndns.org>
	<CALkWK0=rHFQ14G8baYpY7gYo+Qb+5a0qOKZGBTrp6BamKC2vRg@mail.gmail.com>
	<7vk3mx1rox.fsf@alter.siamese.dyndns.org>
	<CALkWK0mLtc8dmMPOcLMez1agF1+ZMUDAUwtwmiKSxOCfyiW0Bw@mail.gmail.com>
	<7vk3mxze8v.fsf@alter.siamese.dyndns.org>
	<CALkWK0kYKZGhthdrb6-7RD_c2A7E9rscAZU3=JHM-4rYre6w=Q@mail.gmail.com>
	<7vmwrr1pem.fsf@alter.siamese.dyndns.org>
	<CALkWK0=6L529C452MaNGksL5KeVb+cL1SeC=FwA9veS=tNQurA@mail.gmail.com>
	<CAMP44s3HaEc1UoULYHYnzd_B_VayfedG_Gd1gT27=SeMdp4=eg@mail.gmail.com>
	<CALkWK0mOH8ZpmDR3HWW3j-q9fEpSawNonLDDWixD9LrPcKNnDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:00:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Hm-0003Lj-Tn
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490Ab3ESMAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:00:15 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:57667 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3ESMAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:00:14 -0400
Received: by mail-la0-f42.google.com with SMTP id fg20so3358543lab.1
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=hJSoWIZ8dC+2A7o1EnaTSZJXWHwQ+PkcTSNHgUmWJJM=;
        b=jF9viyas5kAt/jzedxSjDdMgoEFynsRDVY3rpAWQ+ashlbLaGjgGoWNErgMoHc2C/n
         VfogzmO7aIpJfAWDAxlE1VRcY2w+rwCeSh2jETY8if1BE/pG/QuQsugZrPJK6PKiodDp
         6zLsC3c2yDGfXsAFlthhnw7LGdw4XsY0gTgtwcDVFRS5XiAA0O1wSncd58yccFEZnRfp
         guW0avch0MbXb0odEtyIVUpLIUINd/ocS0Lu2KFxThj/zzIE65GHmZUZuw2E4Kx/r6zz
         xzzzmFEy7lFfmkCjaBlXwzAz7u2s5DCr+Jy9SULFHsj4MpHHsDNeKXLwMHGggmESJP8p
         YRXQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr26116817lbb.12.1368964812865;
 Sun, 19 May 2013 05:00:12 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 05:00:12 -0700 (PDT)
In-Reply-To: <CALkWK0mOH8ZpmDR3HWW3j-q9fEpSawNonLDDWixD9LrPcKNnDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224875>

On Sun, May 19, 2013 at 6:54 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> You can't represent push.default = single either.
>
> Right.  And I propose that we extend the refspec to be able to
> represent it, instead of having "single" sticking out like a sore
> thumb (and possibly introducing more sore thumbs like this in the
> future).

Yeah, go ahead and have fun making refspecs Turing complete. Why?
Because you decided to call something a "sore thumb". Calling
something a "sore thumb" doesn't make it so.

We, the sane people, will people will keep using simple configuration
options. Hopefully some day there won't be much need for many of the
current configurations, including push.default.

-- 
Felipe Contreras
