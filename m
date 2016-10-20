Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF6D20229
	for <e@80x24.org>; Thu, 20 Oct 2016 17:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933642AbcJTR6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 13:58:47 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33674 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933536AbcJTR6l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 13:58:41 -0400
Received: by mail-qk0-f171.google.com with SMTP id n189so109008436qke.0
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EprpEGo2nGL7ZDz3t+TQ2ZDgEgxDEgdXxDFegrKcfEo=;
        b=kx/5nejHSe5QIs2V8TUATIXsnzYCuCyzs2aOMD3cxm45cGN2gUrEF4PzoiwWjbddxH
         8OVtrS8XnIyQuIdOiDYJZw+8edqPQrxRw0baUGZ6JMUdudv/G+V1PWTc+FFBtAsfqk3f
         nfPR6K+LgVoC9o9mkHBmL2heGGBusnDAOQvx9vBlNEOs+TMUx+zyzTrWJfZwNmsjCeZm
         YDSGo+b3aEjGjzufy3cdMz0/LJZseDMKNJDmf5u09q72LVisPOF6sAGswgIEvI9wmLeR
         uTMaGvZ3sdIM+APgjHXnsKA3tv1CclXHbqJPTqtHLU7jevhB8xSSwVBxdHo5csb908hZ
         aSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EprpEGo2nGL7ZDz3t+TQ2ZDgEgxDEgdXxDFegrKcfEo=;
        b=H3wF89tDCGVE8eZ1VaJXY8iia9euJ+4rts1P9tqm4TVgoa32rgnBxW1pEA8jXutMVI
         kokOAXSuKtsGb+ZQ5lRI0nXdv/rCcoQaXPsiH7shd0CbmboX1bItVbevozjiYhi6yiWA
         KzXTb9OGKuuUb6rwhX/xt/icBBv9+3GuG11g2g2pkI6xLRqrJsJoIniNYUUz4l6QA5te
         Zmc2RL8m8dIUBqLorKDdN7huZH20fyNmaR07jjFdHELH/Ahj9MS+LUsJST+XJvXAO02N
         njuyXenPMtMHJco8MpMYhiIaqQT9jiSgKjw3EAJaDCV2YHCU7xjXST/RuOJEuI/AOxxT
         BtFA==
X-Gm-Message-State: ABUngvdYWWYdEt+eaoei8wr7DId1G+x8O8TMq9lOM1zVqdiBfW6pvkD3bibryMAT+Z59Dt2X3AccI1eBbUlrtgyI
X-Received: by 10.55.22.105 with SMTP id g102mr1487193qkh.86.1476986320043;
 Thu, 20 Oct 2016 10:58:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 10:58:39 -0700 (PDT)
In-Reply-To: <xmqqshrqhpua.fsf@gitster.mtv.corp.google.com>
References: <580893d5a4736_4ed37b53181837@ss1435.mail> <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
 <xmqqshrqhpua.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 10:58:39 -0700
Message-ID: <CAGZ79kYTwsWy+oxnPKghWKGLEaO9qWZbrQOOejeEBOe0c-o0Pg@mail.gmail.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 10:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Not sure what triggered the new finding of coverity as seen below as the
>> parse_commit() was not touched. Junios series regarding the merge base
>> optimization touches a bit of code nearby though.
>>
>> Do we want to replace the unchecked places of parse_commit with
>> parse_commit_or_die ?
>
> The reason parse_commit() would fail at this point would be because
> the repository is corrupt, I do not think it would hurt to do such a
> change.
>
> I agree that it is curious why it shows up as a "new defect",
> though.
>
> By the way, do you know who is managing the service on our end
> (e.g. approving new people to be "defect viewer")?

I do it most of the time, but I did not start managing it.
And I have been pretty lax/liberal about handing out rights to do stuff,
because I did not want to tip on anyone's toes giving to few rights
and thereby annoying them.

I see that some of these emails may be inconvenient to you, I can
change your role to defect viewer/contributor if you prefer.

Thanks,
Stefan
