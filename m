Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB77207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 15:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933630AbcJLPpP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 11:45:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:41541 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933584AbcJLPpO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 11:45:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u9CFj1P0028851
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 12 Oct 2016 17:45:01 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u9CFj3DQ015290;
        Wed, 12 Oct 2016 17:45:03 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
Subject: Re: Formatting problem send_mail in version 2.10.0
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
        <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
        <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
        <vpqfuo3l4fl.fsf@anie.imag.fr>
        <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
        <vpq4m4iamfs.fsf@anie.imag.fr>
        <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
        <vpq60oy589b.fsf@anie.imag.fr>
        <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net>
Date:   Wed, 12 Oct 2016 17:45:03 +0200
In-Reply-To: <5978b674-02eb-59ad-9468-93203533575f@lwfinger.net> (Larry
        Finger's message of "Wed, 12 Oct 2016 10:40:21 -0500")
Message-ID: <vpq8tttr2ps.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Wed, 12 Oct 2016 17:45:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u9CFj1P0028851
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476891901.92308@UDKn4uoOYeQcGTqjXy4Ecg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 10/12/2016 02:36 AM, Matthieu Moy wrote:
>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>>
>>> On 10/11/2016 11:18 AM, Matthieu Moy wrote:
>>>> Larry Finger <Larry.Finger@lwfinger.net> writes:
>>>>
>>>>> That added information at the end is intended to be passed on to the
>>>>> stable group. In this case, the patch needs to be applied to kernel
>>>>> versions 4.8 and later.
>>>>
>>>> OK, but where do people fetch this information from?
>>>
>>> This format is used in a patch for the kernel. When the patch is
>>> merged into mainline, stable@vger.kernel.org gets sent an E-mail with
>>> a copy of the original patch. Maintainers of the indicated systems
>>> then merge the patch with their stable version.
>>
>> Sorry, but this does not answer my question. I'll rephrase: when
>> people behind stable@vger.kernel.org get the message, how do they know
>> which version of the kernel they should apply it to?
>>
>>> I do not want it in the body of the message. I just want to pass a
>>> hint to the stable maintainer(s).
>>
>> If it's not in the body of the message, then where is it?
>
> This point is clarified in the thread
> http://marc.info/?l=linux-wireless&m=147625930203434&w=2, which is
> with my upstream maintainer.

Which explicitly states that the syntax is not [$number], but # $number,
right?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
