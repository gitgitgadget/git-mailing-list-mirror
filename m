From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regulator updates for 3.3
Date: Tue, 10 Jan 2012 19:21:19 -0800
Message-ID: <CA+55aFwuyjDsRogEugTRnzSGHpO231MkZ9YYNpTTxNSgsfBVrg@mail.gmail.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org> <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
 <7vehv77xeq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Jan 11 04:22:27 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rkole-0007W0-LL
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Jan 2012 04:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431Ab2AKDVm (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Jan 2012 22:21:42 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34753 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2AKDVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2012 22:21:41 -0500
Received: by yenm10 with SMTP id m10so131944yen.19
        for <multiple recipients>; Tue, 10 Jan 2012 19:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=NLI3PKFBMMMmw25XxTrtISr2SYsHb4jc/BRMeSMGeis=;
        b=Q55zWT51zfhBBCTkS7eISzLmN35LxltfiI4cKEQTeORdQC8j2+ZupPLy09JCd7FJv4
         XzAZDMieE4bF+YSxduatKUrqsntcjPKXMK0k0HsTfLHvaBerQUGgoAHw1jMy77VVHNea
         4/vWFvTZgtewjLeJ0EenfH/NICTUAU0PH3+/4=
Received: by 10.236.195.37 with SMTP id o25mr29842328yhn.46.1326252100176;
 Tue, 10 Jan 2012 19:21:40 -0800 (PST)
Received: by 10.236.175.170 with HTTP; Tue, 10 Jan 2012 19:21:19 -0800 (PST)
In-Reply-To: <7vehv77xeq.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: fv2293NqqgYFjTr-PROYSfIG5F4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188319>

On Tue, Jan 10, 2012 at 7:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I dunno. You just scrapped the plan for 1.7.10; it may have to be called 2.0
> instead.

Btw, version numbers are cheap. I already argued for updating to 2.0
just because of the new signed tag pulling, which I think is a much
bigger issue.

I don't think a small change like "start the editor by default for
merge messages" is nearly as worthy of a version number. But I
wouldn't argue against it either, exactly because those major numbers
are cheap.

It took the kernel until 2.6.39 to learn that, I think git could learn
to use its major number more freely much earlier.

                   Linus
