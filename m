Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2988B1F859
	for <e@80x24.org>; Tue,  6 Sep 2016 08:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932970AbcIFIXT (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 04:23:19 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:32993 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752848AbcIFIXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 04:23:16 -0400
Received: by mail-yb0-f171.google.com with SMTP id d205so46718048ybh.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grabcad.com; s=gc130320;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cHJLZb4E/uEnVV9Aq7kl8f3NTU2auY50OMWeFujstcc=;
        b=KXDqyiq79w6cxFuThtsPxXyxOD3LeVBqsGq/GspLnvSFfDc9ijfRAJFzeCg66hDgis
         pZ5n7fcB7FEARKHuPQJwzCCGV0Sn9ouFrEYxKSuJ72PbTG2xGbMBek9iaSmdaJsJTDgd
         NU3++2bHLMwcpHEsWn5OuiUmCZjrRjr66OO5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cHJLZb4E/uEnVV9Aq7kl8f3NTU2auY50OMWeFujstcc=;
        b=mBvlmBpVP9cCcmyqvwxOPwf3Ixh0PTta6LJtMiP6NMXXX3Ccpd0U3HJoLDmPFTsesU
         3n16YKDQuILxMsbP0zxGIED/qvKQEplhyA56rZFMEk3Z9qyR1oKC3OibsZpMcjXB63yC
         fqjoMW88S3znrmEXXsg8vNH3vkbfTHG4jvhdZCSQwbYcTALyYZeI+HZeVDshx8URrRbA
         BF7uQkjFpYxreQsfmhgE7Oel2iwxrvguwC6cgKX76c8xq6YdpmwloauSRF79l6ViH3O3
         XwpW1uVCYbQO6hx1P4DHzT3POX/nsSBSseinQt/70OjvCLCg/adA8bCJ+ZW6ZxawouMF
         nGug==
X-Gm-Message-State: AE9vXwMMrdlgD1vtsqhA8A3OzlUYSvUuH3je+eHGqSHFngQRF9xUa4kgoxcR9JjPI+WvouA3TQbYYXybC+W+7V4Y
X-Received: by 10.36.125.137 with SMTP id b131mr29205841itc.55.1473150195658;
 Tue, 06 Sep 2016 01:23:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.37 with HTTP; Tue, 6 Sep 2016 01:23:15 -0700 (PDT)
In-Reply-To: <50fc49a6-68a2-040b-beb1-feb162c458d2@atlas-elektronik.com>
References: <CAFfNYUmMdamkW=Ca-iRDJ35ucr=S8A_qLTmjoD5j1M_ohdCgSg@mail.gmail.com>
 <dd6180a8-8719-e87b-26c1-e73d43167f84@atlas-elektronik.com>
 <CAFfNYUk4QWii7AyG7u2B8G-JGT1Dn0OTopM=FTgaA7DBjYPhfA@mail.gmail.com>
 <939e5f85-341e-cca5-a818-0e8a43f7a88b@atlas-elektronik.com>
 <CAFfNYUmBaydosF8vYwfj1+px3uUfiH4F=jgdCYBdzEw3-5FUGQ@mail.gmail.com>
 <89b6f6a2-a793-011b-7351-581be0ee8128@atlas-elektronik.com>
 <CAFfNYUkUpaCo8uYv=fofPRyCgg7db4M2fh7BJRc4WCHZdbxvsw@mail.gmail.com> <50fc49a6-68a2-040b-beb1-feb162c458d2@atlas-elektronik.com>
From:   Idan Shimoni <idan@grabcad.com>
Date:   Tue, 6 Sep 2016 11:23:15 +0300
Message-ID: <CAFfNYUmH4-Em++kJzdd-V8sDU-OrWp5Qy8kqMtfD7UmaQABg5Q@mail.gmail.com>
Subject: Re: Context Menu is missing
To:     stefan.naewe@atlas-elektronik.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

???

On Tue, Sep 6, 2016 at 11:20 AM,  <stefan.naewe@atlas-elektronik.com> wrote:
> (and s/he did it again....hitting "reply all" seems really complicated)
>
> Am 06.09.2016 um 10:07 schrieb Idan Shimoni:
>> it is part of git cheetah plugin not tortoise.
>> But it was part of the git installer for windows, I did not installed
>> anything else before.
>>
>> On Tue, Sep 6, 2016 at 10:54 AM,  <stefan.naewe@atlas-elektronik.com> wrote:
>>> (Please, please, please, use "reply all" in your mail reader i.e. make sure you don't
>>> remove 'git@vger.kernel.org' from the "To:" or "CC:" field. Thank you!)
>>>
>>> Am 06.09.2016 um 09:47 schrieb Idan Shimoni:
>>>> On Tue, Sep 6, 2016 at 10:33 AM,  <stefan.naewe@atlas-elektronik.com> wrote:
>>>>> (Please don't top post and do "reply all")
>>>>>
>>>> I tried but you are receiving only plain text emails.
>>>> anyway...
>>>
>>> ??? ECANNOTUNDERSTAND
>>>
>>> Read about top-posting here: https://en.wikipedia.org/wiki/Posting_style#Top-posting
>>>
>>>> I reinstalled windows on my computer and then installed Git version
>>>> 2.9.3 for windows.
>>>> And the context menu were missing.
>>>
>>> In the explorer, I guess ?
>>>
>>>> I am talking about the one that you had:
>>>> - Git History
>>>> - Git Branch
>>>>    - branch_1
>>>>    - branch_2
>>>> ....
>>>
>>> Git for windows *doesn't* install that.
>>>
>>>> Git GUI and Git Bash are still there...
>>>
>>> Git for windows *does* install that.
>>>
>>> Maybe you had TortoiseGit installed before (just a wild guess, though)
>>>
>>> Stefan
>>> --
>>> ----------------------------------------------------------------
>>> /dev/random says: Gambling: The sure way of getting nothing for something.
>>> python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
>>> GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
>>
>>
>>
>
>
> --
> ----------------------------------------------------------------
> /dev/random says: Give instruction to a wise man and he will be yet wiser.
> python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
> GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF



-- 
-Best
Idan
