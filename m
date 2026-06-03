Received: from esa6.hc3812-35.iphmx.com (esa6.hc3812-35.iphmx.com [139.138.46.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE1525776
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 00:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.46.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445015; cv=none; b=l6aQVh8qeIToqYd3F67RhcW5/SpENhRkzm11jlPC89w7GzcxJpMyZAqD+qlK/++27rOkjMO9+60jBwXj+4yAtB3I8KjuyHp5z7aQaOcswAJIf+K8+0CywB9eYWgHF2xAnJByIdxFEnIp8Vzkh8B1kCpDmHO51qXudfIHVTT3zDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445015; c=relaxed/simple;
	bh=x22QcpYbI4JUmt/gvu2yv1uYcIKgOl7qAFedx67CXX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bE/m76seHkrZaGvCM0tmDiu9lqFTWyK7IAAFvxtL+Va9lsNZbFfBo61mt63Q4fBmKHa6JrxDMbOQvevW2eO19BkPbzToWXGwL2i/qhvnblxxvofTclcAkXqoRL/y28T+XZWWKHKLpJrEelFYYvVR5ecx97J0DoFNHT8lEkFyyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com; spf=fail smtp.mailfrom=creditkarma.com; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=QQ7HlkZN; dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b=UxuNWKLO; arc=none smtp.client-ip=139.138.46.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=creditkarma.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="QQ7HlkZN";
	dkim=pass (2048-bit key) header.d=creditkarma.com header.i=@creditkarma.com header.b="UxuNWKLO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=creditkarma.com; i=@creditkarma.com; q=dns/txt; s=2;
  t=1780445015; x=1811981015;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=x22QcpYbI4JUmt/gvu2yv1uYcIKgOl7qAFedx67CXX8=;
  b=QQ7HlkZN7ePT+pfwMWqUXYxEri9mq+gq/E/G3Xe3VLeijiubtQAckgIm
   U8YR0lT4vJ2o+l+QxBqMGAmx4ZGXEgrWXglV0rrOZEh6o77EROguQN3tA
   rJD+D3VMme8YpvdQ+T4COy0VO/zBAQN0bhU+72fWolvPdwsVFDXq/e7gn
   6WdZjnNfgAuZgbCbp6+Qu8kAsMHI6Rm+zPn9p9uaQgWSwZl2wiHibuZPj
   lgbIISRgMRVpfemYslPeWMzGx6AwUkj8tIOCL3TNvHJgtiLjoGpPfyirb
   FpXRcH7kGEgQkcW4bZg/Qy02m+d/Spp4xjuIPBX09/zLaCQZ3qmtrNxWC
   Q==;
X-CSE-ConnectionGUID: S2l4GTIvRNasP2aySFZ5zw==
X-CSE-MsgGUID: GDrPwgdLRC6SJuTvTMF9Rw==
X-SBRS: None
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:IMhOCK4bjP7+FM7j0W2vewxRtGXGchMFZxGqfqrLsTDasY5as4F+v
 jBKUGqAO6qDajageopxaIjlo05VvZHQxtdjGgdkqnw2Eysa+MHIO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6iefQH+SU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YDdJ4BYqdDhIg06/gEk35qqq5mtC5gZWic1j5zcyqVFEVfrzGonhdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJEAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi/vy5wSEmSNYUekFPOzOPWXca7lyUqeFO0qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTi43ebq746aVNNKj98bdsD6B60t52N/mGSx4fYOGfgvQo3P7N5cmS8y34VAQq+Ya
 M0eZj5iKh/HZnWjOH9NUMN4zLru3CChNWIBwL6WjfNfD2z7ygtr2rX3LJzWe9GRSMF9lVyVq
 mPa/G3jBxhcP9uaodaA2i7927aUzXyrMG4UPJKU7MZ1j1G3/EdNMz8LaUWHhNfosFHrDrqzL
 GRRoELCt5Ma+023ZsfyUgf+o3OeuBMYHd1KHIUHBBqlz6PV50OBBDFBQGEYLtMhs8AySHoh0
 Vrhc87VOAGDeYa9ERq1nop4ZxvrUcTJBQfuvRM5cDY=
IronPort-HdrOrdr: A9a23:LMmrH64SmbT/kPUDAQPXwE3XdLJyesId70hD6qkRc3Fom6mj/K
 qTdZsgtSMc9wxhIk3I9ergBEDiex/hHPxOkPIs1N6ZNWHbUQCTQ72Kg7GN/9SaIVycygdV79
 YcT4FOTOfoCER8j4LT+RDQKadF/PC3tJqwgPvYzTNHUQFuZshbnn9EIzfeKFRyWA5FQb0wEJ
 b03LskmxOQPU4Pa9i9BD0iQe/OvLTw5ffbSC9DPQcj9A6NyQmJxdfBYn+l9yZbaSpL3bAhtV
 LIiBP0/YKqt/3T8G6760bjq65OncfnyJ99CNeXis4TQw+c8zqVWA==
X-Talos-CUID: =?us-ascii?q?9a23=3A5LKSw2izOnTZIYu36J2PV2NRqTJuSSfZkFjsAlG?=
 =?us-ascii?q?CL29ycOecWGS+yv52jJ87?=
X-Talos-MUID: 9a23:BF6bqwYc7gcgNeBTmBP2vC5tOONSyPqVKl0xj6kjlZi+Knkl
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="49513878"
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by ob1.hc3812-35.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jun 2026 17:03:34 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so3145923a91.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 17:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780445013; x=1781049813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbWfOE5heJDEdim+fSruv0E8I/u+xFdtH3HMgf8srMA=;
        b=LuLGEnwOUrpEnGZ6ocfydBDNNJlMeCIqgToI/g9YQJy3puG5a3aSs16Ni+pnqHcxxK
         XZtXlFOkAsDjOfJl6vMITq2RPm3uW+imbMLxIGAc/FAC1o48io2LKd2TROTX7JBGcsBF
         t1H/cFI/YmOr6RppaZZV3KU8MtiWXT+0x10eunEPG+DXCtKzvF2TJq0zU5JFwk48uFqV
         0Q+dQm0H6uIydIexPdj9SKv+7rwtxjh6ycqyuwaJELMp5YC/1CzBgwQt6NtgqQKj2vqt
         ccHi1ByvmTIKS4eZeqG6xLb88GBikDFsrNrcGKoUa65UzK2JzbEiLLpASO0ZFwdZHDpg
         +/zg==
X-Gm-Message-State: AOJu0YzecTiV1pdj+O/z7wezzs9DNdHbTGnmb1IwiCEgJuiFPM3NPtDF
	1ssp1doSenxSKOaub42KhPXzOtmPUADfzIRgpdd6aNJLf0xfE4Sty93mczZycWS44sgKD/YNm20
	MHuIkaNa2G/e7LJ5mNqWAfo90jRFJOu8YzVqAxH3Kuk6Jq5TBgoC0RLnjfVwMazHLpEYVW3yiyV
	BujnjUVN0BUW+TJ6H+lV/X0alTidtimstCd0cxRMb+zLsLu/0ibarePk75DPAvxUIypEIcfgzIh
	bqa3afIbXGYyl4feefKK/ReaXzrxmUB/0Oh8ApM7A==
X-Gm-Gg: Acq92OFXUYmg+KXDzhNzynOD12dbdueBNiljxzp8T6uB1fCQSm1GiGmsZCGvIVCSwnS
	PjSp2tJpMVo2Lyhi4YdYne1iAsQSlsRUPtEog7EP+1OpMpIZ6NDZCuYh38JwATA63mEW130SZ00
	bd5+mfgqKiPh/jFmg3fysiEqkd7+s8Fs4lsI0gCZXO9+ouXl2TESwLOVUTxVIqiB3VfTyoHbQnU
	dSNeZwMq141RsYObND+Bb0aX7pFrBDBUSECWSgo+unMnnlVXwoVbKoOpbJPxIVs9SJZkSr3Zhxv
	w/PkS4QTriQV2Pmg/1ZtO0IGdC9BZ28YWi+S/U8ETJtkX/9bfrypDPTKS/A0zDvuQWIsZqi1YvY
	upF3eHMmz3NODfEknhqU8BoQZZLkp1GN5ZS5s4KZuCroR6vpyoRikLZN0RKJwj+vboSHCDO1uqq
	oV+vsx82lsY5Xsrw==
X-Received: by 2002:a17:90b:48c5:b0:36d:a510:f908 with SMTP id 98e67ed59e1d1-36e31ea1e1dmr998378a91.5.1780445012840;
        Tue, 02 Jun 2026 17:03:32 -0700 (PDT)
X-Received: by 2002:a17:90b:48c5:b0:36d:a510:f908 with SMTP id 98e67ed59e1d1-36e31ea1e1dmr998319a91.5.1780445012195;
        Tue, 02 Jun 2026 17:03:32 -0700 (PDT)
Received: from was11a1.mail.zscalertwo.net (was11a1.mail.zscalertwo.net. [136.226.152.53])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-36e0a14698asm136914a91.2.2026.06.02.17.03.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:03:32 -0700 (PDT)
X-Relaying-Domain: creditkarma.com
Received: from mail-ot1-f70.google.com ([209.85.210.70])
	by was11a1.mail.zscalertwo.net ([136.226.152.43])
	with ESMTPS id 6A1F6F5308F30000;
	Tue, 02 Jun 2026 20:03:31 -0400
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6243b98a4so15458389a34.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=creditkarma.com; s=google; t=1780445011; x=1781049811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbWfOE5heJDEdim+fSruv0E8I/u+xFdtH3HMgf8srMA=;
        b=UxuNWKLORoVMHwAmr8lG7HCgXpSQeFDqFYODqRQ6bEQEHJPzab9gi5wHKb/d5QfB4K
         cR+a9IyC4cL1yfILE7Q7mtzWm4sJj4rpr1MQ1BNHZnLpmTu+WovkSrot4jln9RVeQipq
         40JWu+Ew5H9HOXbvGMjTlQHhEtp0Cvl3jX9N1sBMi9WKA8gtP6Qgg3mq+/3A1yYiwMZj
         rkIF5iU+zdW8XfBExki53235JoTzo0z7xN4lsszrNpej9EewfNk/tPZ1BpGKeXCDSw4m
         43xyJYCUqE72r+JgLJqY6OAWS2G9qM4DQnNqTK0Np6Jwah+QoUsPL8C6IpkLldmS/bs9
         HTLQ==
X-Received: by 2002:a05:6830:82a9:b0:7de:442b:722 with SMTP id 46e09a7af769-7e6e8fcb0cbmr628595a34.0.1780445010819;
        Tue, 02 Jun 2026 17:03:30 -0700 (PDT)
X-Received: by 2002:a05:6830:82a9:b0:7de:442b:722 with SMTP id
 46e09a7af769-7e6e8fcb0cbmr628571a34.0.1780445010384; Tue, 02 Jun 2026
 17:03:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
 <xmqq1peots9i.fsf@gitster.g>
In-Reply-To: <xmqq1peots9i.fsf@gitster.g>
From: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>
Date: Tue, 2 Jun 2026 17:03:18 -0700
X-Gm-Features: AVHnY4KNm1by3l4zwJYU_4IVxoMD-ny_Fk5QROil0fIVKdyU76_HNiu1nJhtoos
Message-ID: <CAPGaHksjsSefYmGPBxKLw8DDADR5AwTiHTbHq0UyBBtg3CKq9Q@mail.gmail.com>
Subject: Re: [PATCH] worktree: record creation time and free-form note
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Zscaler-Block: 0

Yes, I could change my PR to use $GIT_COMMON_DIR/worktrees/$worktree/descri=
ption
instead of the currently used $GIT_COMMON_DIR/worktrees/$worktree/note.

Give me a day, and I can create the updated diff.

Best,
  Norbert

On Tue, Jun 2, 2026 at 4:52=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Kiesel, Norbert" <norbert.kiesel@creditkarma.com> writes:
>
> > From 130cd5e4a25e6672b2a97268e1100b6ef03fa552 Mon Sep 17 00:00:00 2001
> > From: Norbert Kiesel <norbert.kiesel@creditkarma.com>
> > Date: Mon, 1 Jun 2026 17:03:39 -0700
> > Subject: [PATCH] worktree: record creation time and free-form note
> >
> > Add per-worktree metadata so users can answer "what is this worktree
> > for, and when did I make it?" without resorting to external notes.
>
> Although I am not personally interested in this topic all that much,
> let me point out that we have $GIT_DIR/description file that may be
> useful for something like this.  It has been the canonical place for
> the main repository to identify itself long before secondary worktrees
> were invented and $GIT_COMMON_DIR/worktrees/$worktree/description would
> be a natural extension of the concept, I'd presume.



--=20
Norbert Kiesel | Staff Software Engineer | Credit Karma
norbert.kiesel@creditkarma.com | www.creditkarma.com

This email may contain confidential and privileged information. Any
review, use, distribution, or disclosure by anyone other than the
intended recipient(s) is prohibited. If you are not the intended
recipient, please contact the sender by reply email and delete all
copies of this message.
