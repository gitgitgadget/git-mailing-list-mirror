From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Tue, 14 Jul 2009 15:12:49 +0100
Message-ID: <b0943d9e0907140712i39818abfldd01b8f8bb0fe301@mail.gmail.com>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
	 <20090713082859.GA10549@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	John Kacur <jkacur@gmail.com>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQil9-0004kA-BA
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 16:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbZGNOMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 10:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZGNOMw
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 10:12:52 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:54920 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbZGNOMv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 10:12:51 -0400
Received: by bwz28 with SMTP id 28so801982bwz.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A+k1mwo4FueMC9NL4B92g4x69fatFaiM3Osx0O3Opek=;
        b=rzj1z/zwDjfm3T19BH/hZzPW5IfTJTNyePyDzsPqrr3NbNLZXDL9g7Q8vpmwybBeqh
         LUXbVI8j8CFjocQnWP+d6gPbpzzutd/z8e7GxEkMygfNMJ6Kc+/21Ne3Za+udf+KnNHW
         f4xbgrEUAqQd6U7UV2o9lELzqPhyBZ7q60sd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C9VSIoM+J4GZf8WLWEmqvSrVXgOZy87iOjU4uh9DXd4Uf9SR/Bp8hNKNctEchJq1Mz
         5Am+WQq4qh7lfiZZ8f1RDZeNHyI06aSlpnFYt6gp1UN1MPO2l3NXKnkWRFO5TK4huxCK
         JLTI0e/Qb56rW1hlkMKLCr2yUfO3zCWll8lCw=
Received: by 10.223.115.193 with SMTP id j1mr2943855faq.85.1247580769128; Tue, 
	14 Jul 2009 07:12:49 -0700 (PDT)
In-Reply-To: <20090713082859.GA10549@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123247>

2009/7/13 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> =A0 =A0 =A0 =A0stg goto include-linux-delay-h-in-hwlat_detector.patch
> =A0 =A0 =A0 =A0git show --stat
>
> yields:
>
> =A0 =A0 =A0 =A0commit 12c06d44017a9c51746290779fc24fb8d69c68ef
> =A0 =A0 =A0 =A0Author: Uwe Kleine-K=F6nig <=3D?utf-8?q?Uwe=3D20Kleine=
-K=3DC3=3DB6nig?=3D>
> =A0 =A0 =A0 =A0Date: =A0 Mon Jul 13 10:01:19 2009 +0200
>
> =A0 =A0 =A0 =A0 =A0 =A0Subject: include linux/delay.h in hwlat_detect=
or
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<u.kleine-koenig@pengutronix.de>
> =A0 =A0 =A0 =A0 =A0 =A0Date: Sun, 14 Jun 2009 23:31:42 +0200
>
> =A0 =A0 =A0 =A0 =A0 =A0This broke when compiling on i386 without X86_=
LOCAL_APIC because then
> =A0 =A0 =A0 =A0 =A0 =A0arch/x86/include/asm/smp.h doesn't include asm=
/apic.h which in turn includes
> =A0 =A0 =A0 =A0 =A0 =A0linux/delay.h.
>
> =A0 =A0 =A0 =A0 =A0 =A0Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-ko=
enig@pengutronix.de>
> =A0 =A0 =A0 =A0 =A0 =A0Cc: Jon Masters <jcm@redhat.com>
> =A0 =A0 =A0 =A0 =A0 =A0LKML-Reference: <1245015102-22057-1-git-send-e=
mail-u.kleine-koenig@pengutron
> =A0 =A0 =A0 =A0 =A0 =A0Signed-off-by: Thomas Gleixner <tglx@linutroni=
x.de>
> =A0 =A0 =A0 =A0 =A0 =A0Cc: Thomas Gleixner <tglx@linutronix.de>
> =A0 =A0 =A0 =A0 =A0 =A0Cc: Jon Masters <jcm@redhat.com>
>
> =A0 =A0 =A0 =A0 drivers/misc/hwlat_detector.c | =A0 =A01 +
> =A0 =A0 =A0 =A0 1 files changed, 1 insertions(+), 0 deletions(-)
>
> There are some things to enhance:
>
> =A0- s/Subject: //
> =A0- use Date line as author date
> =A0- stray email address
> =A0- author ident is wrong/broken

Can you try stg import -m? If all the patches have Subject: (From:
etc.), git show displays:

commit 7718bb00156313687ae42c3ae9d157c558bacb15
Author: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Date:   Sun Jun 14 23:31:42 2009 +0200

    include linux/delay.h in hwlat_detector

    This broke when compiling on i386 without X86_LOCAL_APIC because th=
en
    arch/x86/include/asm/smp.h doesn't include asm/apic.h which in turn=
 includes
    linux/delay.h.

    Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
    Cc: Jon Masters <jcm@redhat.com>
    LKML-Reference: <1245015102-22057-1-git-send-email-u.kleine-koenig@=
pengutron
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Jon Masters <jcm@redhat.com>


If there are mixed patches, we may need some kind of autodetection but
it seems that most rt patches follow this rule. If there is no
description (kbuild.patch), stgit seems to insert None.

--=20
Catalin
