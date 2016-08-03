Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F01720462
	for <e@80x24.org>; Wed,  3 Aug 2016 15:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757805AbcHCPKz (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 11:10:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:49608 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850AbcHCPKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 11:10:11 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MFgxF-1bRzg53WBZ-00EeDe; Wed, 03 Aug 2016 17:10:00
 +0200
Date:	Wed, 3 Aug 2016 17:09:53 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	gitster@pobox.com
cc:	Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 0/8] status: V2 porcelain status
In-Reply-To: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
Message-ID: <alpine.DEB.2.20.1608031708560.107993@virtualbox>
References: <1470147137-17498-1-git-send-email-git@jeffhostetler.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V+lB1P6YKLywtM6+aRpJNzChe/obMJ/YVyk1UH7Ry+pRLXTIK+M
 2tJHz+Ikj4chtTsMwuE73YRS9ZLc+uSI4Dg6zWpY8M5zfK3Jps/AGqDVrKhA92+VcVpaTNb
 /Vi+3P8pdFzIDX/Dchfs2joso+hujZEOc/BoLtiYyAzeMAHmGLs8tFePDRhgooDEU+GZhcz
 iedVMxD/evJN4S+q9RCyA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:vHQ5JxQ5jKI=:toiNQwRKi+w3lTWZU+SuO+
 aENjAu/aAOymZYiygSXUQQfRTV5cxXRpnV2Gj0ilI6ld4YSmhxwBjZBENC/KDud5R80hbQTLu
 uMPM/9EJSpDjjdPu0IZ5AIRHpdTRIjxkf8yFpwkVpGZ/suzaHbCOzqRur+GwmpaIEXplXYZ0J
 o2w3ZWecRqIeZGpQXxu6xLq6NvS9yXGIQ7z3R9kHK9jmT3MnLsK2eDEH0lhc/FrADO8C4TyPV
 tobrbbS19GcwYrYwzw1kYwug/bjKOERd4U0A8eqqjqvc2JqTHzkxZkV/O99BMj8Tk4G9qa6UZ
 WgoJLZcKRueD6xI1fggMc1+xJCa8KW+4JnPxu/vLOBoXwQsYoOwV1KwJE6ZRZdxLcgvZ0+UjM
 mAg0wU4+LyhfgpfiS554AncDvtdw61IpHbF8F1Waj2Ed++ouZMowOpcs0SNlefGoF6Oj3Hfwn
 pH2fm+F7X2A13N6TQDX5NTsqOCIhwrUkv/f4dnG2h9NhC7QPgpvBVE31p28hpgt2i38jq8lpR
 xPm+MJeV5JxCbgO/5LTY6/mXYPmM35R6TlQs4b15TNJwoke2vpVTyhk2Iu5ModXk3awwfCw/l
 ZkvOhBeCC98Kyv8DvPRv0WCoVRiQM/y+BiZpq+3B6MnTU3dNFei5OXiWJWBxk7YadZsimnuSR
 sS1AvCizaknBPiJGXcclmu2pTJWevCo9n+0iAeF/4tvJdwKuWB/sLNsUZH7QNnTzPjrMDBJWV
 BWD3pVaxGe9TGiCXwUIYaA10K5RwagiviDI4XnCyoxqMT+7o29njjzUfrMbssGA98RooKv7Tx
 MQRuROj
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 2 Aug 2016, Jeff Hostetler wrote:

> This patch series adds porcelain V2 format to status.
> This provides detailed information about file changes
> and about the current branch.
> 
> The new output is accessed via:
>     git status --porcelain=v2 [--branch]

I was wondering... this patch series is at v4 already, and I really need
it pretty urgently in Git for Windows.

Any word when it will be included in `pu`, at least?

Ciao,
Dscho
