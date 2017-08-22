Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 818AB20899
	for <e@80x24.org>; Tue, 22 Aug 2017 10:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932438AbdHVKGn (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 06:06:43 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33470 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbdHVKGm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 06:06:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id u191so2110890pgc.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 03:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nWHICKLKpcLTQcl6D4qwSyPgYWK0M7XCiKlChMLxkYY=;
        b=dmjooi41Ueeo3MhitKOmlx2CzJVq3sECno5L9vR+JO/2vMuae0GAcntxWg79l9vZK5
         ImoccATHRxv8205x7JPIKhA9NO2GLuzVaabGEk7FNa0EZN4DXVNRs5rBqmmVQFCIDh+9
         KBFnssdzItASG4u0QTRoTORd4CBznJNxPrVAlPgvtfob2tWQABJDgp4hWuX29or/4o+n
         PZax6f3LBvoRJ9TIIEQtqgq0ku9tLgbIOK7YHHH95s554gucwwSbmHJS4qRYOMan56qT
         klWG8/ero0W7OP0U2IhEtx2lAoiWFC/MxBp+1ERJzgHHhPEjLPEzvHd9RHMAS9tsaLd2
         fdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nWHICKLKpcLTQcl6D4qwSyPgYWK0M7XCiKlChMLxkYY=;
        b=c7tMibf2qPa0WziQ8VOSvWvgYkJCkhO/39LidnvzEUfDV+7TSc7PEX6NxXmet5KUm7
         40Bs6SUuPYAcGYznnkaCf+gp4Icxqaw5oeIpbSSZVAmFwtWCNypvJF+4mP55A9wg035M
         d+CNW8GXbd6AKH8d5yfLqFiTq9oMnK2jcMJJcHcthh7quDo/2ATENG9MqKAeoeLJSnSu
         YIc58ft7XJwxHwgJJtFgFHCsFllXRbatrP2Dt9Gdap90SgyHK9d1JK3vTYXzswmQ8Psc
         OfdAsaghtoazmtlKCQ87kBSKjKksWPlORbVWfjNoMmvqxBudR4/03AP3ISuT0Xpu/MUf
         vcEg==
X-Gm-Message-State: AHYfb5jFDqBwAijNZ9/nXcFMTi3OJsRS6thUlcc6gqY3aJ56a61AUK/V
        GHy+wbqm8hvUGNWJoc89sM7bmXCfJOCP
X-Received: by 10.99.38.135 with SMTP id m129mr96323pgm.393.1503396401688;
 Tue, 22 Aug 2017 03:06:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 22 Aug 2017 03:06:41 -0700 (PDT)
In-Reply-To: <8e8c8cdc-cad8-550d-9669-3f078f0d77d1@grubix.eu>
References: <cover.1503319519.git.git@grubix.eu> <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
 <ddd9c06813f8e2e9d8160f2ed965e728190bc573.1503319519.git.git@grubix.eu>
 <CAN0heSrG7ackEW1BMpadNnPKSUCXATbxfUykcpppC6-Y2OCWJQ@mail.gmail.com> <8e8c8cdc-cad8-550d-9669-3f078f0d77d1@grubix.eu>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 22 Aug 2017 12:06:41 +0200
Message-ID: <CAN0heSq0t=Jkaq-dgt_T4K9an4Peat0jArRQgE6JgsWwu53FPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation/git-merge: explain --continue
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git Mailing List <git@vger.kernel.org>, hIpPy <hippy2981@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 August 2017 at 11:26, Michael J Gruber <git@grubix.eu> wrote:
> Martin =C3=85gren venit, vidit, dixit 21.08.2017 18:43:
>> On 21 August 2017 at 14:53, Michael J Gruber <git@grubix.eu> wrote:
>>> Currently, 'git merge --continue' is mentioned but not explained.
>>>
>>> Explain it.
>>>
>>> Signed-off-by: Michael J Gruber <git@grubix.eu>
>>> ---
>>>  Documentation/git-merge.txt | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
>>> index 6b308ab6d0..615e6bacde 100644
>>> --- a/Documentation/git-merge.txt
>>> +++ b/Documentation/git-merge.txt
>>> @@ -288,7 +288,10 @@ After seeing a conflict, you can do two things:
>>>
>>>   * Resolve the conflicts.  Git will mark the conflicts in
>>>     the working tree.  Edit the files into shape and
>>> -   'git add' them to the index.  Use 'git commit' to seal the deal.
>>> +   'git add' them to the index.  Use 'git commit' or
>>> +   'git merge --continue' to seal the deal. The latter command
>>> +   checks whether there is a (interrupted) merge in progress
>>> +   before calling 'git commit'.
>>>
>>>  You can work through the conflict with a number of tools:
>>
>> There are actually two things going on here. First, this mentions git
>> merge --continue. Second, it explains what that command does. But the
>> latter is done earlier (not exactly like here, but still).
>
> I didn't see that explained in the man page at all - on the contrary, I
> only saw a forward reference (see section...), but then only an
> explanation of what "resolving" means (including the "git commit"-step).
> It is unclear to me from the man page which steps of "resolving" the
> command "git merge --continue" does - you could think it does "git
> commit -a", for example.

That's very true, and your change helps immensely. I thought that once
git merge --continue was mentioned, e.g.,

        Use 'git commit' or 'git merge --continue' to seal the deal.

or

        Use 'git commit' to conclude (you can also say 'git merge
        --continue').

then things are in some sense "complete". But you might be right that
further stressing that the latter is basically an alias helps avoid some
confusion. "Oh, great, so now I have two commands to choose from -- which
one should I be using?" :-)

Martin
