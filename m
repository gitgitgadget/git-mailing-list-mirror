From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 10:27:19 -0700
Message-ID: <CAGZ79kbBCM0CdBoeWTx9kWBBN1f-kuibpUNh9FacOb2xxCDPcw@mail.gmail.com>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
	<20160429121429.GB27952@sigill.intra.peff.net>
	<vpqeg9o7gh4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	stefan.naewe@atlas-elektronik.com,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:27:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awCCL-0004DE-Mb
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbcD2R1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:27:22 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34824 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbcD2R1V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:27:21 -0400
Received: by mail-io0-f170.google.com with SMTP id d62so114357668iof.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FZzLvWebpiAcDONsru6OECbuJykCpYMnBLAM7byKyCw=;
        b=Yc9RPKkassxLgNw5BsNzKD+mL3EC/zHxbwfyrKfaKrpvAk3scl8FQbdxSduA1cd3t6
         uPEqAIOCZe0zVr3cwr5hn4QpgRTFhjeAvrE5U1+nczASVZpaZs9uRjxPGALOlb55Qt/A
         2QNwPMvKgmJNV/VCBELgMJEZ1PRqQYZ25SG4ifyWDAZ+HTTw50689LafW3R0Ne8c4oiG
         pDBdi0fES3LFM6FeDdzkVA+IN+0wihrbQxn9elP7rUw+rs4sL8PSAab+86GyRX6m8whd
         HAV8O7KME01l22f5TLriKi5ljqgl8PSXnhmEoJ3SkxrPPFqzQ62fq+Lu/RKVAtuRmb0+
         q6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FZzLvWebpiAcDONsru6OECbuJykCpYMnBLAM7byKyCw=;
        b=Jg1fByFVp74k3k8q0/PrwUsww6s26XZPB1fDmCM6xZTuO19SGZ7vvB/TLPhAil2RSe
         0qie26sE6VYYPaRN3xLivJlgaW2cWD/vp315LCX4cYe9WcAuEF+k9xUEVR8GtKvGyPLU
         o1wiYgsdwmjMehgrNUwiM1N0ah2u6LC0lEmHU8lk6dQyeKbjs6hzTiDLxrqVyBerHbfT
         WSIugRHi/CoxDUYRUV0RHFuvOEGCSXWtNlb5CgfBoKZByQU3Xb6+/mYNneHGbCcD+7rS
         znPkGqH5whWnFfUWeDVEpF4qjgbTr5QcQ8hbVDMaBkwzgCu8/+5bTW5kIqQNH1Krw3jE
         uEIg==
X-Gm-Message-State: AOPr4FVRKIrIUt3vBbo4LdrRhnGzgnbSoADwVsHLUvTwe6Ligsgk5C4sy/SK3D+AtOfANQfpDcRrkUBBmg+CUePq
X-Received: by 10.107.161.68 with SMTP id k65mr29047346ioe.110.1461950840027;
 Fri, 29 Apr 2016 10:27:20 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 29 Apr 2016 10:27:19 -0700 (PDT)
In-Reply-To: <vpqeg9o7gh4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293030>

On Fri, Apr 29, 2016 at 5:21 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Apr 29, 2016 at 11:35:34AM +0200, larsxschneider@gmail.com wrote:
>>
>>> +# The follow numbers need to be adjusted when new documentation is added.
>>> +test_file_count html 233
>>> +test_file_count xml 171
>>> +test_file_count 1 152
>>
>> This seems like it will be really flaky and a pain in the future. I'm
>> not really sure what it's accomplishing, either. The earlier steps would
>> complain if something failed to render, wouldn't they? At some point we
>> have to have some faith in "make doc".
>
> I agree. My proposal to check for a handful of generated files was just
> because this extra paranoia was almost free (just 3 lines of code that
> won't need particular maintenance).
>
> In this case, I'm afraid the maintenance cost is much bigger than the
> expected benefits.

So you proposed to check a handful files for its exact content?

This could be less of maintenance if we'd check with a "larger as" operator
such as

    test_file_count_more_than html 200

using an arbitrary slightly smaller number.


>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
