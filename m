Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B311FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 22:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbcL2WSu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 17:18:50 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36389 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbcL2WSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 17:18:49 -0500
Received: by mail-qt0-f179.google.com with SMTP id k15so143682700qtg.3
        for <git@vger.kernel.org>; Thu, 29 Dec 2016 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xek3P/qB0dClm53+a/lOE9Ghq4Q9eelXI7FsygXyS/g=;
        b=vMNo327zG4jgqCJERvKq5PKb8f1Msz5HXNA7aXhs83ANsxSH3rn2tr14gLIauzkUY5
         pKhLqfi3EWt+1LGH8F+G4Oe9Kr4NAf3O27kqWCU+eTeI9cn24Z3HtUMk/bMqJdqDoEkY
         A223oKH30umZCZY4IPDkNxao0/bVEPMMZPRuFKcoL1/5saHPCBtBF3fiQTmPdAm1tf53
         RvxPsHbXAWUno+w8WOBZL47fuOe13vKzmGpJi4LSvNm5M0QPRbhMHsKqhm/Xj3pW6Ljz
         aIJq7xlPmc8mAiufBHEeUqTQX0jBSmyETEssNnecEdaTo06PAeNIIT+6XnE3gW5RZWjO
         G/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xek3P/qB0dClm53+a/lOE9Ghq4Q9eelXI7FsygXyS/g=;
        b=XbLxA1X1ACGzYSAswHWgBJZ0mPbL+rH3zLZ5VKKN2aDtuGSaixOuuBe4ZBgQ93siwE
         hfChe1fMLKnRMfbilUT0k7KHVKYnF2L/FvLEcfHPBUrqbgH8dIHbms/RA7Jq4KcUsg8l
         F0WWKFXRo2LTDNpe259n4QOCOhyQrTryYaHcvvlHQeGsdjYHRXqcYAOLwgrVGxvAkJKu
         jBIylMwBFw2I6K8A56msr6HCTjur8/QDcYokky7pThQWJPsgIS0YfcpTA34V6QKmKCqG
         Bqmv7Xqkk++AHi/og0x3kuag6ShKbrBvWFUzmoV0y/xbe2LmYo1GHzR/50IPc7UpV39X
         vefA==
X-Gm-Message-State: AIkVDXKMa7Emo6xl8ABNgN2+jqB/c6wyTQ8Y1GgZESFfwdDgZRgaOvc45yRtuJUPuiiTvqhuObDmxsQ4BNI9k5lZ
X-Received: by 10.200.50.147 with SMTP id z19mr35395761qta.207.1483049928643;
 Thu, 29 Dec 2016 14:18:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Thu, 29 Dec 2016 14:18:48 -0800 (PST)
In-Reply-To: <xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com>
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
 <20161229084701.GA3643@starla> <xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Dec 2016 14:18:48 -0800
Message-ID: <CAGZ79kaAbCTsY_SddVMKMsLV0xyXNBFvxQ=J-20Cwdz31v4OwA@mail.gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, Eduardo Habkost <ehabkost@redhat.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 29, 2016 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
>
>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> git-am has options to enable --message-id and --3way by default,
>>> but no option to enable --signoff by default. Add a "am.signoff"
>>> config option.
>>
>> I'm not sure this is a good idea.  IANAL, but a sign-off
>> has some sort of legal meaning for this project (DCO)
>> and that would be better decided on a patch-by-patch basis
>> rather than a blanket statement.
>
> IANAL either, but we have been striving to keep output of
>
>    $ git grep '\.signoff' Documentation

Try again with -i ;)
and you'll find format.signOff

>
> empty to keep Sign-off meaningful.
>
> Adding more publicized ways to add SoB without thinking will make it
> harder to argue against one who tells the court "that log message
> ends with a SoB by person X but it is very plausible that it was
> done by inertia without person X really intending to certify what
> DCO says, and the SoB is meaningless".

I think we should be symmetrical, am is the opposite of
format-patch in the Git <-> email conversion.

If I were to follow your arguments here, we should revert
1d1876e930 (Add configuration variable for sign-off to format-patch)

On the other hand, I would argue that thinking and typing things is
orthogonal (the more you type, doesn't imply that you think harder
or even at all).

--
However I think there is a use case for such an option
(in the short term?) as e.g. you as the Git maintainer being employed
has the legal rights to sign off on pretty much any patch in Git.
For other projects this may be different.

Which is why a per-repository configurable thing is useful to
setup a default for your environment.

IIUC long term we rather want to have easily configurable trailers
for am/format-patch/commit, such that you could configure to
remove any "ChangeId:" footers before sending out, or adding
a "Tested-by" footer by a CI system or such?

>
>> I don't add my SoB to patches (either my own or received) until
>> I'm comfortable with it;

comfortable is orthogonal to legal, specifically on the receiving side.
I can understand using format-patch to send out unsigned patches
(e.g. for heavy WIP things, "please to not apply literally")

>> and I'd rather err on the side of
>> forgetting and being prodded to resubmit rather than putting
>> an SoB on the wrong patch.
>
