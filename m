Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98A6207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 16:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbcJLQBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 12:01:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36564 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbcJLQBR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 12:01:17 -0400
Received: by mail-oi0-f68.google.com with SMTP id e12so3775849oib.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iebQDdIN7+tHS1+KD+v1J9hFKdmCU2g+hmAwkNAA29M=;
        b=uS62COTJfmJJ0XAPLx/CvO7SEy/w/YBQiGgDTNPOTR9OU/HXycPcGCz7/zQaCRxcmk
         rv9tQLhNZKEBEwxQIZv7vCvTfAHJOstH1fkc6Tx3Cjl5gDDPZ8wL9iPJ+fOtEHsdYLxF
         0ES88VR5U94EZC7MV69Mku7CxGLzkXS1IGu5viWfQ3XXfB8Kx+j3UaeqRXx7TV2pGeV/
         1yQegaVX7HTYJlwkOGUHN8sVwKuRGr+sMRHSfyD9DY+O2vCM7NFbpB6M26Pt30yKI3Wh
         Oov0DZ8+YqUazBwd91A0X2Oh/AXLXRvMpOg2avKsSfAWGLFL618ky88zQznzFkqFvDNK
         lcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iebQDdIN7+tHS1+KD+v1J9hFKdmCU2g+hmAwkNAA29M=;
        b=GSgKWAElNfyj6gvd/W1FJuVMdZLAO1rL/OpsJQhi12pLhwvVYQzJEhryhYyqWtf5sJ
         j1QFmGQezPK6TFAbGzwWvkJK3hBxrH8ihYAppIllHYWQhlgLNFDleqB04xSG+G37a953
         pWPizWGeAJKANx0CyhlQcxbChn8M1LIxgYBo+CgI9hAFPxjXpw2wv0ifbUl+Uvg16MWF
         ucwZpKoFQgioq9EaKtPJJeIbj9pl2llQrxpxfWauwFVEvhsV00+1fYQT0MdtUMBHVA1W
         CiiXQ370X+WENyyzcfzToqdkE4QlH6reNuBfELO1k+/BUsglZ/jBi3zC0tuiFzkkwEGE
         Xocg==
X-Gm-Message-State: AA6/9RmQ0EmlLtOYQv9dO54P3fcwDSnODfx8uq6HFDnP6oCD9scVt0jS7mukypvpo6txUw==
X-Received: by 10.202.212.195 with SMTP id l186mr1102291oig.175.1476287998329;
        Wed, 12 Oct 2016 08:59:58 -0700 (PDT)
Received: from larrylap.suse (cpe-24-31-249-175.kc.res.rr.com. [24.31.249.175])
        by smtp.gmail.com with ESMTPSA id q9sm3067732otq.22.2016.10.12.08.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 08:59:57 -0700 (PDT)
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
 <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
 <vpq8tttr2ps.fsf@anie.imag.fr>
Cc:     Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <6b518c10-d7d0-23b8-f959-33ce4897a0a0@lwfinger.net>
Date:   Wed, 12 Oct 2016 10:59:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <vpq8tttr2ps.fsf@anie.imag.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12/2016 10:45 AM, Matthieu Moy wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
>
>> On 10/12/2016 02:36 AM, Matthieu Moy wrote:
>>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>>>
>>>> On 10/11/2016 11:18 AM, Matthieu Moy wrote:
>>>>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>>>>>
>>>>>> That added information at the end is intended to be passed on to the
>>>>>> stable group. In this case, the patch needs to be applied to kernel
>>>>>> versions 4.8 and later.
>>>>>
>>>>> OK, but where do people fetch this information from?
>>>>
>>>> This format is used in a patch for the kernel. When the patch is
>>>> merged into mainline, stable@vger.kernel.org gets sent an E-mail with
>>>> a copy of the original patch. Maintainers of the indicated systems
>>>> then merge the patch with their stable version.
>>>
>>> Sorry, but this does not answer my question. I'll rephrase: when
>>> people behind stable@vger.kernel.org get the message, how do they know
>>> which version of the kernel they should apply it to?
>>>
>>>> I do not want it in the body of the message. I just want to pass a
>>>> hint to the stable maintainer(s).
>>>
>>> If it's not in the body of the message, then where is it?
>>
>> This point is clarified in the thread
>> http://marc.info/?l=linux-wireless&m=147625930203434&w=2, which is
>> with my upstream maintainer.
>
> Which explicitly states that the syntax is not [$number], but # $number,
> right?

Yes it does; however v2.10.0 mangles this into

Stable <stable@vger.kernel.org#4.8+>

and my mailer refuses to send that.

Larry


