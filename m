Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB17A20195
	for <e@80x24.org>; Fri, 15 Jul 2016 15:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbcGOPag (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 11:30:36 -0400
Received: from lixid.tarent.de ([193.107.123.118]:51200 "EHLO mail.lixid.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcGOPaf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2016 11:30:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.lixid.net (MTA) with ESMTP id AD3D5140224;
	Fri, 15 Jul 2016 17:30:31 +0200 (CEST)
Received: from mail.lixid.net ([127.0.0.1])
	by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
	id vb-OggEskXC0; Fri, 15 Jul 2016 17:30:31 +0200 (CEST)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.lixid.net (MTA) with ESMTPS id 52F7A14016D;
	Fri, 15 Jul 2016 17:30:31 +0200 (CEST)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
	id 08DA3220968; Fri, 15 Jul 2016 17:30:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tglase.lan.tarent.de (Postfix) with ESMTP id D9463220900;
	Fri, 15 Jul 2016 17:30:30 +0200 (CEST)
Date:	Fri, 15 Jul 2016 17:30:30 +0200 (CEST)
From:	Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To:	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Server-side preventing some files from being overwritten
In-Reply-To: <CACBZZX7YFQ3o+5wbVz0ca6__3ViD0b-qbrX06CkxhAHE8uQ6oQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607151729560.18668@tglase.lan.tarent.de>
References: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de> <CAGZ79kb=2rpYucjhavNB_XHLk9rjKSoHzL9bwM5buDO0GyW3vw@mail.gmail.com> <alpine.DEB.2.20.1607141948530.25238@tglase.lan.tarent.de> <xmqqpoqgqdlz.fsf@gitster.mtv.corp.google.com>
 <CAPc5daXxAqXtUvs1Xr_vgncXqcvR8-VG67oDAgOQ8xPcT7nCeQ@mail.gmail.com> <CACBZZX7YFQ3o+5wbVz0ca6__3ViD0b-qbrX06CkxhAHE8uQ6oQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, 15 Jul 2016, Ævar Arnfjörð Bjarmason wrote:

> I.e. it allows pushing a series which is a series of two commits which:
> 
>   1. Change the forbidden file(s)
>   2. Undo changes to the forbidden file(s)

That’s precisely allowed.

bye,
//mirabilos
-- 
tarent solutions GmbH
Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
Tel: +49 228 54881-393 • Fax: +49 228 54881-235
HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
