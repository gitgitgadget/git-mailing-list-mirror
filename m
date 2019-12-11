Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59153C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 13:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1482077B
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 13:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gtkW1a5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfLKNhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:37:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:55993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfLKNhd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 08:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576071449;
        bh=7iiaRgh9k+rA/To0+WY3MEaIB3JuUvg96ACGUQwyEig=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gtkW1a5h+6hHArhywv3jvLix4k86GwYmgYjuUpYea1fcoSAvKhxFgQOHzpp/taHpz
         jBWTIi2+xqrztUJSV7rprcutHpep6/WTfWpcDsUXCaq6+Rs6j/yQNCyhWY0K1qCMLK
         dprbeHqz0rQhdH6/FCF3BJ9qtn3CjsXn2opCFMQA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1iCKBd27pI-00X4Yx; Wed, 11
 Dec 2019 14:37:29 +0100
Date:   Wed, 11 Dec 2019 14:37:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 7/9] bugreport: add packed object summary
In-Reply-To: <20191211002934.GB107889@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912111436290.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-8-emilyshaffer@google.com> <nycvar.QRO.7.76.6.1910281608170.46@tvgsbejvaqbjf.bet> <20191211002934.GB107889@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fvTL02AzaYDmMy4JnbaMAPMC+VU38FClJdgXMEMXT8nEp63TFNK
 bMZcpPoAbJwWA4zGRTIajm6ahkGHV27U64w0QCFMGetAg6H8Sui5u1N7ieZXfp+VfzdiuX1
 yzsHoWoCyzIBHLKyF084eOHkC3cH1b/44h5mExYYpn/I+vIz4tTv3OBtBr1hOkZaw2f74Sr
 HNE8t+o0iw1unvfN33cHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bJhmK3z6N0Y=:k8XGmra34kg99sZEv00uEC
 oIopsrITOcZUmaSsgm7gwR56qvoZZXpzza/D+vBPdtdwl0t2ZYfuHXANpBR7qTD8CORtWU2M9
 dsDYSsu5xRGph6uZlH7xBBQKgY1+rFP9KUQrRcj/WkBTpUyxPw/cawt1iMKDFmCoy7ucTAqqk
 FA2m2kCTbi27eWYR+TcjaBwiMUFV/uJwdIUPTQK07U7WtA0wcLSwVNO+Iu31OW40aarjZCATs
 StG98MQNjCjeXettpV/pPOLUlKwBfmhP5Ehs6EKUpcLAxZ5H9gfxyqxcng2zNmc8ziy6LRLwi
 sqgDk+BMgnIQhqx9bIIU3dmepq7BOBxFft2m+y3+nsVm+RPjH+hShKQJC33A8GUYCDMG9AIKJ
 aPP9qtNq85Fvd0FX058ud3OSkEsOH5SSK3r5THfMSJgoeSKJ94sMhvJC7f2lcEKlgw79MV6y9
 9bcCP79H3v8EIfbBaxeINHNxXk9gv8bi36fgfRcEvps7/sDee11RSFipjEGpfP2xQfT4DY0X0
 6nmMA2TsCDg5hKCuGreaQSPL4CpQmQHg+ehVv12mIYS1dDf/h2TZq0NBYQWaHQE54Re53qWKX
 fStkVCyzmeKXM/FzQMvMtCK4j6nrKyQA1k3Z5rMEzX/hUWKisasZoU+0DTOhhMRtZ5qmQRokT
 1/x399DnojhqVLUi+tCDQKSSX4MYu5Hnx797DHAHRaR6wpXZwv7/8z8XkXHrdwmSx68/nukWZ
 +DBoQ2aHRNdKuvm003F2s8Q/QckHOxEr+2phNIJyet9wuTW4qYUTf41pBSOipTpet0G+2T62Z
 dtaDV7ntC+IZ/8y7VJK9DCqiVQIQoy8X33oj/JPx6z8gx4s6sFG5+cINYekg9GSQs6Nma4Stw
 rkAN/njuykQragm2+DkLckjfqLg7un2lzpsug0hf7rmnzrMrtbuWlHADHfRh9G0Zdv98XwW5M
 ock8xQWHwBsNhbL0imtH6oEou8W7UMAg5OxpwqgqFzlqJmbPd1b7HAzgno6lNKsgFxS2Oxqwc
 QKIw2WBOUG1uBlqKIjp7pcbEYAWstutv3DQwGiLvjI1rCSWcSGbrNO3EU6MK7EG2enw45Ieiu
 BPFOCXV3EO4MKAzTkF8HBcKKldsCMgDKLlYNrGWbD0RNHzfd3N+g3GGZvRkzr6OTlH9CCsewa
 R8lDz7R/0KCA15am0Foid0UCWnFF7CJhD9JjpB09sx3F6O3cXxQXm85pWriNIsUgumZ9GRpqo
 l8bWYrFbaiGdgdcq0hTwpKVgZ60h6kl9GKbGzzPUNjVuoqdUopsykNb0s3hU=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, 10 Dec 2019, Emily Shaffer wrote:

> On Mon, Oct 28, 2019 at 04:43:50PM +0100, Johannes Schindelin wrote:
> > Hi Emily,
> >
> > On Thu, 24 Oct 2019, Emily Shaffer wrote:
> >
> > > Alongside the list of loose objects, it's useful to see the list of
> > > object packs as well. It can help us to examine what Git did and did=
 not
> > > pack.
> >
> > Yes, I was write! Packs are next ;-)
> >
> > >
> > > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > > ---
> > >  bugreport.c         | 21 +++++++++++++++++++++
> > >  bugreport.h         |  6 ++++++
> > >  builtin/bugreport.c |  4 ++++
> > >  3 files changed, 31 insertions(+)
> > >
> > > diff --git a/bugreport.c b/bugreport.c
> > > index 54e1d47103..79ddb8baaa 100644
> > > --- a/bugreport.c
> > > +++ b/bugreport.c
> > > @@ -219,3 +219,24 @@ void get_loose_object_summary(struct strbuf *ob=
j_info)
> > >  			    objects.nr);
> > >  	}
> > >  }
> > > +
> > > +void get_packed_object_summary(struct strbuf *obj_info)
> > > +{
> > > +	struct strbuf dirpath =3D STRBUF_INIT;
> > > +	struct string_list contents =3D STRING_LIST_INIT_DUP;
> > > +	struct string_list_item *entry;
> > > +
> > > +	strbuf_reset(obj_info);
> > > +
> > > +	strbuf_addstr(&dirpath, get_object_directory());
> > > +	strbuf_complete(&dirpath, '/');
> > > +	strbuf_addstr(&dirpath, "pack/");
> > > +	list_contents_of_dir(&contents, &dirpath, 0, 0);
> > > +
> > > +	// list full contents of $GIT_OBJECT_DIRECTORY/pack/
> > > +	for_each_string_list_item(entry, &contents) {
> > > +		strbuf_addbuf(obj_info, &dirpath);
> > > +		strbuf_addstr(obj_info, entry->string);
> > > +		strbuf_complete_line(obj_info);
> > > +	}
> > > +}
> >
> > Okay, but I think that you will want to discern between regular `.pack=
`
> > files, `.idx` files and `tmp_*` files.
>
> Discern in what way? How would you like to see them treated separately?
> They're all being listed here, not just counted, so it seems to me like
> I can read the generated bugreport and see which files are index, pack,
> or temporary here.

I take your word for it (sorry, it's been half an eternity since I wrapped
my head around the diff, I forgotten pretty much all about it ;-))

Ciao,
Dscho

>
> >
> > > diff --git a/bugreport.h b/bugreport.h
> > > index 09ad0c2599..11ff7df41b 100644
> > > --- a/bugreport.h
> > > +++ b/bugreport.h
> > > @@ -24,3 +24,9 @@ void get_populated_hooks(struct strbuf *hook_info)=
;
> > >   * will be discarded.
> > >   */
> > >  void get_loose_object_summary(struct strbuf *obj_info);
> > > +
> > > +/**
> > > + * Adds a list of the contents of '.git/objects/pack'. The previous=
 contents of
> > > + * hook_info will be discarded.
> > > + */
> > > +void get_packed_object_summary(struct strbuf *obj_info);
> > > diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> > > index b2ab194207..da91a3944e 100644
> > > --- a/builtin/bugreport.c
> > > +++ b/builtin/bugreport.c
> > > @@ -68,6 +68,10 @@ int cmd_bugreport(int argc, const char **argv, co=
nst char *prefix)
> > >  	get_loose_object_summary(&buffer);
> > >  	strbuf_write(&buffer, report);
> > >
> > > +	add_header(report, "Packed Object Summary");
> > > +	get_packed_object_summary(&buffer);
> > > +	strbuf_write(&buffer, report);
> > > +
> >
> > Hmm. At this point, I am unclear whether you want to write into an
> > `strbuf`, or directly into a `FILE *`? I would rather have only one, n=
ot
> > a mix.
> >
> > Ciao,
> > Dscho
> >
> > >  	fclose(report);
> > >
> > >  	launch_editor(report_path.buf, NULL, NULL);
> > > --
> > > 2.24.0.rc0.303.g954a862665-goog
> > >
> > >
>
