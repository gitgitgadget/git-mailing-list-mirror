From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 20:58:01 +0530
Message-ID: <CALkWK0=rZoCuw+_ovTu7iC49fDkyXCT9To=W8vTTkd4=+O+w_g@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz> <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
 <alpine.DEB.2.02.1306061308100.29361@nftneq.ynat.uz> <CALkWK0k8m16oy7u+a8bHK93pRxfomOZDne3k0voVHLGULO+uiw@mail.gmail.com>
 <7vd2ryueuu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Lang <david@lang.hm>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>, git@vger.kernel.org,
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
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:28:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukyas-0007RX-9F
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756069Ab3FGP2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 11:28:42 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:52988 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584Ab3FGP2l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 11:28:41 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so10922675ied.14
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r3Uey4dNvxwvmA6I/zTlrMrTXccf4y9R3AXAKN5yeK4=;
        b=claoNHi7VuttSYxiFb0fP78ul/AuC2+Lrh3WD3k35Rg7d3/RW7SdJgkDgdvK567U7x
         YyKPEKGtBpVzBmXb3bP7fdO35Bn3lwHDemZD3hESCkA4KAq19As8FNDZfivfC9HflzlL
         Orp2ObedrhGT5NZHS0grCrx8WH2lVfl3mJKlq2DJyytUzwPynJhu24XKtAkTSWEbFM/V
         7MOpoaB/qTUow6jGlNpcwyFLgQ/bAMQKs27HjSonZzrvuL7RWxyhc7DTOQBBhXA6xQCh
         6iMDW5T1J/B+zx0mUc3KkuOcMoDqkXypx7Pc4qZHnQdj3PTihsectte/NMC72Uia7A/J
         HhbQ==
X-Received: by 10.50.32.8 with SMTP id e8mr1649173igi.89.1370618921294; Fri,
 07 Jun 2013 08:28:41 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 08:28:01 -0700 (PDT)
In-Reply-To: <7vd2ryueuu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226639>

Junio C Hamano wrote:
> So at least for now, the conclusion is to take approach #1, i.e.
> somebody who finds "related" a good addition rewrites it in Perl to
> promote it out of contrib/ once the design issues settle (of course
> it is still a possibility that no such volunteer appears).

We'll think about it if and when we get major ruby patches, and see
perl patches declining.  One git-related.rb doesn't say anything.
