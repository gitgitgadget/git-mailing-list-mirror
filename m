From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] merge: Make merge strategy message follow the diffstat
Date: Tue, 17 Jan 2012 17:03:03 +0900
Message-ID: <buomx9mhi2w.fsf@dhlpc061.dev.necel.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com>
 <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com>
 <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <20120111184026.GA23952@windriver.com>
 <7vaa5rzaax.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8BmFgssTAh=1U7JgBsGG-tSaWXQzZeODND3icXY3QUxug@mail.gmail.com>
 <CA+55aFxw_-0h1FDmPRVif3LM03Qh3-6haA7=KYbae8pSFbpW2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Jan 17 09:03:47 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Rn419-0007aV-EG
	for glk-linux-kernel-3@lo.gmane.org; Tue, 17 Jan 2012 09:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab2AQIDK (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 17 Jan 2012 03:03:10 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:62371 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab2AQIDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2012 03:03:08 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LXX006Q0NP6G0D0@relmlor2.idc.renesas.com>; Tue,
 17 Jan 2012 17:03:06 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LXX001NYNP2MRG0@relmlir1.idc.renesas.com>; Tue,
 17 Jan 2012 17:03:06 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id 95CD580030; Tue, 17 Jan 2012 17:03:06 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id 8AE5E80195; Tue,
 17 Jan 2012 17:03:06 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac1.idc.renesas.com with ESMTP id TAE17467; Tue,
 17 Jan 2012 17:03:06 +0900
X-IronPort-AV: E=Sophos;i="4.71,522,1320591600";   d="scan'208";a="63617572"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii1.idc.renesas.com with ESMTP; Tue, 17 Jan 2012 17:03:06 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.217])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id q0H8347L029854;
 Tue, 17 Jan 2012 17:03:04 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 1381452E738; Tue,
 17 Jan 2012 17:03:04 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <CA+55aFxw_-0h1FDmPRVif3LM03Qh3-6haA7=KYbae8pSFbpW2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188698>

So ... "--shortish-diffthingy"

-miles

-- 
Zeal, n. A certain nervous disorder afflicting the young and inexperienced.
