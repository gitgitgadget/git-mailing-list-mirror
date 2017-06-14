Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 940BF20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbdFNKB3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:01:29 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33152 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbdFNKB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:01:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id a70so23010250pge.0
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/tlyKKfdxLpNHSPR9UyjVd3n1EFd/kx9RiRv9XSrWY8=;
        b=UvxsroWIsj1MUedNx/VY1/YjxUFRjQnBBxBdty+AFgNTn5InatRHmRuJWZy4T9Khvw
         5pVT5zpJY4VihwxuWGnfkW/HUyDdAdKegLacGoFatTlV+sUV/oVwO73TKc/s/gsQUvzz
         c8ZYV2XIRfJh5eeE5i3plHoh6KFAKnCg+K/UUq2go/2mB5uie0BHHLcAlrdfwfYVgVRW
         wLDS42NxxUlk4dmyJa0eTgNyvYwina//CoogJh+nBkWANNMBHCpUjYIYFblHaqR8sOa0
         EsvqCn2xWUXVU2ygspaiE6QRzeSMcLVTJSFI3kKoPYLCZhbXsL3sSchPiOD0DL7Ah76K
         c+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/tlyKKfdxLpNHSPR9UyjVd3n1EFd/kx9RiRv9XSrWY8=;
        b=PIQz1h/DYaFngcSFKPjbK4BoyQdJVkpxQMUm3gy1MPOAw93GWsI6ARSp+9scP/I9rL
         SQ4fOPEddu2co4LG1LgS2sYUg16iifkSMygnHQ9EgDml+eOPfD96otLq6DyG4lreo2H+
         wz9wbJhC9xZBLLMrLVCmFBdEU4YTq/cKLEYyF52FBjbQErWRu70Hw14G5pFKogdiae2b
         mwoFbVclY2nsGC8M+kSVsLsHxGt5F/bZvE7mx05ShusXsA6Ev70IVvb9BQaxeTCQ2Twa
         Me3fhbq1oeK4haITPObCEL15dRYqMV7d3rI1tLCkIyDO3Ql8MZ5hbxjVMsR8aoRkC6sG
         v/0w==
X-Gm-Message-State: AKS2vOw1bHwWfPTy+psbWSvGTlvUBZNT5O+0hlg2QS/2wm0ncegYn6Yw
        6XKEWn45F1AFFQ==
X-Received: by 10.84.218.134 with SMTP id r6mr4105290pli.288.1497434487215;
        Wed, 14 Jun 2017 03:01:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id 10sm987746pgh.59.2017.06.14.03.01.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 03:01:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        philipoakley@iee.org, jrnieder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2] Configure Git contribution guidelines for github.com
References: <20170613081807.33196-1-larsxschneider@gmail.com>
        <20170613090427.igjz7erniblh3wie@sigill.intra.peff.net>
        <FEFF27D2-1A56-4F37-8114-126613C144A0@gmail.com>
Date:   Wed, 14 Jun 2017 03:01:25 -0700
In-Reply-To: <FEFF27D2-1A56-4F37-8114-126613C144A0@gmail.com> (Lars
        Schneider's message of "Wed, 14 Jun 2017 09:28:03 +0200")
Message-ID: <xmqqk24e51my.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 13 Jun 2017, at 11:04, Jeff King <peff@peff.net> wrote:
>> 
>> On Tue, Jun 13, 2017 at 10:18:07AM +0200, Lars Schneider wrote:
>> 
>>> changes since v1:
>>> * mention submitGit
>>> * link to mailing list address instead of mailing list archive
>> 
>> You might want to link to https://git-scm.com/community/, which has a
>> section on the mailing list at the top. It gives the list address but
>> also talks about the archive, that you can send to it without
>> subscribing, etc.
>
> Agreed. I removed the mailing list email address as this is not
> useful until you have subscribed to the list.

Wait a minite.  As Peff explained above, you *can* send to it
without subscribing, so "as this is not useful until you have
subscribed" is quite wrong, no?

>> The text itself looks good, but two minor grammar nits:
>> ... 
>
> Agreed!

This I think I've already squashed in to v2 before pushing the
result out.

I do not terribly mind what you did in v3 to the list address,
and I do agree with Peff that mentioning the "community" page
is a good idea.  But

     Git community does not use github.com for their contributions. Instead, we use
     a [mailing list](https://git-scm.com/community/) for code submissions,...
     ... and bug reports.

looks quite wrong.  If it were

     Git community does not use github.com for their contributions. Instead, we use
     a [mailing list](mailto:git@vger.kernel.org) for code submissions,...
     ... and bug reports.  See [the community page](https://git-scm.com/community/)
     for further information.

I won't find it questionable at all, though.
