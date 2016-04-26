From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/3] githooks.txt: Minor improvements to the grammar & phrasing
Date: Tue, 26 Apr 2016 18:55:35 +0200
Message-ID: <CACBZZX4R99fJXoBjO_Ca7b+uAPf=7pH=gW8mq5Ae_BSA3v=G=g@mail.gmail.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
 <1461529229-15222-3-git-send-email-avarab@gmail.com> <xmqqinz5les6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:56:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6HI-0000AL-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbcDZQz4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 12:55:56 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34647 "EHLO
	mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcDZQzz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2016 12:55:55 -0400
Received: by mail-qk0-f194.google.com with SMTP id i7so1388212qkd.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xf2jNC+w7SSiPJ4A2D7+hBcROT3mwNiQA/6alDjilUA=;
        b=M14NO9lPcDdQsngolPMmEhFTaYrJcYMuWshDRRZvBKRx5APCU0RL6o8KJHutPuapOY
         9Aa/2kzo7nTNae/xnF7UCexT2qF2PldQRCfqOzotu/WZu62Nb0v2soh8b3H6OoTMiTHI
         XkCxMTr42cnj7SbbB1+oceSLW+Niaeggx1TDj5LLb+PFDq3w5IGRTRy12SWDN/LhstqY
         FU1jMslLsdEzwWfasjlKXhazS7+tc6bNuwz82t4hdInZTuG+u4a65a18ebfef67sLdbR
         qFTTlanBwOWJAzLqtbruJWX7DeZd8AIxahnJ4gvSA8O3Of5glfmuzscECNnyBwihPCqF
         EBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xf2jNC+w7SSiPJ4A2D7+hBcROT3mwNiQA/6alDjilUA=;
        b=JwpdSQPZM2EUkdh1372cCQl0DfnblyJ2uWUfuDJ6ma5ZRSs6CGT6P9iS6/loIvAoPy
         7ofZklXfQjKIyxLbRxPIyL29qeceUjE9FU6czoJkJQM0VcceeDjmJ/bGJMF+m6ARcI8p
         CNdnQ9niPMAaX3ikh7WbGjkDfYETj/Csc9Jk4VKXd9qkR7juXm1uVV5RUgnHvP6002a9
         3/Dt8mU81D1lGLcPA28OzFb4Da1NYUeJWV8oxS27ZuqTT3k6CQaw1u4bp6AJ6nBjBV3T
         C83CWljEanvkxWIiEutfXRnRIKdcwA1rlMxGzykzxE9erx9Q97gS1FfC7gOIwzkjHsq8
         Vt5g==
X-Gm-Message-State: AOPr4FUmLz45gLAaGJYR035D15YjvWNZOdTRUdUekRFa3XDohSTrJLplUyOSeHeBy7841O+rAr4mZ2edD17qEg==
X-Received: by 10.55.161.7 with SMTP id k7mr3524739qke.112.1461689754516; Tue,
 26 Apr 2016 09:55:54 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Tue, 26 Apr 2016 09:55:35 -0700 (PDT)
In-Reply-To: <xmqqinz5les6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292616>

On Mon, Apr 25, 2016 at 8:33 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -This hook is invoked by 'git am' script.  It takes a single
>> +This hook is invoked by 'git am'.  It takes a single
>
> Good, as it does not matter to the readers that "am" happens to be
> implemented as a script.

Yeah, no need to mention it being a script. But aside from that I was
mainly trying to fix grammar errors:

* Incorrect: "This is invoked by 'git am' script"
* Correct: "This is invoked by the 'git am' script"
* Correct: "This is invoked by a 'git am' script"

I.e. a few things in these docs were missing the definite/indefinite ar=
ticle.

>>  parameter, the name of the file that holds the proposed commit
>> -log message.  Exiting with non-zero status causes
>> -'git am' to abort before applying the patch.
>> +log message.  Exiting with non-zero causes 'git am' to abort
>> +before applying the patch.
>
> I am not sure why you dropped "status" from here.  The result is
> harder to grok, at least to me.  Perhaps "with a non-zero status"?

I'm not 100% sure about this actually, but I thought:

* Incorrect: "Exiting with non-zero status"
* Correct: "Exiting with non-zero"
* Correct: "Exiting with a non-zero status".

I.e. the first one is missing an "a", I thought I'd just make it more
brief, but sure, I'll make it "a non-zero status".

>>  The hook is allowed to edit the message file in place, and can
>> -be used to normalize the message into some project standard
>> -format (if the project has one). It can also be used to refuse
>> -the commit after inspecting the message file.
>> +be used to e.g. normalize the message into some project standard
>> +format. It can also be used to refuse the commit after inspecting
>> +the message file.
>
> OK.  Or we can even drop "e.g." and the result still reads perfectly
> fine.

Done, and willdo too for the other occurrence.

>>  This hook is invoked by 'git commit', and can be bypassed
>> -with `--no-verify` option.  It takes no parameter, and is
>> +with the `--no-verify` option.  It takes no parameters, and is
>>  invoked before obtaining the proposed commit log message and
>> -making a commit.  Exiting with non-zero status from this script
>> -causes the 'git commit' to abort.
>> +making a commit.  Exiting with a non-zero status from this script
>> +causes the 'git commit' command to abort before creating a commit.
>
> Good.  And you kept "status" here, which is doubly good.
>
