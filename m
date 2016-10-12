Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFEBB207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbcJLPkZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 11:40:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33224 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbcJLPkX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 11:40:23 -0400
Received: by mail-oi0-f65.google.com with SMTP id i127so3749250oia.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=yCqnnxYLAX/qhost8+RqV6GgQqEZpATYHCp+oBEOVhw=;
        b=Dp6wkWomePfoXyfveCOcaY0onW8IWH9OsuO1Wk7epOeqCF2jwTF9EAeMUR6uIi7gKG
         BRda+uZ2tJlLTMW4D3JfAk6E9cdJQNthnPPLl7phz/4wvb/D4EGiPsXI+QVQCn75I+jl
         jJo/FpPwWjdzl5LAbObkje0TuGL0Geyp0PsrhYKIPg/p8YCcV6bhhuGFkurvvfQG63U8
         AyF6OBQvkenGls7jY2fuNqBKQJAxfz8f+7K3KkSZzO3WdS4dA7+G7QME/PXOjvS2gAU5
         2IH4JQPCTuhtfQjnv5eGbbrJ5USxvLENhuGfgxbDvGqiJ116BooKhicAPDZ115RYpzIZ
         O0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yCqnnxYLAX/qhost8+RqV6GgQqEZpATYHCp+oBEOVhw=;
        b=TMwU3tZyjvOkr+AbGsm69V5ZTzCBS4vISqMteEXMinHt6NAOvAHbHkBmyUJlris56A
         07+lhUH3MZSxmk80XlTaW37wyb9uPulkT2Z6Mx2Kzz3P+R++6H9BHAEc7g47J+LuW/GN
         8qj3bRNtUK2xV9L/Vd6cpTT8gyJEh/60vdOy8XmJD87GgSQzPUmpfCVW0wjs+sJ3/J0V
         yIMsI0P14j+SlZQP5qjC13sUqcKz9K7xhZQpk/wP/cc2aQy5mojmU+mvBIWC1tkiwYy2
         rjsKsqoJQpXLoaXO3LbdK6hXj3n9lqQ2DFPL9GC19qZFVONHkFYkk+yXxKazjR+7PlQ3
         seoA==
X-Gm-Message-State: AA6/9RkpUPLwS4EJNKWxSoG/T6zzIccb1vjucu28cooZhhemQptJmJ5ihi4X6Fs1pgQd9Q==
X-Received: by 10.157.17.90 with SMTP id p26mr931588otp.197.1476286822973;
        Wed, 12 Oct 2016 08:40:22 -0700 (PDT)
Received: from larrylap.suse (cpe-24-31-249-175.kc.res.rr.com. [24.31.249.175])
        by smtp.gmail.com with ESMTPSA id 77sm3014333otf.18.2016.10.12.08.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 08:40:22 -0700 (PDT)
Subject: Re: Formatting problem send_mail in version 2.10.0
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <vpqfuo3l4fl.fsf@anie.imag.fr>
 <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
 <vpq4m4iamfs.fsf@anie.imag.fr>
 <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
 <vpq60oy589b.fsf@anie.imag.fr>
Cc:     Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
Date:   Wed, 12 Oct 2016 10:40:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <vpq60oy589b.fsf@anie.imag.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2016 02:36 AM, Matthieu Moy wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
>
>> On 10/11/2016 11:18 AM, Matthieu Moy wrote:
>>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>>>
>>>> That added information at the end is intended to be passed on to the
>>>> stable group. In this case, the patch needs to be applied to kernel
>>>> versions 4.8 and later.
>>>
>>> OK, but where do people fetch this information from?
>>
>> This format is used in a patch for the kernel. When the patch is
>> merged into mainline, stable@vger.kernel.org gets sent an E-mail with
>> a copy of the original patch. Maintainers of the indicated systems
>> then merge the patch with their stable version.
>
> Sorry, but this does not answer my question. I'll rephrase: when
> people behind stable@vger.kernel.org get the message, how do they know
> which version of the kernel they should apply it to?
>
>> I do not want it in the body of the message. I just want to pass a
>> hint to the stable maintainer(s).
>
> If it's not in the body of the message, then where is it?

This point is clarified in the thread 
http://marc.info/?l=linux-wireless&m=147625930203434&w=2, which is with my 
upstream maintainer.

Larry


