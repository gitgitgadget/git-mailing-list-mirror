From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: weird diff output?
Date: Wed, 30 Mar 2016 12:31:30 -0700
Message-ID: <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
 <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
 <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com> <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
 <20160330045554.GA11007@sigill.intra.peff.net> <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
 <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:31:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alLqO-00046f-8V
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 21:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753204AbcC3Tbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 15:31:52 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37293 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbcC3Tbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 15:31:51 -0400
Received: by mail-ig0-f173.google.com with SMTP id l20so51117155igf.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E4WCmFLvmr8JWq5Q9xFO8S5jVevNpOYuq4YScKhuYWU=;
        b=ClBp8Sau4F3J9kjLxF1LvXOP/kVvt2p8nW2UexdMKwQsohdDQvM0WjE5CVbU+aFcrB
         mjQ0SG3Gvd/mGlaxNPw320cXSM7sxTbRgWdHirf/PeiOmVEKDvLcExvpNnnRPEY1acam
         42MklhcNV8MiUMyuRQ4UGmJ20dJcb3wp+WApV9pRm27M4PQAZBxFBB22wGPQ/rKzCdXE
         EiqtH0DuaD7PVkhYGXAyIpnufTctQUmUpxMi9LgGwGmi26ql3nGL3FKou7fj0PERMJ71
         RCuDmob9GmZq6mBnpQHDjlTzG/gRZ7JeYfDzZjdX68/Fu25XAd6cKrYWNT+5rXzUq5Ae
         Sm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E4WCmFLvmr8JWq5Q9xFO8S5jVevNpOYuq4YScKhuYWU=;
        b=ZQckFai10+kLcajowxnL7yIE7a7rv5Dnp6YdmiyQeib0SeJzhguTqe2UOCESz33+yA
         01Zvjq0jhvQ4s6CWunGtCqAxS6ZKRlPL0N/WEOa7G6OuPZTsToqmf2L/9L/qBZta1X02
         5RrBkzS9MsGSMlnRvjotltpucw9WacLEban7hmBaBUQRr3IEVpWNCS1RGpbRzXU/Bkhx
         fwL0ShynVNfvhtt68sNpm1CRHZYufY4mO015WVDHzZP/SrW85fpeqWKrZn+iKw6ZC7Gf
         gk2FEvHEinRh+/R4Tp19KJbZ0/mwScoNFaTFFwQQ+Gq0yxo4IxtvNUn5VFyqNmtKGwpU
         5xMA==
X-Gm-Message-State: AD7BkJKJB5w82oqyimT5xmUIr7HXVdjmfPYHTYL7Ym5KRT2ISHArfaCP1MLGUfcBcamWvxSXHqAxY1kcwiiNSw==
X-Received: by 10.50.112.169 with SMTP id ir9mr25240098igb.92.1459366310504;
 Wed, 30 Mar 2016 12:31:50 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Wed, 30 Mar 2016 12:31:30 -0700 (PDT)
In-Reply-To: <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290341>

On Wed, Mar 30, 2016 at 12:14 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> I ran this on a few of my local projects and it doesn't seem to
> produce any false positives so far. Everything looks good. Of course
> this is with just traditional C code. I am currently trying to run
> this against the history of Linux as well and see if I can find
> anything that seems bad there.
>
> Thanks,
> Jake

So far I've only found a single location that ends up looking worse
within the Linux kernel. Diffs of some Kbuild settings result in
something like

before:

          If unsure, say Y.
+
+config RMI4_I2C
+       tristate "RMI4 I2C Support"
+       depends on RMI4_CORE && I2C
+       help
+         Say Y here if you want to support RMI4 devices connected to an I2C
+         bus.
+
+         If unsure, say Y.

after:

          required for all RMI4 device support.

+         If unsure, say Y.
+
+config RMI4_I2C
+       tristate "RMI4 I2C Support"
+       depends on RMI4_CORE && I2C
+       help
+         Say Y here if you want to support RMI4 devices connected to an I2C
+         bus.
+
          If unsure, say Y.

So in this particular instance which has multiple blank lines and is a
similar issue as with Stefan's note above, this is where the heuristic
falls apart. At least for C code this is basically vanishingly small
compared to the number of comment header fix ups.

I think it may be that Stefan's suggestions above may be on the right
track to resolve that too.

Regards,
Jake
