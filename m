From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 2/2] travis-ci: build documentation
Date: Wed, 4 May 2016 11:11:44 +0200
Message-ID: <CAP8UFD2XXE2Hh9NxMFS3dvaJk90LgwdbDcXmHvVir6MEKu2B3Q@mail.gmail.com>
References: <xmqqziscw2g7.fsf@gitster.mtv.corp.google.com>
	<1462220405-12408-1-git-send-email-larsxschneider@gmail.com>
	<1462220405-12408-3-git-send-email-larsxschneider@gmail.com>
	<xmqq60uwrxyi.fsf@gitster.mtv.corp.google.com>
	<6483CF6A-5C14-42C9-BE1A-6D6AA33999BB@gmail.com>
	<xmqq8tzrp2pd.fsf@gitster.mtv.corp.google.com>
	<32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 11:11:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsqW-0004Kp-Tm
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 11:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbcEDJLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 05:11:47 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:32781 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbcEDJLq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 05:11:46 -0400
Received: by mail-wm0-f50.google.com with SMTP id g17so33438254wme.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YinT/RPAY31EYMVu5KJExjDq1mhePVl6G2r5AwMw/G8=;
        b=qTzy+MIVDxbZN1g36X9H3FAMnmoDL8MzCE6u132ElwsUDrxrGXizt+zFQK1fq1EFRv
         kZOEhnZuuaZ3+F0d71+hmr630GJmN56sjwsQCA8Bu6P4QJkk6KrOFLN+/zb1cBhLFiDI
         0Ed3YdadbJ/Zo4mifjJKjF+2t8ax7bdGmVuzGw90Qj531Yyi9BPkA39r7zqdSrzCMNUy
         eaAt8RG8ohRmT6OmQi/hlc1Rz6E4xmJ8ln2Jri1tojip+iz/prN3TI0+SnyRAhb6M+VA
         qzN7AfeckJoQAlb7aljVN/OW1jKwhi+GtEA8paas/1aV2UCP5OTuTPwPhygkru/xBAeq
         gaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YinT/RPAY31EYMVu5KJExjDq1mhePVl6G2r5AwMw/G8=;
        b=euDGVMQYIgJ7Kt4jehiwEdaJa6ENm0cnHr7EbWmtnTez6Zlc0nTOIsdaMtJZo8cyfo
         0v+PAz97iACpJ0qxLO3BMsAnrngJE1HV6/KvZAbpTPxpgZ+lgHr2uisbkYpvfmqhuK0s
         A2G6EdHZq7XTSGERO1gJJr4v36WQK3wZ8tckxoDyY24wsd1+r9Es4jehAIi5FZcbQpsy
         GUnNcGzmx1xokj4DVN0FFVGOEda9XFxEtxFs4Aw0QpT8pWxsuNGmfwr9kfCrMzoBdBnN
         CwaQMBynGa9BRnBV7u5VvWqkHs1jrpn9g1h01vQdGOkvG+5g9OFU+mgZSjV6cBY0q5Te
         txGQ==
X-Gm-Message-State: AOPr4FWTxC6fOroUTsOJIiTzDQjULrm54yPmlOIYoRLtFSNIJYb008dyRMCQeZXwHJR9vIvaszKquRny02cmaA==
X-Received: by 10.28.129.22 with SMTP id c22mr30784302wmd.89.1462353104525;
 Wed, 04 May 2016 02:11:44 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 02:11:44 -0700 (PDT)
In-Reply-To: <32CC7549-3A50-42F3-A6CC-9B15EFA01A46@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293527>

On Wed, May 4, 2016 at 10:04 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 03 May 2016, at 17:43, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> On 02 May 2016, at 22:45, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>>> larsxschneider@gmail.com writes:
>>>>
>>>>> +set -e
>>>>> +
>>>>> +LINKS=$(grep --recursive --only-matching --no-filename --perl-regexp \
>>>>> +    '(?<=linkgit:).*?(?=\[\d+\])' Documentation/* \
>>>>> +    | sort -u \
>>>>> +)
>>>>> +
>>>>> +for LINK in $LINKS; do
>>>>> +    echo "Checking linkgit:$LINK..."
>>>>> +    test -s Documentation/$LINK.txt
>>>>> +done
>>>>
>>>> Please separate the above link check out of this step and do so
>>>> separately after the move of test body to a separate script
>>>> settles.
>>>
>>> OK. I also wonder if the link check should rather go to the
>>> "check-docs" Makefile target?
>>
>> That sounds like a good direction.
>>
>> Which in turn means that people on all platforms are welcome to run
>> it, which in turn means that the script must be even more portable,
>> with avoiding GNUism and bash-isms etc.
>
> OK. I am not that experienced with shell scripting and therefore it
> is hard for me to distinguish between the different shell features.
> Do you know/can you recommend the most basic shell to test/work
> with? A quick Google search told me that "dash" from Ubuntu seems
> to be a good baseline as it aims to support pretty much only POSIX [1].

You might also want to check:

http://www.shellcheck.net/
