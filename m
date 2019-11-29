Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DECC432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 09:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99165217D9
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 09:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="D/v5vgrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfK2Jcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:32:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:34411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2Jcr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 04:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575019957;
        bh=I69/mMHxxJcaFyq4gz6h+Br/enDV3aYSH239KIGMitM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=D/v5vgrqGoITLa2DkZa9KuHkoTEY+Sl5EaipJeSnGXjCjFEwJtvdkcPqPcNXud8QU
         RHnzj2D7F1W5lEe13H6xiXiav1T4V57jse6IgIid5eD8obPfFn0BRMIAVord7U6uxG
         flxBJkfFcFuASER81s8MkWNuCAm9DHsYhsQzsrQU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1ieCTY1LRt-003gp9; Fri, 29
 Nov 2019 10:32:37 +0100
Date:   Fri, 29 Nov 2019 10:32:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Wong <e@80x24.org>
cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over
 public-inbox.org
In-Reply-To: <20191128223145.GA23772@dcvr>
Message-ID: <nycvar.QRO.7.76.6.1911291029460.31080@tvgsbejvaqbjf.bet>
References: <20191127125231.GH22221@sigill.intra.peff.net> <20191127125343.GA27983@sigill.intra.peff.net> <20191127125936.GA9877@dcvr> <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet> <20191127200421.GA27456@dcvr> <nycvar.QRO.7.76.6.1911281123100.31080@tvgsbejvaqbjf.bet>
 <20191128194829.GA15521@dcvr> <nycvar.QRO.7.76.6.1911282315570.31080@tvgsbejvaqbjf.bet> <20191128223145.GA23772@dcvr>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jX+J/dyPy1hQwB0ATyZdsXB8jCOEEv7OvltsDCPdp3aDAJAUy1+
 dBpQUEe8anB7UV2RoKS6NGJPyarxYQYXpsRkUfJ57eSsC8xZNC8SJ7ssJ6SgMfjuqQa1ojY
 1+qwSuZ0e7NoxqJvgscnZ445XHXBCdxj0owOpWoeUVSYbIF0QhVjotDPHFVaUCIgSXJoK5u
 k3mNTMvBoLj1SiSHogGyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RSTX9husfzw=:vRgAYFI25frlhrgjolJdbo
 9P4KvpA7n9v/NfiJHEogs5esj6zsZvowUaJtoZ1XKc7vLb3rHS/Bh2JgKlYcfE3KiTLAmAEBj
 5ZWWM5/Ti2RxP0uJgPv728PW1In0eMozEGQddMaJVDlbVgUkdQual+WXxyArQi0dy56wvWKAQ
 Nh7wOv6rYSLet6siKM3gNia0nm2ywNKX7c7qmHE7wocMMQyJBrvWXc+B2K+hOPgPzHX030Cci
 9koul2qYTkX8nYSQaAblt7osrJdO+9vZ/8n5ELkEmzGcPCpavcH7JOh5JPSk9QhLGMGcBBYaa
 m5rMdZGFIdVHMZVniWgz4M0B5vfiIvT6hEI3Iszbk38Mpo6meKqoxlJMa80IllxpK1i71VdNt
 FouweyTzC0Hajlac8flflLWhRLGpOUfnKzIhQO6whMwzf6LrtcmaIEzkZVq5kmJah9qZGrKJE
 zOz0FLSt+4jrwucC252dsIH6DNoT3e7G602OW675+j3vrS86bQyi+jrqhMimOJp64MItbKjXv
 Oq+t2OpkeeJE8lH9eY9FSpYtsl9lU5rgtIMAEM31R64KOjQtqnzxL3zprNaim+Oo9Af33x3B1
 KQxudz/P6Fzocdtdp/b6QWN8j19oVAYKfhvK9TDVLM3EbPY+JM4uKwaAIoyxO9H/NoeljqOyJ
 BjDHdqyK3nS1Fx5BwJPNBTl1YvsBxFOAFoLO39K5qYVxSGkRkRiZz98sH5fdR7B7rO5nV1ID2
 rCy61EEg6KvU4V3YNnxuVFBD5kB5QngCd9h9N7husemRTL2Nz+8q5X9yma9sMKqucFBH98FGC
 2WfBBVb5rcS1UC+Zv5j/5T/OzJYjJYhTtiBzrUKOCnXJSTSAFLG4YbraKnaXXqlS/xFzT/bko
 rsNclCAPQ/MxbD81rnQKXC7CiDq+B8jIxycuPYk3WKtITtnvrsteIqjShe5qDvVIVqx1L1AqC
 tR8LfG92wJ6ckV7c59eKwxxErf7Wg3tKz+Y9LaCXy/XKYyZBvTAD5p3hOOoHnW550wCOgg+9z
 xnhkrLu4PgMausoUmMPbMScxKp+E1FjtMqDNY/C3+Jnc1NBJGVfp9sma75EFCWG1ZfZEcGV3/
 d4YTrTph3Un8wkoriVtscOPDC1kyHevZkm/TaofGXqKLMh5yBK/Aj19BjzFr0S/y/6sJjr/c2
 uNvvzXMSmfsQTWEkCqVOLOcHJ0GEfSB8ZRQ2TRzgCumdAetxOs9NNjVcdTS2YHgAspT1nXrCu
 9U3qn8u+TPBilvOeoujg/i9DFsz3lXU+TnWY+335gyB+Wun8+BLGGiguPhJE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 28 Nov 2019, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi Eric,
> >
> > On Thu, 28 Nov 2019, Eric Wong wrote:
> >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > > And: if I want to track the latest mails in GitGitGadget, what ind=
ication
> > > > will I have that I'll need to switch to `.../1`?
> > >
> > > You can use the gzipped JSON grokmirror manifest at:
> > > https://lore.kernel.org/git/manifest.js.gz
> > >
> > > grokmirror could be a bit of a pain to install because of Python
> > > dependencies, so periodically attempting to clone the next
> > > numbered epoch ought to be fine, too.
> > >
> > > I've also considered adding epoch info into
> > > https://lore.kernel.org/git/_/text/config/raw
> > > so shell scripters w/o JSON parsers can use "git config"
> >
> > I just had a look at its contents:
> >
> > -- snip --
> > ; example public-inbox config snippet for "git"
> > ; see public-inbox-config(5) manpage for more details:
> > ; https://public-inbox.org/public-inbox-config.html
> > [publicinbox "git"]
> > 	inboxdir =3D /path/to/top-level-inbox
> > 	; note: public-inbox before v1.2.0 used "mainrepo"
> > 	; instead of "inboxdir", both remain supported after 1.2
> > 	mainrepo =3D /path/to/top-level-inbox
> > 	address =3D git@vger.kernel.org
> > 	listid =3D git.vger.kernel.org
> > 	filter =3D PublicInbox::Filter::Mirror
> > 	newsgroup =3D org.kernel.vger.git
> > 	nntpmirror =3D nntp://nntp.lore.kernel.org/org.kernel.vger.git
> > -- snap --
> >
> > Isn't `inboxdir` and `mainrepo` incorrect?
>
> How so?  It's fine to have both in case users need to downgrade
> to older versions of public-inbox.

I must have misinterpreted the purpose of this URL, then. I thought that
was the configuration of _this_ instance, and that I could use the path
indicated by `mainrepo` to replace the `/_/text/config/raw` part of the
URL to get to the repo URL.

Is this just a template file, then?

> > And yes, adding `epoch` information there would be very welcome.
>
> Noted.  Not sure if the "modified" and "fingerprint" keys of
> manifest would make sense there, too...

I have no idea what purpose they serve, so I have no opinion on this
question.

Thanks,
Dscho
