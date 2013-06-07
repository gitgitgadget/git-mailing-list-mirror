From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 19:54:28 +0530
Message-ID: <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz> <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
 <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Jun 07 16:25:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkxbQ-0007T4-DB
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 16:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab3FGOZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 10:25:09 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:39405 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab3FGOZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 10:25:08 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so5823454iea.11
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=a9v81To2iyGlU043L5hstWAVC2iMFqNX50mh12K3ssQ=;
        b=e2ejlfqjr30IlIrRVbapVWkpeRi4+uunPPjWLMhuaaNNoyfzQI5lKzd0xbYDcLHdik
         5iF1c1V1SY2UpB/xJ0Yl8PoJSfqRGAcrZyxumhAxDJBOsio9D0WZA4nVtTU8p0vvW3ly
         XaHxUnlbaKzDghUVDqe+fwbH+mVGdsKQGgTuFgZgpHdDcsANfW6tkaY/TKLOcl8j8AdT
         T+OkCyqJ2IvTCN0+09avOjLA6Xz+eMpDWxfNiSygGh9DN6QIF48fKyN7zGDXIuwFTLfo
         kWX2PrsDKs/X8qcdXG/hf3kHRp43yNbPAapQ3/9Lw6L+Z0zjXXDM5MwwAQ68ge81IvTE
         5N9A==
X-Received: by 10.50.70.101 with SMTP id l5mr1269925igu.104.1370615108184;
 Fri, 07 Jun 2013 07:25:08 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 07:24:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226632>

David Lang wrote:
> Well, Felipe is saying that Perl is dieing and we should re-write everything
> that exists in Perl to Ruby.

I don't agree with that opinion.  More generally, I think the entire
discussion on what _should_ or _should not_ be done is rubbish.  What
_will_ and _will not_ happen depends on the patches contributors send.
 If a contributor sends a patch rewriting git-svn in ruby, then we
have a discussion: is anyone bored enough to pick up the task in the
first place?

> TIOBE index graph is "press coverage" as far as I'm concerned.

Well, that's your definition of "press coverage" then.  TIOBE index is
generated from scraping the web to figure out which languages are
"living", based on discussions between programmers (and yes, "press"
articles).  I do not have conclusive or "undeniable" proof that perl
is dying, but the trends are indicative of a decline.

I think Felipe is using the argument that perl is declining to answer
the question "why didn't you write git-related in perl instead?";
that's it.
