From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH 2/2] log: "--no-show-signature" commmand-line option
Date: Wed, 8 Jun 2016 11:34:49 +0530
Message-ID: <CA+DCAeRUObYLy1cP-i-iVoWnw8SEaMJZEWu20q0M2eVJZ3uMJg@mail.gmail.com>
References: <20160605153933.15231-1-mehul.jain2029@gmail.com>
 <20160605153933.15231-3-mehul.jain2029@gmail.com> <xmqq37oqxib8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 08:05:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAWbv-0002I3-5q
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 08:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161770AbcFHGEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 02:04:51 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36321 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161745AbcFHGEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 02:04:50 -0400
Received: by mail-qk0-f176.google.com with SMTP id i187so106621107qkd.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 23:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GB5owZbaUsPZvoJEC9Sde7FfEif7wsyptlFxG2eWAhs=;
        b=K1ISbkQ80rQ4Lq0iEwoDAKoQB0dkKZfepgqPlxlMsnoReaL0Pus8SZQwSS1BHgzm8Q
         twZcqBezRsakpwV94Sa8CiqIT6d4tfsxNdI16/YFDjdE6KCU4e/rn9XwJGyRQggkRFN9
         B3/4E78hQVgFWn7RAdRKMfrdceRLgRyKzeK3Bvr6ndLyrap9HisMwfs0oiMcpk0FX1Tv
         duoPNXvesuLOarkOmDrlN7cVSGRFE858hK6kkls7DJHHnltENM+MCHmj3GjA6SdMdYbR
         3uNivWL+K/k6WgzWKXDyLT+K2j95qRbu4S66kT0/W+K9z3Ig4a5xtyjI2X9/EGYDHiLV
         pShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GB5owZbaUsPZvoJEC9Sde7FfEif7wsyptlFxG2eWAhs=;
        b=Y1gCgJXdPsG0UMov+2/sgiTg1wOJDUvXwTayG84Jqa4NDTmBN1pNcfj/c/PRyaao/C
         Fx4b2e+m5Xm698/RKOH4bu1YWHky/yy0kSH5qoHfn+dJWX3IFUu2PTlsHBXfb/0b9OVK
         SjMQufGaeMuA1vvEfL1doTEHSrD/NIHE3QPnzJwDd+bl3KwCZnjSRF4I8MNS6XQoDmTe
         3bR1COzuC5jxP01zj6+CL/nJgMyRsydjZN80arNTEayaHh/g3U0Y9V827NIts8pCWDwA
         TtwIypqGHwGo1T3heGNnX2VjFL9GC00Jghi7mwE4ErhsHDQmGPImtqEDZ+rxQgLKQbjv
         ii2w==
X-Gm-Message-State: ALyK8tJ0j8eFbIc+HVHGzUC6q2Ijp16QDZMpQYdNKtiNZ8ZGEgzDBYkROHeVaTdAVxZDT961IomBY78OjsCdpw==
X-Received: by 10.55.126.7 with SMTP id z7mr2936373qkc.137.1465365889660; Tue,
 07 Jun 2016 23:04:49 -0700 (PDT)
Received: by 10.55.207.3 with HTTP; Tue, 7 Jun 2016 23:04:49 -0700 (PDT)
In-Reply-To: <xmqq37oqxib8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296756>

On Tue, Jun 7, 2016 at 12:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Mehul Jain <mehul.jain2029@gmail.com> writes:
>
>> If "log.showSignature=true", then there is no way to override it using
>> command line switch.
>>
>> Teach git-log and related commands about "--no-showSignature" command
>> line option.
>
> Doesn't that suggest that 1/2 alone will cause users problems?  The
> users can by mistake set the configuration variable and there is no
> way for them to override it from the command line.
>
> If you swap the order of the two patches, the topic makes more
> sense.  I.e.
>
>     [1/2] log: add "--no-show-signature" command line option
>
> makes "git log --show-signature --no-show-signature" to run without
> GPG checks, which by itself is a worthy change.  And then
>
>     [2/2] log: add log.showSignature configuration variable
>
> makes revs->show_signature default to the configured value, instead
> of always initializing it to false.

Yes, it does make sense to swap the order of the patches.
I will do a re-roll soon.

Thanks,
Mehul
