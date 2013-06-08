From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 09:13:10 -0500
Message-ID: <CAMP44s0MZ34J=C0r_V8MN-nYrDbi7buy5vOKtHU_jKRFvyGbXw@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
	<CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
	<CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
	<CAMP44s1p-VDMLNhoym5fH3XAn8CWqu2yqGq0mb+55qHOq-r_ww@mail.gmail.com>
	<CALkWK0mBnG7houMKHDorz3oSm=R7u4Va1s=AepSM0CPY6Gy4cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:13:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJtM-0003Oc-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011Ab3FHONN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:13:13 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:65251 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3FHONM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:13:12 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so619297lbc.17
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iGNpQN/s9UimBRayjb5X/YyfK8rckWzzUK5RyDDba+A=;
        b=FzMvvPrfykpIBEXdwC+4YO4W2geNjugR0l1or9tauqPDac3tqVpB2QhnRb+lqEBBJu
         Q7pmAbu9UcHWdOorIP4hUPglhUYU+iSaAN/7NCwl5AGYYs0u8YBUmP5inePO08YC6GR4
         GzzguPs05mXacCedFeQMKq0cO8BJRjpDbx6KcLCLsxgpT62nRgSO1btn74aZ1JFjoYKb
         R7PULmpHhCkKVLH18Ibv+Ar/j3KJaUW6tLQK8t2oXEYbtTSP0LomlC4LViMj0SLgh6Hm
         dUTZeTFpfHe7MWLNPRldqQmKt0T2OFQOkhULJw0t6ZdYQ3xZ9wiPJEN6xTGfwoUpjAhr
         Ukbw==
X-Received: by 10.152.22.73 with SMTP id b9mr1460989laf.36.1370700791019; Sat,
 08 Jun 2013 07:13:11 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 07:13:10 -0700 (PDT)
In-Reply-To: <CALkWK0mBnG7houMKHDorz3oSm=R7u4Va1s=AepSM0CPY6Gy4cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226830>

On Sat, Jun 8, 2013 at 9:04 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>> Ofcourse they're implementation details.  Even in this very test, I
>>> check $dotest/autostash plenty of times.
>>
>> The more the test relies on implementation details, the worst.
>
> I'm not convinced about this.

There's even a model called test-driven development, where you start
developing the tests even before there's any implementation. There's
also black-box testing.

There's reasons for that.

>>> Then show me how to do it correctly.
>>
>> Something like this.
>
> Yeah, this is definitely better.  Can you submit this patch?

Maybe, I don't know when.

-- 
Felipe Contreras
