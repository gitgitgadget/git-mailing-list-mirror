Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052B31F462
	for <e@80x24.org>; Tue,  4 Jun 2019 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfFDNke (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 09:40:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:51609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfFDNkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 09:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559655629;
        bh=JxNJGA/0lIuawoZZgipa1j/c5ZoajEdI5QtBuAcjKio=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RCh637//cOCpD5mc7Yy8Mveyu3SmbTF5U7WkmOzUfpQMOhJPZbf0WKULUkxx8jlhG
         EOJiBvotkEueClZAYHVvYrP5h7W4LNfAt+qMEtR/syfc6on0g/c3Ot79sfqPKGzZNi
         M1pacrreFhcjNW1NsEc3Y0oaBwEgbW0Z6ONdc7qs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgMCe-1gkjub1p80-00nkGt; Tue, 04
 Jun 2019 15:40:29 +0200
Date:   Tue, 4 Jun 2019 15:40:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH] am: add --check option
In-Reply-To: <c1dec466-55ca-8543-8f4e-b5daf1e0eab6@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1906041539090.1775@tvgsbejvaqbjf.bet>
References: <BUKFSM2OTJUH.38N6DGWH9KX7H@homura> <c1dec466-55ca-8543-8f4e-b5daf1e0eab6@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yp+jYYs30RjbFzyjCjKteRmoubuk13sUtWrldKHXb46u6Y/DzsD
 lADIgOlvSym+iaFF/xMTctnAUFJ6iQQM8sK21V35pG2oClAhpG1XyGNBZSB59aX7nA7vgvz
 PqU7L1AGbKBGcoB3dKHKSYxk6UfOXgHYJcATC+BYkJtuILcRyPG1som3JTp4wKtbB1rR5m4
 mXeJgF4+eg7RAhTPTv67Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xs93UFd+Hgc=:dTWGU64ovdbmJrhfwlFkSP
 DonhvHxmjuVA/45fkNGLJ1s3rBrzZHsRlklQJWD9lB/J+Yf5Z/YZpB2ByT7vtzxUClZHKy6XE
 ABJoPqggNQENPgY7CPM1HviPL1sf8IAj+TcZ2q7JRzG4vZzH723/UHu+vwI6aNe/8/Cz/Ldwq
 ZJR3TAW7ZdguTaUbZFTg8CwMsXAyYX5sc31rJjPeLMwNh4nwRXhuExC0r4iTT7PKHUgUgHAVl
 p8rngEkdMuKrRe/Nln0EQqqA0MAHt6VBe/HE5JHvmQiTHgiIS0lleu+NKHIeJP5upuGdUNMvN
 arkoAaJZHPJDuJ/zYD6YeUiaZalf+ki/Dpfl42o18gsGpyz/y4LA3k86vLTkZykhi+Co514ZB
 olj1ey3fzo84Nkbk20OLiYnwfmx3EM+fQ/19w2Kri8ruf2ONcvlU86NwfNxqJSC5MRniiFCYg
 Lq78fh871FSBiZRG3cLORu3Sg/Nl4u3LTmfyZbYMzBrRM82OjwQZaLignySIMQaKiRBQBJwBo
 9FtELMY6InjnU941g+PrO3JWt9iYB4jYfWSRN37nOlmJD4qfx9oEQafQ4XSFQPX7yonK5wCr5
 bGXppyaNq7bpWykgFhff8ZZmP7ThTTWYgDC8AnhSWagPFjmKkVrTOiVz2F+uN/Yhtmx24OwE+
 ZU/xop8ZXW63rXhqzwD6t7Z8noyphSRp4cYOtjHDgFyV/GnrDdtGXzhldwA+7YwsmgLwKMaif
 a7PojteKkr5HKia3E1HWMIWYIDQm+bq5RExCJ27y2M/ZOoj3Bo0UpDo9+AOZu3lohV2a6AO5c
 1u4nrVLrZvOCLRYQHUiVkT4DYeu+N65yBQhOr2r0agSDmNuNUZZDn711ai/Ny6/Y8nn+GAiza
 dnwPXO84NzDuxOhfnXex4aojvDxs9vDiMWz6eC/7PGs0Llc8Nmm17uWxzrlDa2flE9Btfiz2F
 +fXUwtJvxI9WkmfReMpPoaebHT8SAhcRMTsVMdUO3mD2+vivAP0bM
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 4 Jun 2019, Johannes Sixt wrote:

> Am 04.06.19 um 00:00 schrieb Drew DeVault:
> > On Mon Jun 3, 2019 at 11:09 PM Johannes Sixt wrote:
> >> I have to wonder how --check works when 'am' applies multiple patches=
.
> >>
> >> When the second patch in a patch series depends on that the first pat=
ch
> >> is fully applied, what does --check do? Without the first patch appli=
ed,
> >> then a naive check of the second patch will certainly fail, doesn't i=
t?
> >
> > Yeah, this was being discussed in another thread. It'll fail if the
> > second patch relies on changes from the first. Open to suggestions on
> > how to improve that, but I think it can be improved in a later patch.
> > One solution would be to apply all of the patches and then roll back t=
he
> > head, but that would dirty the reflog and wouldn't work on a read-only
> > filesystem (which it ought to, imo). We can't just say bugger this for=
 a
> > lark and ask people to use git-apply, because git-apply chokes on the
> > typical email which isn't in the one specific format git-apply wants t=
o
> > see (git-am massages emails into that format before sending them to
> > git-apply).
> >
>
> You can 'git apply --cached' the patches on a temporary index. This
> works as long as no merge is necessary, because that would require a
> worktree.

For extra brownie points, this could be done in-memory, without writing
out any files.

Of course, while applying diffs should never need any merge, with the `-3`
option, merges might be necessary, still...

Ciao,
Johannes
