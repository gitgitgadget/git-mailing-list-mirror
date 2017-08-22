Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C7E1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 15:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933050AbdHVPZj (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 11:25:39 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33292 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932946AbdHVPZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 11:25:38 -0400
Received: by mail-ua0-f196.google.com with SMTP id r23so546655uag.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Viy8h1l2LEWxqBnu//bkOZYezPbMo49+ZScH6lJdIVM=;
        b=N/QoaYKwRAB01Qle0L1P9fc2FTnZcHgkYrbvqD7cmbMe26fhYJt3/91hdSpY+vby7j
         E7UjHaOUVmgs1doTmZCPlV/JO8S2sOb67G3+/b2gOJwlyaditF72xxI7IIECYHTXGMzl
         QxC0LMQcbB83Gg+MQxUfCg5PVOHGkHhj+sO6L9j3uKbimuJnyd+I68DVzzSzRSzdYP+A
         48JF9SqgidDBmZIv2vLNOglQ42oGP5RLHF7Cw1qO4SoQd7YYMmYU7qJyLqiPNg9gx1Dl
         0rCr6ru8TcJGeXrx8740JMdsZUTXw2XoQeu109NyWgi1+qcBhGspS1PhnRFY9bFfxKjV
         JraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Viy8h1l2LEWxqBnu//bkOZYezPbMo49+ZScH6lJdIVM=;
        b=m1dNiwIbl5rncNFXMB4TrFC7MuS+FBy70LH9FDqwhUZsiTYEi0I+DfnlDP7B7sqoAs
         73p1bFnWiYXzj+wF18jDoO/5g1IBHVbMuhj+9+QBYzpIkm6CD2scKf1QHaDjJ8lhKdbx
         wJbTkiGBHiT4GWZllBlPvOAk+9FpY+lGEqwuSHTmoKfKj7y03LBIOz5ZVY6bkmADxTlC
         aDLPevnpiVYiZI/aLnGZ5pFTZ5+3TnY9K1kKmMmk7RlyoDbMBWI1epssdTI6oPpiRJcR
         UODPGLCnwVyXeJCT14crn3T00LVXqY10rUbSj5u/IInJ8YAgLzBjmaUV3BKy4Hs5xnxW
         +c9g==
X-Gm-Message-State: AHYfb5gzu8hhEwn3oURF70LqdRDlgtauaTDS5vcrC79/iJj23rDm9U3J
        SkR9hGfItK0WKNnIzL3JPT9N5v5SNw==
X-Received: by 10.176.79.130 with SMTP id m2mr564703uah.152.1503415537547;
 Tue, 22 Aug 2017 08:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.128.203 with HTTP; Tue, 22 Aug 2017 08:24:56 -0700 (PDT)
In-Reply-To: <CAN0heSq0t=Jkaq-dgt_T4K9an4Peat0jArRQgE6JgsWwu53FPw@mail.gmail.com>
References: <cover.1503319519.git.git@grubix.eu> <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
 <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
 <CAN0heSrG7ackEW1BMpadNnPKSUCXATbxfUykcpppC6-Y2OCWJQ@mail.gmail.com>
 <8e8c8cdc-cad8-550d-9669-3f078f0d77d1@grubix.eu> <CAN0heSq0t=Jkaq-dgt_T4K9an4Peat0jArRQgE6JgsWwu53FPw@mail.gmail.com>
From:   hIpPy <hippy2981@gmail.com>
Date:   Tue, 22 Aug 2017 08:24:56 -0700
Message-ID: <CAM_JFCzq+DPUFbC60kjNjHz3OZLt-X3bLXJdSFpBnATtZ6otdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation/git-merge: explain --continue
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think 'git merge --continue' should be advertised more that 'git
commit' as typically one is familiar with 'git rebase --continue' and
'git cherry-pick --continue'. I for a long time did not know I could
also use 'git commit' to continue a merge but that's just me. Now,
'git commit' is easier to remember if it works in all cases (merge,
rebase, cherry-pick).

RM


On Tue, Aug 22, 2017 at 3:06 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 22 August 2017 at 11:26, Michael J Gruber <git@grubix.eu> wrote:
>> Martin =C3=85gren venit, vidit, dixit 21.08.2017 18:43:
>>> On 21 August 2017 at 14:53, Michael J Gruber <git@grubix.eu> wrote:
>>>> Currently, 'git merge --continue' is mentioned but not explained.
>>>>
>>>> Explain it.
>>>>
>>>> Signed-off-by: Michael J Gruber <git@grubix.eu>
>>>> ---
>>>>  Documentation/git-merge.txt | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>>>> index 6b308ab6d0..615e6bacde 100644
>>>> --- a/Documentation/git-merge.txt
>>>> +++ b/Documentation/git-merge.txt
>>>> @@ -288,7 +288,10 @@ After seeing a conflict, you can do two things:
>>>>
>>>>   * Resolve the conflicts.  Git will mark the conflicts in
>>>>     the working tree.  Edit the files into shape and
>>>> -   'git add' them to the index.  Use 'git commit' to seal the deal.
>>>> +   'git add' them to the index.  Use 'git commit' or
>>>> +   'git merge --continue' to seal the deal. The latter command
>>>> +   checks whether there is a (interrupted) merge in progress
>>>> +   before calling 'git commit'.
>>>>
>>>>  You can work through the conflict with a number of tools:
>>>
>>> There are actually two things going on here. First, this mentions git
>>> merge --continue. Second, it explains what that command does. But the
>>> latter is done earlier (not exactly like here, but still).
>>
>> I didn't see that explained in the man page at all - on the contrary, I
>> only saw a forward reference (see section...), but then only an
>> explanation of what "resolving" means (including the "git commit"-step).
>> It is unclear to me from the man page which steps of "resolving" the
>> command "git merge --continue" does - you could think it does "git
>> commit -a", for example.
>
> That's very true, and your change helps immensely. I thought that once
> git merge --continue was mentioned, e.g.,
>
>         Use 'git commit' or 'git merge --continue' to seal the deal.
>
> or
>
>         Use 'git commit' to conclude (you can also say 'git merge
>         --continue').
>
> then things are in some sense "complete". But you might be right that
> further stressing that the latter is basically an alias helps avoid some
> confusion. "Oh, great, so now I have two commands to choose from -- which
> one should I be using?" :-)
>
> Martin
