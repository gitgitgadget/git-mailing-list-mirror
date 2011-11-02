From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [PATCH] branch -m: handle no arg properly
Date: Wed, 02 Nov 2011 16:09:20 +0100
Message-ID: <4EB15D20.1060107@atlas-elektronik.com>
References: <4EB153B4.6070404@atlas-elektronik.com> <1320246098-6912-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C. Hamano" <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 16:09:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLcRP-0005hz-Lo
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 16:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540Ab1KBPJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 11:09:19 -0400
Received: from mail96.atlas.de ([194.156.172.86]:11315 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280Ab1KBPJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 11:09:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 25D4E100DF;
	Wed,  2 Nov 2011 16:09:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id I5O71EPxFldB; Wed,  2 Nov 2011 16:09:16 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Wed,  2 Nov 2011 16:09:16 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 97DBF2718B;
	Wed,  2 Nov 2011 16:09:16 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1320246098-6912-1-git-send-email-rctay89@gmail.com>
X-Enigmail-Version: 1.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184636>

Am 02.11.2011 16:01, schrieb Tay Ray Chuan:
> Modify the option parsing heuristic to handle all -m (rename) cases,
> including the no-arg case. Previously, this "fell through" to the argc
> <= 2 case.
> 
> Add a regression test in t3200-branch.sh while we're at it.

Great. I just sent a patch for t3200 as well...

Stefan
-- 
----------------------------------------------------------------
/dev/random says: If At First You Don't Succeed Ignore The Docs...
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
