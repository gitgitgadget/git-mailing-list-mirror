From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 3/8] submodule config: remove name_and_item_from_var
Date: Fri, 30 Oct 2015 11:37:18 -0700
Message-ID: <CAGZ79kZekEa5CwaisXNvpXLxfEp9zdDQKYULEhwiikwj1AyiFA@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-4-git-send-email-sbeller@google.com>
	<CAPig+cSpnGE5Acgvd+b0arcFx8oStuRRKR4fcSwZG2fbEZ6wSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEYJ-00076n-0S
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760163AbbJ3ShU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:37:20 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:33188 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbbJ3ShT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:37:19 -0400
Received: by ykft191 with SMTP id t191so84636640ykf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/kOCBTEpFHVJmY+83y2Qh0loV9I1ZzYAwVykjQUoKBw=;
        b=QOH915v2cW9WGiS3U/lqU/1f66tj6CPGZKXxZPpsEYOGfd4o0tmybs2JPats+oifzY
         iKW0XPBUYTmMATwRr/0WyssNzHv7fYkeCtgOKBV6hO36M0uLvWQIVx+RDuySnq8ccrjg
         //2qZDVT/UVGTZIitP/4kEfHyD4LpIV1bE/Y3DyyvpvPx7q5lCQ3cHWPMryagWaY2UmP
         RQgaKjohw23jQS0ccSaBW0fvbxe9JDkCVQlyv0b7d6pebfOolwuTAMZ7JgW/2aq8fMmS
         H7osk8VfrLGzTkjL8Xbc9BlDE8IWZsDXNByQXPYXGm83N8vbPefrHcdS7Tqoz3ErTGxK
         K1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/kOCBTEpFHVJmY+83y2Qh0loV9I1ZzYAwVykjQUoKBw=;
        b=Fnhm9oG2MoQO48L7rv5b5xMzkJt+dFXdOIVDtrChPqpWrI0e0vBmcH0BoPsX1UmsD4
         kppdsRRr4uqUQ2gygqrWKiEQeioFQxls28nlkjt9LE0aXDoR3sKfCfAPlA8cFc0LjX0s
         eGDRWRx7C3e/w1eTKSN7xOxD38t+icFwSIqPLPcL6irQPoBfWLSQ92mI7Rl48EVqpON1
         OVHPgiEZLRnqrHArNZDBd+i2HiOKTwp1HneTzG+Yl4M8nFWPh8Kt+sTHXITrtFVAWwuu
         +is3a/MV/CShmNEGo7/5d5Axj0TLuL/pB+mNaXQp5p6a0vkZVlJLOaXw8T4nhqEXE40x
         ZHWQ==
X-Gm-Message-State: ALoCoQkmZ1r2ohRCJpVOEPOs+me3/xydw7jfj0BrP3MZH6BHHhqbK/FYf9JW07bCWeSF7EOS68v5
X-Received: by 10.13.199.133 with SMTP id j127mr7248946ywd.176.1446230238188;
 Fri, 30 Oct 2015 11:37:18 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 30 Oct 2015 11:37:18 -0700 (PDT)
In-Reply-To: <CAPig+cSpnGE5Acgvd+b0arcFx8oStuRRKR4fcSwZG2fbEZ6wSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280516>

On Thu, Oct 29, 2015 at 6:23 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
> On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
>> submodule config: remove name_and_item_from_var
>>
>> By inlining `name_and_item_from_var` it is easy to add later options
>> which are not required to have a submodule name.
>
> I guess you're trying to say that name_and_item_from_var() didn't
> provide a proper abstraction, thus wasn't as useful as expected.
> Perhaps that commit message could make this shortcoming clearer.
>

ok

>
>     if (parse_config_key(var, "submodule", &subsection,
>             &subsection_len, &key) < 0 || !subsection_len)
>         return 0;

done

>>         submodule = lookup_or_create_by_name(me->cache,
>>                                              me->gitmodules_sha1,
>> -                                            name.buf);
>> +                                            name);
>> +       free(name);
>
> Since this is all private to submodule-config.c, I wonder if it would
> be cleaner to change lookup_or_create_by_name() to accept a
> name_length argument?
>

That looks amazingly clean. :)
