Received: from esa4.hc3812-35.iphmx.com (esa4.hc3812-35.iphmx.com [139.138.58.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A93C6A38
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.58.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527103; cv=none; b=DFbssE2EwDWmbK3rp7uL6/mAQtHMBaM9EtI2431bx3Qb6MZfglEfp7FNaWfneAMvy+RfaVh9Q5aX3SaxeqCJ8zqwFfwxvyYvWMq1nVDtU5F4GDaDtfcn2PBM4yFqprohJSz86BZxox50cZbPxgMYYlBaFGwzFQSi4dESA1npkkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527103; c=relaxed/simple;
	bh=3PZZY1vrrTv2pq6IxfLPT/1Dx8uaMVVlFAqZtHDiYRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDDRVSQGYAeIon4VBE5gFfX3U/pz/OJC/en3yIsugm4omSAwUvVuV98PMQaseLCru0Mj4t0e7atEAZYZBtDKwcM4/4kaE92vnbZj1cpjCjLOGRrRCvNBLzTVUt3q2Nbq45gMMGrIERBKfxR161krX8Mz8pW6RARPvcaS/PSRLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com; spf=fail smtp.mailfrom=creditkarma.com; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=okPhggRL; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=qHIgPC8c; arc=none smtp.client-ip=139.138.58.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="okPhggRL";
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="qHIgPC8c"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=creditkarma.com; i=@creditkarma.com; q=dns/txt; s=2;
  t=1780527097; x=1812063097;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=3PZZY1vrrTv2pq6IxfLPT/1Dx8uaMVVlFAqZtHDiYRk=;
  b=okPhggRLy+DQSmlxZv0Zb4mDmul4/VqL2lk7XWOcLpvKHXl2DdoX+IGD
   H1PLzOTESho4IYK4KRZHKr0fJAbmACOLOxjnTKSpyeauPTqAM2UAlsv0S
   agYxuE5/ri0vxENcot2YqyxCxPKsXsjwjhOIisp08b7nbXNd2aQLoH7S+
   WzFgOMFBhI1zcmCCm9LZpxSexOxKBBuapKbp+IZvMaGP5JvlQ+08SQ0I3
   TB7+GLbGrDFjklz4eblRCypc0SimEl7lNyJN3qm169UPYml/0a6+2SeI+
   iYBuzk2bjobId7enYTjCPio3P3TZHL15vFWi3RborPO82mzXZQnbRvOI4
   Q==;
X-CSE-ConnectionGUID: Y1yOK4JuSJOWZBarBNNj4A==
X-CSE-MsgGUID: 6u5mhu/9RZGqmiun+QEndw==
X-SBRS: None
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:p+8dfqkZXxMgsIP5l9YjE4vo5gzcJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNCm6Caf+PYDOje9xwa9/k80IFv5HRyoU2HAs4qXhgQy4T+ZvOCOrCIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48z8kk/3OHuOiYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAfNNwVcbCROt8pvlDs15K6s4G1A5QRkDRx2lAS2e0c9Xct3yZ6ZfyOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkEfzsCa+v9T2Ms0MS+7uR3Q9zxC4
 IwlWaiLdOscFvakdNLx8fVvO3oW0aVuoNcrKJUk2CCZ5xWun3DEm52CAKyqVGGxFyke7Wxmr
 JQlxD4xgh+rtrun55HnaPRXpOMcHuPiJqk5nHM85GSMZRomacirr6Ti4NZZ2HItj5kLE6iPI
 cUebjVrYVLLZBgn1lU/Uspv2rf1wCOlKXsG+Tp5poJui4TX5Ap2yrLgKsaTed2HXshRtk2Cq
 27H42fwGBQTcteYzFJp91rw1reXxHyhCOr+EpXm66NvgEDUl1YhJwQTVEa94sCUjEKhDoc3x
 0s8v3BGQbIJ3EOqUvHjUBCi5n2JpBgRX5xXCeJS1e2W4q/d4gLcG2FdCzAfOZops8g5QTFs3
 ViM9z/0OQFSXHSuYSr13t+pQfmaYED58Udqifc4cDY4
IronPort-HdrOrdr: A9a23:UY874axaj4eDNKyjJoukKrPwDL1zdoMgy1knxilNoNJuA6ilfq
 eV7ZImPH7P+VEssRQb+OxoV5PhfZqxz+8X3WBuB9qftWDd0QPGQr2KhrGSoQEIdReOk9J15O
 NLSYQ7Itv2ClRxkMb95yeFM/tI+rK62ZHtr93zi1N2Qy9XS4wI1W1E4wCgfnFLeA==
X-Talos-CUID: =?us-ascii?q?9a23=3AkZlT92tOXb4UiOKTZhwp+N3s6IsUK2z67yvyPnS?=
 =?us-ascii?q?aLllbYrSPY3m2+v9Nxp8=3D?=
X-Talos-MUID: 9a23:XXcltAXeHuyQUzHq/GHx2TRiKYA52ZaBEUUMjJNFguSCOTMlbg==
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="48001728"
Received: from mail-ua1-f69.google.com ([209.85.222.69])
  by ob1.hc3812-35.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2026 15:51:36 -0700
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-963b11561bbso67605241.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 15:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527096; x=1781131896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8RGgYjRBYy1/RhPjHoE22+MxKEzAkLubgz5VJ/OKTAA=;
        b=rLymIRqt9jOrHCHJAWtrmPgs4NgFPmJcxsHLyV4dTUTlPylA92OxVEsc4ONpIKVA4O
         o4psq4vH2z1D1vkVzsUpiP3SrVkiJITKNBbunOLG4SXwRdeppcHcBHfJFum8DN0DX2lO
         hXs01kpqvX3x4eT4oBsn3Z+goToxf8nDZtDQ4JdpXeeM8SxtjHqgREx3GsjZD61SW04P
         SVECl8iOUTIIvmvrvYSRoBCrt+4VlDv7urP4W5ew1PPwp2V1Wc5K1Y2IYSMs9RZIeNIO
         Er66oZd2oFmaZD1h4XTTXSXI9XwpC1RzOPFXHkrZYLX+wbrPzGrksv4HhNEm9oasM7gF
         dVVA==
X-Gm-Message-State: AOJu0YyiHe50nSH8M1pItSlCzleWqb8HAZYN5ocrQFJp1CJn+qxEypEv
	tjBRUxkRQyXBt6H/siJFH/L5oPLooStcz/AT44IS/yFz31VMnxX181f4tdFPcvZiKk8O82M8apo
	7wkZif8vMWRd2Phi7uuhIdNbR3IrHw2BQbe3C2FLw+lM06prQeAR5I4yUOolbQ4ZHe8VBX2FD+1
	E1eXwF8NxU47i62TOMODN3EEzrMI7qmcVQ1DgmdFbg8WwXAkIxWOL162Fp9iZqA3hSy+SCr+VOR
	XSObMkiwcrsfs+OEydNVxAp0rQlSmHqFnht8Zsl6w==
X-Gm-Gg: Acq92OEiV3pxtvNMb0rHHzRGzlmlar57KTh4kiwkegMjI0+T9UwGLDBQPmVHjyLLa8N
	MeU0Js1rQvntved3CY/92RpgKhU6vvRwdxLObae8c1OOSGniYSANiJ80jW3ia/wP1IACmIdUKKY
	pZgkSsRLAxfwxONQI71wZJ1dBSEbTDLW7N4SJy52fM0ndzJQxVXhfyE2yabnESdLeu5PZTGxjta
	Igb46qcIqp9K65jGkpUlq9UkAD5gWN3feGPdXaBo+ZcHoy5WnagsCRTR0WKHHn3jnDzg8xaK3Py
	yb3qVfwiX+aJSLYIpWCNS1UHUYoDs4Dw8zYtJ8G/IyiLXjPw2m0saizEqJ26I6pk4NifhUFJR7e
	wiQ+OsGlqxOihw8ROSpnMVTK5Hq8VPBr0O6k3GcVQ1ZEnt8UvEF3WoTmSLdXe93h7XBwRlMzwGf
	eO8QATH0sMEPyoeGI=
X-Received: by 2002:a05:6102:41a4:b0:6ca:32f1:f06a with SMTP id ada2fe7eead31-6ec426f4112mr3088249137.15.1780527096103;
        Wed, 03 Jun 2026 15:51:36 -0700 (PDT)
X-Received: by 2002:a05:6102:41a4:b0:6ca:32f1:f06a with SMTP id ada2fe7eead31-6ec426f4112mr3088240137.15.1780527095649;
        Wed, 03 Jun 2026 15:51:35 -0700 (PDT)
Received: from sjc41b2.mail.zscalertwo.net (sjc41b2.mail.zscalertwo.net. [136.226.142.111])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-96413d0f4e4sm176791241.0.2026.06.03.15.51.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 15:51:35 -0700 (PDT)
X-Relaying-Domain: creditkarma.com
Received: from mail-ot1-f69.google.com ([209.85.210.69])
	by sjc41b2.mail.zscalertwo.net ([136.226.142.95])
	with ESMTPS id 6A20AFF708C10000;
	Wed, 03 Jun 2026 15:51:35 -0700
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e60737a964so37266a34.3
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 15:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=creditkarma.com; s=google; t=1780527094; x=1781131894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RGgYjRBYy1/RhPjHoE22+MxKEzAkLubgz5VJ/OKTAA=;
        b=qHIgPC8caWAEOzkwjIsdCAYHKsjktQ5dOaldx34a1mZBqLmKFEa0+I8mECV+InpHx6
         Os7mVvNX/xNJF0vmBIRsAJfQEMvdrDGopFWT3i1hbpIf5IW9p5G2U8FVtimr0HN1aMU7
         KNFGSXpnfyG2BBcUGrbSVx+hA/pI7vPMVnSKItrh658YEcgC3YVVuYHq8TO6ses/2X6A
         XKy+hMDdFWJL9ZXbzxgWI9UTnORejRhldCGtCBPudgeFxogOUpnfAjySiZnZzrotXPMC
         yxINd+MEG/AdVL7CZiskyB/bY09CJtR98MQ2pUlrJlqQ5Ni2466hWo8AsldiezAitems
         AvPg==
X-Received: by 2002:a05:6830:2042:b0:7e6:f172:ffd1 with SMTP id 46e09a7af769-7e6f173011emr1952506a34.23.1780527094272;
        Wed, 03 Jun 2026 15:51:34 -0700 (PDT)
X-Received: by 2002:a05:6830:2042:b0:7e6:f172:ffd1 with SMTP id
 46e09a7af769-7e6f173011emr1952493a34.23.1780527093912; Wed, 03 Jun 2026
 15:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
 <xmqq1peots9i.fsf@gitster.g> <CAPGaHksjsSefYmGPBxKLw8DDADR5AwTiHTbHq0UyBBtg3CKq9Q@mail.gmail.com>
In-Reply-To: <CAPGaHksjsSefYmGPBxKLw8DDADR5AwTiHTbHq0UyBBtg3CKq9Q@mail.gmail.com>
From: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Date: Wed, 3 Jun 2026 15:51:23 -0700
X-Gm-Features: AVHnY4JGqQ4OZjQ4qRb1n3neWbGNLJCR0nc39OF8wNZK8FSDoj-OBcfqQXj7hXs
Message-ID: <CAPGaHktHLPUeSuhETwyBo+jE2fMu40jHW284PN+2oY1YJ2j0Yw@mail.gmail.com>
Subject: Re: [PATCH] worktree: record creation time and free-form note
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Zscaler-Block: 0

Hi Junio,

I looked at the usage of `.git/description` and I could not find any
usage.  We do have
Git branch descriptions which are stored in .git/config, but that does
not seem to be
usable to store the worktree description or the worktree creation timestamp=
.

So are you ok if I send the PR again, just using "description" instead
of "note"?

Best,
  Norbert

On Tue, Jun 2, 2026 at 5:03=E2=80=AFPM Kiesel, Norbert
<norbert.kiesel@creditkarma.com> wrote:
>
> Yes, I could change my PR to use $GIT_COMMON_DIR/worktrees/$worktree/desc=
ription
> instead of the currently used $GIT_COMMON_DIR/worktrees/$worktree/note.
>
> Give me a day, and I can create the updated diff.
>
> Best,
>   Norbert
>
> On Tue, Jun 2, 2026 at 4:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > "Kiesel, Norbert" <norbert.kiesel@creditkarma.com> writes:
> >
> > > From 130cd5e4a25e6672b2a97268e1100b6ef03fa552 Mon Sep 17 00:00:00 200=
1
> > > From: Norbert Kiesel <norbert.kiesel@creditkarma.com>
> > > Date: Mon, 1 Jun 2026 17:03:39 -0700
> > > Subject: [PATCH] worktree: record creation time and free-form note
> > >
> > > Add per-worktree metadata so users can answer "what is this worktree
> > > for, and when did I make it?" without resorting to external notes.
> >
> > Although I am not personally interested in this topic all that much,
> > let me point out that we have $GIT_DIR/description file that may be
> > useful for something like this.  It has been the canonical place for
> > the main repository to identify itself long before secondary worktrees
> > were invented and $GIT_COMMON_DIR/worktrees/$worktree/description would
> > be a natural extension of the concept, I'd presume.
>
>
>
> --
> Norbert Kiesel | Staff Software Engineer | Credit Karma
> norbert.kiesel@creditkarma.com | www.creditkarma.com
>
> This email may contain confidential and privileged information. Any
> review, use, distribution, or disclosure by anyone other than the
> intended recipient(s) is prohibited. If you are not the intended
> recipient, please contact the sender by reply email and delete all
> copies of this message.



--=20
Norbert Kiesel | Staff Software Engineer | Credit Karma
norbert.kiesel@creditkarma.com | www.creditkarma.com

This email may contain confidential and privileged information. Any
review, use, distribution, or disclosure by anyone other than the
intended recipient(s) is prohibited. If you are not the intended
recipient, please contact the sender by reply email and delete all
copies of this message.
