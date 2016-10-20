Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12CA1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 18:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbcJTSNm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 14:13:42 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35626 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752934AbcJTSNl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 14:13:41 -0400
Received: by mail-qk0-f181.google.com with SMTP id z190so109420075qkc.2
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NjSi9eqJziRBvbb4ndcXaUHTovGmaZDC1oesBWy2RW4=;
        b=JOA3VecXl/7n4eWB8/kuHFYLpsL2mdUufTYclRxs+5wRMNCM4XRxMpZiYho+loBAZI
         +bJsTcTMSwVzcI3mOSueJ9QXc0ZPmnbz5ISLw5eCxIXmwgwaeXAMglIwMUza+fLiKOg7
         1SPY+PStrjsUiBvkEEJegr4H0W2gjx+XkdBUPCiMjr+HAHn/yUq96tmhVPsgKOGUPzVC
         4pb56KNJ/p2oUfcT/+7z8uExiK7m3LufQIxzhtZycmdHv2MlYN5y1ewTIn/2MHNx9bMs
         gjVaIBeH98vWKCvvsWe44vquptLs8ug9OhzQrBTl2lB46kDSwCPocJm5P/gVF4mlKahG
         JaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NjSi9eqJziRBvbb4ndcXaUHTovGmaZDC1oesBWy2RW4=;
        b=kyCU+xIOWiglXd1b3RfDKaIseF13OhFVoY4YmS8q+HccGJ/1+3AHr2PRSa4cCKfFPj
         7S3NG+BxLp/D0SsWtnQt7lIkw9kakpWSSuBp5mVkfNHJRh6OaG9T49FAvgwmEXPpgvjx
         dDhepdBC15gShdC6ZmL2msbOG5+TQFqthPkeqMWBraadJoqluMRIRlBAYxLw0beDQIE/
         4qvrJ7qhPDKykGYZr4ZZCcS8Exue0CM0zyJQj5kfYir8w9L0yfmbAvKldSc0m6+aSIR6
         Oxja+7ZKWxCgOcDfuexv9Db+oAS7Y8ZgMTvCZTn1FAGsJ40D8fWwgkQqO2EAPoQmcoJs
         3B8Q==
X-Gm-Message-State: ABUngvc9aKjZNbxUttyCYHBxvdqjlyJOp0NvalxGbFCiZDn0X28aYocA4jk7M0iW2jzI5J87XSFKvdKhuBxQmXK7
X-Received: by 10.55.56.11 with SMTP id f11mr1513127qka.255.1476987220640;
 Thu, 20 Oct 2016 11:13:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 11:13:40 -0700 (PDT)
In-Reply-To: <xmqqoa2ehp5u.fsf@gitster.mtv.corp.google.com>
References: <580893d5a4736_4ed37b53181837@ss1435.mail> <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
 <xmqqshrqhpua.fsf@gitster.mtv.corp.google.com> <CAGZ79kYTwsWy+oxnPKghWKGLEaO9qWZbrQOOejeEBOe0c-o0Pg@mail.gmail.com>
 <xmqqoa2ehp5u.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 11:13:40 -0700
Message-ID: <CAGZ79kb0gfVQt-P7b8y2KN-vDvs1FKn=D0isHkTy=QO416amDA@mail.gmail.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Good to know that you have been managing it; I was mostly worried
> about not having anybody managing it (i.e. imagining Coverity
> nominated/volunteered me as manager with everybody else as viewers)
> and the new viewer requests get totally ignored by the project as
> the whole.

No, I have been paying attention, but in case I suddenly stop contributing
to the git project I thought it's better to have a couple of people there.

>
>> I see that some of these emails may be inconvenient to you, I can
>> change your role to defect viewer/contributor if you prefer.
>
> It is not a huge inconvenience to me, because any piece of e-mail
> that is addressed directly to gitster@ without CC'ing to git@vger
> and is not a follow-up to any earlier message goes to a separate
> lowest-priority mailbox that I rarely look at.  But if it is easy
> to recategorize me, please do so.

done.
