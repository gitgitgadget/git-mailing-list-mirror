From: Simon Glass <sjg@chromium.org>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 17 Sep 2015 22:03:06 -0600
Message-ID: <CAPnjgZ1z8UakVy2D8CVuTCdvB6hhYDPJXQk9QBp66hQ1rxrKDA@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAFOYHZB3dKgi3rERHXuWynTjYQu+iPVdbWqmtoD+irYopfoRCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 06:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcmta-0000nn-ES
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 06:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbIREDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 00:03:30 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36494 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbbIRED1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 00:03:27 -0400
Received: by qgx61 with SMTP id 61so29999263qgx.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 21:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=49HXurPvBJsH61ZT/NpZdAjtyu6tvu8ak/1wvX3rEpc=;
        b=CD2LlHhDQzA/CWu5U/mpZPSmV1/2l3IyN4SjjKbnS9ufW5xjC7ZnMuKriSb0sEIOUL
         QPjt6qv1gowRUh0qbGCOF9c7OT4wfvdO20MkxOQhhsZ9Sqj6acjrHz+Uwjkbli9u2o/q
         t7NEabTVHc58xGF+7klLq6R7K2kOk9gDi45i7kS3PDV8jCwbEtRBdGpybwpTb3tEVSov
         29QMgtT5TSy/keFHDMwniTHRcM/YNKW1khx/bSoSS54Cjs0UNHNR7f9kXPiH9Ev1Ltm+
         Uuxbmya4vYGgaIeshgy039kglka7IRUGpqBHHgFL1bixXQjsSlKSgE9wFIeoEkVoHbDm
         e0Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=49HXurPvBJsH61ZT/NpZdAjtyu6tvu8ak/1wvX3rEpc=;
        b=lla33NshXEzNN0oAxuUA62jl17inAWfiBZxCcfxEmbSFCaWE68kPQlSAgx7GgqgVEv
         himTkX4gg6TS9inDbeJ4KZnLtrPZ+PIPBN8jJTVMOklfpOcNUXs6xRd1k+Wm/CP2tvwY
         FgHRLw+2lB6/nYaD9Ar8NaYZ9V67YHfMAMTc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=49HXurPvBJsH61ZT/NpZdAjtyu6tvu8ak/1wvX3rEpc=;
        b=djpGqNCz5BiYXTxJkr4yyjk0dzcNMfB2DawWpSqeuwWCOew6StDzT8Uj/XKrb6gKWo
         LdE1G6otAjPcTsXi0jUSNQkugD6B8zqqyOIvONmMX/eEfaQYqAEsXhX++5u3M39h1qVF
         g5uDUKFkQs7BkcM3xsFGImIQPv0542TWONMc+1EHFl6Qds3U6YJi7LRRzNs3+1n80hGy
         Qy1ow1SlIQfSLwaeKxTk6gB4jxgtYSWpKjdZ5WR0zsK4xdBbyhgHHv3lDG9fILiMmiJH
         4lki+0v+GzhSVn81eL5+9kyCK7GuJIUHjk1FZnynw9tGfKufwJaseHUywVnOR/yvhWlz
         c8tA==
X-Gm-Message-State: ALoCoQkmCn67PNiAj+1w0OvxZ77qinRuOzYaFqUYv2Mu7FlI/Yx/Qvtkwd5ZApAMC6GoO+WSLwZC
X-Received: by 10.140.37.101 with SMTP id q92mr4013729qgq.3.1442549006436;
 Thu, 17 Sep 2015 21:03:26 -0700 (PDT)
Received: by 10.140.80.176 with HTTP; Thu, 17 Sep 2015 21:03:06 -0700 (PDT)
In-Reply-To: <CAFOYHZB3dKgi3rERHXuWynTjYQu+iPVdbWqmtoD+irYopfoRCg@mail.gmail.com>
X-Google-Sender-Auth: ivQBQ9KGDpLjqeKmfvwXqlM69UE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278178>

Hi Jacob,

On 11 September 2015 at 02:30, Chris Packham <judge.packham@gmail.com> wrote:
> On Fri, Sep 11, 2015 at 4:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Hey,
>>
>> does anyone know of any tricks for storing a cover letter for a patch
>> series inside of git somehow? I'd guess the only obvious way currently
>> is to store it at the top of the series as an empty commit.. but this
>> doesn't get emailed *as* the cover letter...
>>
>> Is there some other way? Would others be interested in such a feature?
>>
>> I get very annoyed when I've written a nice long patch cover letter in
>> vim before an email and then realize I should fix something else up,
>> or accidentally cancel it because I didn't use the write "To:" address
>> or something..
>>
>> I really think it should be possible to store something somehow as a
>> blob that could be looked up later. Even if this was a slightly more
>> manual process that would be helpful to store the message inside git
>> itself.
>>
>> In addition, this would help re-rolls since it would mean if I go back
>> to a topic and re-roll it I can just update the message. If it were
>> properly stored in my local history that would also mean I could see
>> revisions on it.
>>
>> Any thoughts on how to do this?
>>
>
> A bit of a plug for patman[1] which the u-boot project uses (although
> there's nothing u-boot specific about it). It lets you put the cover
> letter and other meta information in the commit messages as you go
> then will extract that information and generate a cover letter and
> clean patches. As of fairly recently it's also installable as a
> standalone application.
>
> --
> [1] - http://git.denx.de/?p=u-boot.git;a=blob;f=tools/patman/README

If you do end up trying it out I'd appreciate any feedback you have.
I've sent 1000s of patches through it over the past few years.

Regards,
Simon
