Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149271F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 19:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHPTMv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 15:12:51 -0400
Received: from ltwemail.bankofamerica.com ([171.161.41.178]:37201 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727067AbfHPTMu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 15:12:50 -0400
Received: from lltwa05lxepmx01.bankofamerica.com ([171.180.36.243])
        by lltwa05ixepmx04.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7GJCmgN013831;
        Fri, 16 Aug 2019 19:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565982768;
        bh=yVI1r7GnbPc5mliye6jRzZ6Se/Nv8Jw5I83zyoEtUuo=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=tZcNdLv3FgsB6mWw2l39niUAXu16gLFJBlQSVgGLqR9EMr39GA6h8ihmflyQ3jEB8
         oYKWEPvFu3itwC+wEdWFvxv+XDz2Ia9/0qPiDloXoWmadFDG2QbOZtgQfZ1EXwgDU0
         hX+h7GqXMtCEMXDaCJZmRKV0cJfJ5cMSW6XEN02Y=
Received: from lltwa05bxepmx12.bankofamerica.com (lltwa05bxepmx12.bankofamerica.com [171.206.12.27])
        by lltwa05lxepmx01.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7GJCL1i029160;
        Fri, 16 Aug 2019 19:12:48 GMT
Date:   Fri, 16 Aug 2019 19:12:41 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <20190816042025.oiike3cahyfd5h7z@tb-raspi4>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <9dd3ed31c654443b8c6715bb1a15a0c0@bofa.com>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Content-language: en-US
Content-transfer-encoding: quoted-printable
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwCABDUnAP/+mJWQgANNx4CAADsrQP//18WAABMUKAD//38MoP/+sX+A//2l2mD/+aztkP/ypH+g/+NhTYD/xgyPIA==
X-MS-TNEF-Correlator: 
References: <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com> <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
 <aae529ce1b084b7bbcca3977e6909417@bofa.com> <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
 <20190813032452.qg2ufgljm4bjeznr@tb-raspi4> <a5b84e2b8184414bb416f3aa83361a1c@bofa.com>
 <20190813154033.uhi7w5jgwcj4xan7@tb-raspi4> <d4a0500d5f5e4706aef481a33096465a@bofa.com>
 <0244daea3faa4d4aa899cff0dcc62917@bofa.com> <bb706de9a42f4e60ba974647e68f8387@bofa.com>
 <20190816042025.oiike3cahyfd5h7z@tb-raspi4>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_08:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yay!  Feel free to tweak and/or butcher the wording, I won't be offended :)

-----Original Message-----
From: Torsten B=F6gershausen [mailto:tboegi@web.de]=20
Sent: Friday, August 16, 2019 12:20 AM
To: Yagnatinsky, Mark <mark.yagnatinsky@bofa.com>
Cc: 'Junio C Hamano' <gitster@pobox.com>; 'git@vger.kernel.org' <git@vger.k=
ernel.org>
Subject: Re: suggestion for improved docs on autocrlf

On Thu, Aug 15, 2019 at 04:56:05AM +0000, Yagnatinsky, Mark wrote:
> Okay, first attempt at better phrasing.  This may need more paragraph bre=
aks, or something.
> Right now it's very wall-of-texty.  And probably in a style way too diffe=
rent from the rest of the git docs.
> Also, the syntax is probably closer to markdown than AsciiDoc; sorry.
> Anyway, enough disclaimers, here's the first draft:

Thanks so much for the suggestion.

Feedback and Input like this from Git users are really appreciated.
I will re-read it a couple of times, and probably find some time
to make a patch out of it within the next days (or weeks).

>
> This variable has three valid settings: true, input, and false.
> (Leaving it unset is equivalent to setting it to "false".)
> 1. Set it to "true" if you want to have CRLF line endings in your
> working directory and the repository has LF line endings.
> Setting it to true is the same as setting the `text` attribute to
> "auto" on all files and core.eol to "crlf".  In other words: any file
> that has LF line endings in the repository will have CRLF line
> endings in your working directory.  If you  commit a new file to
> the repository, then git will commit it with LF line endings, even
> if it has CRLF endings in your working  directory.  However, if you
> edit an existing file that has CRLF line endings in the repository,
> then git will not convert it to LF line endings when you commit it.
>
> 2. If you set it to "input" then git will not do any line ending conversi=
ons
> when checking files out of the repository into your working directory.
> That is, immediately after a checkout, the line endings in your working
> directory will match those in the repository.  When committing a new
> file to the repository, git will commit it with LF line endings, even if =
it has
> CRLF line endings in your working directory.  If you edit an existing fil=
e in
> the repository, then:
>         * If the file had LF line endings in the repository, it will stil=
l have them,
>             no matter what line endings are in the working directory.
>         * If the file has LF line endings in the working directory, then =
it will be
>             committed with LF line endings , no matter what line endings =
it used
>             to have in the repository.
> If neither of the above two cases apply, (in other words, if the file has=
 CRLF
> endings in the repository and in also in the working directory), then it =
will be
> committed with CRLF line endings.
>
> 3. The simplest setting to explain is "false".  In this setting, git will=
 not
> perform any line ending conversion; all files will be checked out into
> the working directory exactly as they are in the repo, and will be
> committed to the repo exactly as they are in the working directory.
> This setting is recommended; if you are tempted to use "input" or "true"
> instead of "false", then consider looking into committing a .gitattribute=
s file
> into your repository instead.  Settings in that file override this config=
uration
> variable, and since the same attributes file is being used by everyone who
> works on the repo, the results end up being more predictable.
>
> Or something like that.
>
> ----------------------------------------------------------------------
> This message, and any attachments, is for the intended recipient(s) only,=
 may contain information that is privileged, confidential and/or proprietar=
y and subject to important terms and conditions available at http://www.ban=
kofamerica.com/emaildisclaimer.   If you are not the intended recipient, pl=
ease delete this message.

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, m=
ay contain information that is privileged, confidential and/or proprietary =
and subject to important terms and conditions available at http://www.banko=
famerica.com/emaildisclaimer.   If you are not the intended recipient, plea=
se delete this message.
