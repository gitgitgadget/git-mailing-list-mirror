Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39F9C33C9E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EF724715
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WWnUQxEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfLMN3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:29:52 -0500
Received: from mout.gmx.net ([212.227.15.15]:49003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfLMN3v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576243789;
        bh=ZHsC37FDsPkCERDHCstANwW48sfS7gkY9+iaDfy0u2A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WWnUQxEs+2bDpRmZJTNSJUNXEuiLx0w+xZ3QqcxVcs4QewEyOgp0NtMqil1ZDJBu/
         tWbRVdkIRssHIDRs+leiwe49FMP11drod3z00+paAHAot0VuP9hiwfrg1so5r9R93a
         lxKZEmuge/HgcE0s/12+bCJgw0fU6fcPOvExVbAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1hbzMB3Kyt-01657k; Fri, 13
 Dec 2019 14:29:48 +0100
Date:   Fri, 13 Dec 2019 14:29:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Vasili Novikov <vasilii.novikov@zivver.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: allow closing console window with Escape
In-Reply-To: <20191210133105.apfim55w7osvskvh@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1912131428490.46@tvgsbejvaqbjf.bet>
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com> <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet> <20191208194046.csf35b7rgycst2vc@yadavpratyush.com> <nycvar.QRO.7.76.6.1912091014220.31080@tvgsbejvaqbjf.bet>
 <1313cb5b-9d6a-f038-bda3-757b4e55bf33@zivver.com> <20191210120219.zc4k5dih25ae3da6@yadavpratyush.com> <949c8fca-bf7d-ebde-4f28-10cf193c0411@zivver.com> <20191210133105.apfim55w7osvskvh@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bbaTfuxI48ScnZVjnift0h+6vuWHRo4bmt6Qeo8T5RcMT3bULwo
 TlnyMyzE9y0Sb3QF5i4NcZ0AOhVr28XMT4Ss5GS2TeiaS+kl1LosqPmn5XaMlNnEFYrvHcE
 WXgXzkgQ/xE5Blzq/FCOQZaaRtBnICjeVpaC588m2uwHylRdzptqXpa5rsCXEHg79Xhfxq3
 0yV699zMpPDkKE6r0o/Nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GdLbiq7TILE=:zB+72e3UnDQeQXA62aINS7
 j6KrRXuk1Czh9r86vdPIIstslye2pqOgZ97/yKha02bRzxVpH6ULcxCbTRx65pcQVmXHPPn55
 iuG03JBNyo5Plh1DQZhQT1jUkTbf+gEJzWjz3itMALZbtIHBJqADDHRayfZMtp4IZ5LLwK048
 21k3gmhRJ5etudk7CPyqI63+2lohDLAhegrRhbj/9eTai8jtL59V+Wwrxz/29EGZBaTqQ4cIK
 t2hjerCKg+g453Lw9F/xseu9Omq/rW+H7mqlmn5i+17Q4E80gbO+nZdLvZlfnq5k9efue6IT0
 u12dKiw1FQ1MT/g0fIwp2KJLxx1QuyTxBRUi9BxqVxUEa4bpO3RusIRaXQsXL+BCm3IxpDn+g
 nBMDBFnKh6ysRqKQgkRyBeuM6f//UpNsbEkWztKlDS1oqVse9MyOQ+g4J4ErDI0FFKFqC2iWb
 XAl5S7FYrbsotiJUMN6GDO0pAnidZrH5Hl7gOBkLg1qQGhTjhREhab9GThAkU/CwdsiaBFFsQ
 zTrnL8HC3XjSj9QaZVmTFH2z0m5HwN0yqDhM/1m4XkIgxKr3Utk9LmBDIEvj8iT7ldlp39ByY
 +HzpiSn5HA8O3xgzr4dveN/pS+1xWxgOPDETf35sFp1847Ht+mVUGaHpu2zF8O4SJtvZvPS0A
 8484ShQq7qrt9wN6arilyMJGmqy7+gCpW26yF9jqGnJnRZG+OFFIteq1A07d+4U7qbZ9qR0mv
 3qeDPnCgG9J/OG4vxWTmd0uNYf/bSN4Vnc3+fHeXlkAnpi9F0/MBQI58Cz9Aw+Hys3UYvrm06
 F907YhOuhF4ZRBg3DYkkPBAunrjnxZmeVqPpwVJ7ZqI5sIhidhaVZdrLvOtyumq48B6qkbYSS
 Bg6frR8ib9sReZw99gKc6QQ8GJsEPXAGcVEnYYyGRUvkPPrEtin6UQ+xsal70c4zo/Ml0BDTK
 LIwo+69D1kl8Q4AAQYsMkYriugUzJqiIzbG1cTetGUlN2vuPOk/sUYgNOMadjAywex+K+Pulr
 7rymhzdqJtOx+iyHRa24QLgPbSoyQekZDG8cgHpuFyONuzciLTpyeAGEGfOYC7Ts64EODTwJV
 JVdQrQGi+BJ4Kz1tysL+jkydGZ1HFQC3/92zs6/LNOhvKoGwbz4ZqcQ+B3UlT0jTI5W75kuJk
 +e7ciCqAtOUVzZGoP0o07n5o7DlHszr1BHywfLXVzcu8ZcUxhEsnjrCltwyi6OLZ8nw1mr9J6
 cfyuXvpwdYSBD2fUpL9nuV4i/ZTz1UXWXP+UYlCCkLIbGdgvRBa/1MZ2Whzo=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 10 Dec 2019, Pratyush Yadav wrote:

> On 10/12/19 01:11PM, Vasili Novikov wrote:
>
> > Sorry if threading was broken: Thunderbird possibly doesn't fully supp=
ort
> > mbox import that I used. Or I did it unproperly. Either way, hope it's
> > correct now.
>
> Threading seems to works fine for you. I meant avoiding top posting.
> More explanation on top posting and bottom posting here
> http://www.idallen.com/topposting.html
>
> > Thanks for explaining. I misunderstood the purpose of the window. If i=
t's a
> > slow ongoing task, then indeed it should not be closeable with Esc. I'=
d say
> > it makes sense to allow Esc to work when it gets into "Success" state
> > though, as in the screenshot.
>
> Hmm, I like the idea. Does that work for you Dscho?

I'm fine with whatever you settle with, I am not really a Git GUI user (I
just deal with a couple of those users in my role as Git for Windows
maintainer).

Ciao,
Dscho
