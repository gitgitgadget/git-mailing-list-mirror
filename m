Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CE4A2027C
	for <e@80x24.org>; Wed, 31 May 2017 05:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdEaFcz (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 01:32:55 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33041 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdEaFcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 01:32:54 -0400
Received: by mail-oi0-f54.google.com with SMTP id w10so2944734oif.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YdtngpZACe1YGxwsdKl2Ex/aXYZAkcCB+DnpoQqflX8=;
        b=mG1k4PvThl/xTxBxR/A9oz88wusK3BV7Xzmz9C+AxlJoXKhS0u386tgvWbRA3228Qd
         0iKsIJkBnYr4licL/k5bc0Yl8afaoKMLoR+/g2Y/jsoNsz64aAn3vOtKRNfUnWiHCor/
         mvu1DZfIiJgyoyIo6VPH3vWrSLqEuAhDvLsDjB4SIIrITA84qeqNVYzL3VSQRhDNIHPE
         E0mEN8m7SVn4RLwo3AYp3oLQ6JUgVKkjAg77b/jYhO8Q2LknrrkNjj/GAcA1QU3ZOn+C
         86nZVMu5CFOTKuMVzW79BScWSTXS550iKttDPTqe1ZuAG/7ocFjidRqxtilcpfxT4fnG
         SqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YdtngpZACe1YGxwsdKl2Ex/aXYZAkcCB+DnpoQqflX8=;
        b=Nk1gmFj04uj78gE8k12w8/kTueDNydPjjUoUIVznUgVJdTo7UO0tWxDLkf2dK6rfPG
         bykKbT5mUdCrs7zibBC+KeifAKCD8DgFpDI0T+mFtEKZ/wKJOEGqSa6JFjKRFq3aeNn8
         GYUKFTDxHRUFZVbMUru9H0fYTEmAXox8il8/0NW2qR9/Oz/EOyfGpoWTyMg536930DMy
         YEpCT6Dq4dzCfkspUFaYz1gd73oyr9wHqmU3YMY8M1MTvzSaLRsHH7Fkqn7V41g/E2JH
         qpFloG5lGkH4NsqyCl0hXmzKeshi1pyCJu4kY9ebOwiRTGFQI83DDacanwiyQxnd9QHZ
         UpUw==
X-Gm-Message-State: AODbwcDl5swuf5O41zP7M6sZWxWXEH4rLn2RCQ+8y1t4V+4ld6rzITPd
        S/0uYA4I7q+32FyeO6Nw+PD/55h9XQ==
X-Received: by 10.202.48.136 with SMTP id w130mr4734705oiw.65.1496208773067;
 Tue, 30 May 2017 22:32:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.38.143 with HTTP; Tue, 30 May 2017 22:32:52 -0700 (PDT)
In-Reply-To: <3d02b958-5f72-9676-bce9-afca962c07df@kdbg.org>
References: <CALKRkrxHNao6NY+-_UmznHdq29yVJJynu8Xx5M__YfK9UkdOAw@mail.gmail.com>
 <CA+izobvwRCwGEtpCbey=gFbCh9sHBb5xB1i1LpMG0JCUy0O2mQ@mail.gmail.com> <3d02b958-5f72-9676-bce9-afca962c07df@kdbg.org>
From:   Atousa Duprat <atousa.p@gmail.com>
Date:   Tue, 30 May 2017 22:32:52 -0700
Message-ID: <CA+izobteEUSisKXNr=k5BcN9hVV4nyqYPWuRLAgV-rg9chH4_g@mail.gmail.com>
Subject: Re: [Bug] git branch -v has problems with carriage returns
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Animi Vulpis <animi.vulpis@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="001a113cd7046df4db0550cb40c8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a113cd7046df4db0550cb40c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is my first attempt at fixing the issue.

There are two problems in ref-filter.c:

First, copy_subject() has been modified to turn '\n' into a space and
every other ascii control character to be ignored.

Second, find_subpos() doesn't realize that a line that only contains a
'\r\n' is a blank line =E2=80=93 at least when using crlf convention.
I have changed things so that a sequence of either '\n' or "\r\n"
separate the subject from the body of the commit message.
I am not looking at the crlf setting because it doesn't seem like a
useful distinction =E2=80=93 when one would we ever care for \r\n not to be=
 a
blank line?  But it could be done...

Both fixes are minimal, but it feels like they are a issues with the
specific encoding.  Does git mandate ascii or utf-8 commit messages?
If not, there may be a larger issue here with encodings and line-end
conventions at the very least in ref-filter.c
Guidance would be appreciated for how to deal with this issue...

Patch attached.


Atousa


On Fri, May 19, 2017 at 11:48 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 19.05.2017 um 23:55 schrieb Atousa Duprat:
>>
>> I have tried to repro this issue but git goes out of its way to store
>> the commit messages using unix end-of-line format.
>> I think that git itself cannot create a repo exhibiting this problem.
>
>
> Here is a recipe to reproduce the error:
>
>   git init
>   git commit --allow-empty -m initial
>   git branch crlf $(printf '%s\r\n' subject '' line3_long line4 |
>        git commit-tree HEAD:)
>
> The reason for the "bug" is obviously that a line having CR in addition t=
o
> LF is not "an empty line". Consequently, the second line is not treated a=
s a
> separator between subject and body, whereupon Git concatenates all lines
> into one large subject line. This strips the LFs but leaves the CRs in ta=
ct,
> which, when printed on a terminal move the cursor to the beginning of the
> line, so that text after the CRs overwrites what is already in the termin=
al.
>
> This is just to give you a head start. I'm not going to look into this.
>
> -- Hannes
>
>
>>> If I do `git branch -v` with such a subject line somehow the third and
>>> second line get combined before the hash. Example:
>>>
>>> $ git branch -v
>>> See merge request !XXXX temp space 84e18d22fd Merge branch
>>> 'feature-XXX' into 'develop'
>>> # <begins with third line> <ending of seconds line (if longer than
>>> third)> <commit hash (correct)> <subject line (correct)>
>>>
>>> Before git v2.13.0 `git branch -v` worked completely normal.

--001a113cd7046df4db0550cb40c8
Content-Type: application/octet-stream; name="branch-crlf.patch"
Content-Disposition: attachment; filename="branch-crlf.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j3ck1eb70

ZGlmZiAtLWdpdCBhL3JlZi1maWx0ZXIuYyBiL3JlZi1maWx0ZXIuYwppbmRleCAzYTY0MDQ0OGYu
LmJjNTczZjQ4MSAxMDA2NDQKLS0tIGEvcmVmLWZpbHRlci5jCisrKyBiL3JlZi1maWx0ZXIuYwpA
QCAtODM2LDExICs4MzYsMTUgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmNvcHlfZW1haWwoY29uc3Qg
Y2hhciAqYnVmKQogc3RhdGljIGNoYXIgKmNvcHlfc3ViamVjdChjb25zdCBjaGFyICpidWYsIHVu
c2lnbmVkIGxvbmcgbGVuKQogewogCWNoYXIgKnIgPSB4bWVtZHVweihidWYsIGxlbik7Ci0JaW50
IGk7CisJaW50IGksIGo7CiAKLQlmb3IgKGkgPSAwOyBpIDwgbGVuOyBpKyspCisJZm9yIChpID0g
MCwgaiA9IDA7IGkgPCBsZW47IGkrKywgaisrKQogCQlpZiAocltpXSA9PSAnXG4nKQotCQkJcltp
XSA9ICcgJzsKKwkJCXJbal0gPSAnICc7CisJCWVsc2UgaWYgKHJbaV0gPCAzMikKKyAgICAgICAg
ICAgICAgICAgICAgai0tOyAvLyBza2lwIGFzY2lpIGNvbnRyb2wgY2hhcmFjdGVycyB0aGF0IGFy
ZSBub3QgJ1xuJworICAgICAgICAgICAgICAgIGVsc2UgcltqXSA9IHJbaV07CisgICAgICAgIHJb
al09MDsKIAogCXJldHVybiByOwogfQpAQCAtOTU2LDkgKzk2MCwxMiBAQCBzdGF0aWMgdm9pZCBm
aW5kX3N1YnBvcyhjb25zdCBjaGFyICpidWYsIHVuc2lnbmVkIGxvbmcgc3osCiAJCQllb2wrKzsK
IAkJYnVmID0gZW9sOwogCX0KKwogCS8qIHNraXAgYW55IGVtcHR5IGxpbmVzICovCiAJd2hpbGUg
KCpidWYgPT0gJ1xuJykKIAkJYnVmKys7CisJd2hpbGUgKCpidWYgPT0gJ1xyJyAmJiAqKGJ1Zisx
KSA9PSAnXG4nKQorCQlidWYgKz0gMjsKIAogCS8qIHBhcnNlIHNpZ25hdHVyZSBmaXJzdDsgd2Ug
bWlnaHQgbm90IGV2ZW4gaGF2ZSBhIHN1YmplY3QgbGluZSAqLwogCSpzaWcgPSBidWYgKyBwYXJz
ZV9zaWduYXR1cmUoYnVmLCBzdHJsZW4oYnVmKSk7Cg==
--001a113cd7046df4db0550cb40c8--
