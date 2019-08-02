Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FD6E1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 12:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392781AbfHBMzn (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 08:55:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:46357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392771AbfHBMzm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 08:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564750540;
        bh=SDt5217shqEIRwp7T5sPUkhOeEdOVXSyfwpywXwyGFg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J+1FszR1vBLzoznlV7qRIjKHZzV6AjsoWqzRVAsDbEtfWG4RInkDjyh+bIgGtTkP4
         pKmnUSMQ7SYoARuJ9g/hp8HAgM+JB0+RIepIjSDNxnV3yKX5JFoAKNJPrsqjL4akr4
         SaGqX4CK85wPp81D9DP8ZD4rrA34yFycyGlVa/Q0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW8PN-1hrdPZ0yAT-00XIjj; Fri, 02
 Aug 2019 14:55:40 +0200
Date:   Fri, 2 Aug 2019 14:55:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
cc:     git@vger.kernel.org
Subject: Re: Antw: Re: blank lines in pre-created merge message
In-Reply-To: <nycvar.QRO.7.76.6.1908021449400.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1908021453460.46@tvgsbejvaqbjf.bet>
References: <5D382AC1020000A100032608@gwsmtp.uni-regensburg.de> <nycvar.QRO.7.76.6.1907251204310.21907@tvgsbejvaqbjf.bet> <5D39812C020000A10003265F@gwsmtp.uni-regensburg.de> <nycvar.QRO.7.76.6.1907251355500.21907@tvgsbejvaqbjf.bet>
 <5D3FE919020000A100032932@gwsmtp.uni-regensburg.de> <nycvar.QRO.7.76.6.1907311448280.21907@tvgsbejvaqbjf.bet> <5D437D21020000A100032A6F@gwsmtp.uni-regensburg.de> <nycvar.QRO.7.76.6.1908021449400.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ISAf6E6M78ESkA0snLy/HJ06fVEbnDTI1XmETOvyRSAAOkrAm7K
 nEVzP6FuRpn/ey+xEjn60s3cQm08EMEK9vjC00HwY4SOe7f4xcGUPBRdsvMgzzes5BM7fIv
 4rYUG7/lW1k+tVcr9i72QbHkNuBO+55W+DAo2cry8iH16Nhk985EymnGqIBW5F9S3dP7TOi
 D41S+brdgBctnB1HeproQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IyyWacxOOhI=:VG0PyhigXrEj4nOq99fDWQ
 9/9JzEACP211UmXZIMn0p70joBieKpABWFnC6Dra2NTlWe8CdNgUB3dap64O/zPAzBKogZ9Tb
 EVwyIKrBsI7rOOIYOP3SooFBj3k7AgiFF/0uKDJ08zEAJp1vIb+tcutxvE2Ki+OWKnJ+iHKB8
 BpO4papMiq1C/LJfYRNW6f8X2z/TS0pRjejAhYvYRD7EAlDiTDYNHzrNBkFkexT3jX+7S0pfE
 Eib424TZqPh4WtJWYRWWrwkKLBbSkEp0cU/6GNhgQ/X9CTzedCtB1YJZoxesPFsV64/1jDyhL
 ULRP3wujd9rm9z063o+V0/rpkEgEMccpjUm4frnMGdvB/Sw6fIkR1+7ct6VKM34gkDIHtV54s
 NRChLyZKgr+3/jBpBcR9sOLQDae6AIGsf45ZyO8Jc0A0XVv0Z6g/UAKkSDo4NiI7Se7y4M1lC
 M6ogkg+gb5Pb/Je/CPEEDEmPrqb0ULrRXxu6YyTmdUvoS86POAk8leA+BDilrHVz0m4NjYvd7
 7mjgOvIemwgDLt+bNgpRZ1AutKwpLnGw9Y54WSCixOC+fo/r7qBW9jY3xHpS92UZDzdx8kODP
 MLYICss2CnoQDASBei0s6QUWUEvvTmYRXIXR1XAp+1K67BVGmlcCL+BhZlLK1DVkVyUbEwsLh
 4lwaWpxYR1xncEFObX/zD+ygC9wQC/lpUZfxn94ucqAg0+rhza/RTd+qD6FM6r6zMkVbJX62h
 RZ4WiNGwNAEuaaFieK3Q35R7vUCs2Cx3qDp35RByaleYdpctaTi9km1yV9di3sMM/l5yJ+IkM
 vOxJsF+g73Mjxll/1GN28WQ9Z8xk6YIg3OabqEfHrw7lZHRzEEyznWJN5JsaeHhsN0aPQPUsh
 9fMoqayqftzjJyIo6ngIlni3Y/zn+vhx+kfcJ2ed4mEUu7f+jgnLaebjv4EpQkAV12qNarJxD
 dAHERF/JoEGE2yJVkZVUmqdRwqhUQWYU9zYOjxtdGeSIVzbWbEm+01KulSjlkvXW0WBWRw6/1
 b8VueXDs03FD4hZpFKGqlEBrQziM7Ex/uOHdD4MDUPNGCDQAudqbj8Xk1xlU98ew2YhRm7gYw
 d/OZsU26x/TnOv4kmKqjOXQYlYnB69ulZE90g1q6XDFHgoxNkb0TLd3c1z8Xo1f71JF7/UP0G
 OTWoQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-Cc:ing the Git mailing list.

Please make sure to keep the Git mailing list in Cc:. I get extremely
testy when I see mails asking me for personal help in private. As long
as others can learn from my answers, I am fine with helping. I stop
being fine when I feel like I am mistaken for a free-of-cost, private
help desk.

On Fri, 2 Aug 2019, Johannes Schindelin wrote:

> Hi Ulrich,
>
> On Fri, 2 Aug 2019, Ulrich Windl wrote:
>
> > Thanks for the pointers. After a little digging it looks like some stu=
pid
> > error:
> > To me it seems that status_printf_ln() adds a "\n" at the end of the s=
tring,
> > while status_printf() does not.
> > It's unclear to me how the comment char automagically is inserted at t=
he
> > beginning of a line.
> > The magic seems to be in status_vprintf().
> > I'm too old-fashined expecting a function to have a comment describing=
 its
> > purpose ;-)
> > Unfortunately compare_to_commit() is a bit complex for a newbie on git
> > development.
> >
> > To me it looks as if the line before "It looks like you may..." should=
 NOT be a
> > comment line, but an empty line (to be in line with the regular commit=
 comment
> > template). So passing "\nIt looks like you may be committing a merge..=
." to
> > status_printf_ln() looks wrong to me.
> > And "and try again.\n" seems to create two empty lines that are NOT co=
mment
> > lines.
> > IMHO these to lines should be either comment lines, one comment line o=
r no line
> > at all.
>
> This all sounds like overly complicating things to me. The problem
> itself looks a lot simpler to me than that: All that should be needed is
> to remove the `_lf()`, recompile, and test (on Linux, you can use `make
> install` to install Git into your `~/bin/`).
>
> > How would I design some automated test to check whether the outcome of=
 my patch
> > will produce the desired result?
>
> I am sure that there is a test case that already covers it. If you run
> the test suite (via `make -j$(nproc) test`), naturally this test will
> fail and you have found what to change to verify that this does not
> regress.
>
> If you do not find a test case that way, I am sure that you can use a
> similar `git grep` invocation as the one I gave you earlier to find test
> cases in `t/` that test for similar things, learn from them how we write
> test cases, and add one of your own.
>
> Ciao,
> Johannes
>
