Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59204202D7
	for <e@80x24.org>; Wed, 15 Nov 2017 18:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932853AbdKOSHb (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 13:07:31 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34855 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932805AbdKOSH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 13:07:29 -0500
Received: by mail-wm0-f45.google.com with SMTP id y80so4717598wmd.0
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ufehkvJPs7KXbi215CkgBqdCOTqhIaEx3NgYKNUx2Vo=;
        b=qmskLGdSjVz77a5+NYVoiFDe6g+3FAkiOPTOaoJ8qrF6ak9Bf6hoSP+Hi42D624gZQ
         x0joZ+3br4oJgVaGZ6z8+gDVBLYYOeNM34xqBdWcJa7p9O5fJmM7iCUiTsfM50uRs9UB
         859Lg167VeirtpYGpiAYneLu17+bXr9wzWyjhgG3+6/cVm9CHG+5t+PDM0XkzWtMmmlr
         vv8wvR2pDY9g9cJnev3IrjLDm+8QYZJ+PqpEKU5UdoBHN4W/+HSZpmgeqOOyNU7eyw2B
         RSD+kwYRX4vNwbG7AuL67rg00TTXkVXyYz/4mQbkTW9U/VlclnDiOUKjeznetr5w2fm/
         /c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ufehkvJPs7KXbi215CkgBqdCOTqhIaEx3NgYKNUx2Vo=;
        b=TrvWV9aoTwKsYSk/VSBhHoj72aQUWx2Qj49efPVEVipws7E+9x7uPtekfDUbgfLWcf
         MrV62b0AtcKflkCpGcIDGJO2i19RzZYM5mSxeUPC3XoSiKfaBlSYj0y6Tr/kAQrq/30g
         N2S/Bt/Sfs1diH7MYSlXaTxFvQAaPrWtSMKgi9Xgk0HBDKTTs35L6Yz+omOXBEKRvQLI
         4YJ0GkB6l5ksBHy0YNgMSMHafNsoF1I/GVlAFvHYt34FVHtw80CJ3DysEn167Fhi9VWk
         m3ermn5lE1w3y2xrELIdyuyCkQwYHdVqzhGzX0KUtdDx7MsVhz7IiOQPjAgICL5fNMnJ
         vJ/A==
X-Gm-Message-State: AJaThX76SC3BSmef5cJ39cnr8mIJ9PannBA13OYJvyJmOJZIJK7QFIH8
        qpeVHVmBlG6ICJVcdtukTUk=
X-Google-Smtp-Source: AGs4zMbCJ5b9JrRdncKtmj276gdRjhczMSq4yed+W027EWea6I0bMBWTjXjbfOlxFhEA4HXKA57tfw==
X-Received: by 10.28.74.193 with SMTP id n62mr13531884wmi.61.1510769247970;
        Wed, 15 Nov 2017 10:07:27 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 12sm11778654wmn.1.2017.11.15.10.07.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Nov 2017 10:07:27 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC] Indicate that Git waits for user input via editor
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kaqyRTaj6=-7Jmb1K6_aSH5-BaEhm7PPyRgJLsHuDF-tw@mail.gmail.com>
Date:   Wed, 15 Nov 2017 19:07:26 +0100
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CF0CF44-3772-48D9-A2EF-E501645A6211@gmail.com>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com> <CAGZ79kaqyRTaj6=-7Jmb1K6_aSH5-BaEhm7PPyRgJLsHuDF-tw@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Nov 2017, at 18:51, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Wed, Nov 15, 2017 at 7:08 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> Hi,
>>=20
>> Git gathers user input via text editor in certain commands (e.g. "git =
commit").
>> If you configure a text based editor, such as vi, then this works =
great as the
>> editor is opened in your terminal window in the foreground and in =
focus.
>>=20
>> However, if you configure an editor that runs outside your terminal =
window then
>> you might run into the following problem:
>> Git opens the editor but the editor is the background or on another =
screen and
>> consequently you don't see the editor. You only see the Git command =
line
>> interface which appears to hang.
>>=20
>> I wonder if would make sense to print "Opening editor for user =
input..." or
>> something to the screen to make the user aware of the action. Does =
this sound
>> sensible to you? Am I missing an existing solution to this problem?
>=20
> Can this be put in a wrapper that opens the text editor?
> The wrapper would print these lines and then open the text editor;
> depending on the operating system, there might even be a command to
> focus on that editor window.

Yeah, that would be a workaround. However, in order to take these steps =
(write the=20
wrapper, enable the focus command) the users needs to understand the =
problem.
That's quite a leap especially for new Git users. They just get the =
feeling "Git=20
is broken because it hangs".

Can you imagine any downside for an "Opening editor for user input..." =
message?


> Regarding Git, maybe improve the documentation for how to set the =
editor
> variable?

The sad truth is that 98% of the users do not read the documentation
(made up number but close to my observed reality).


- Lars=
