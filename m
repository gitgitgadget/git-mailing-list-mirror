From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Mon, 31 Oct 2011 15:17:55 +0100
Message-ID: <4EAEAE13.50101@atlas-elektronik.com>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 15:18:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKsge-0001jW-14
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 15:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594Ab1JaOR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 10:17:59 -0400
Received: from mail96.atlas.de ([194.156.172.86]:25083 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab1JaOR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 10:17:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 77891100BF;
	Mon, 31 Oct 2011 15:17:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id XXGb21Cwh7ai; Mon, 31 Oct 2011 15:17:57 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Mon, 31 Oct 2011 15:17:56 +0100 (CET)
Received: from [141.200.19.108] (as112671.atlas.de [141.200.19.108])
	by mgsrv01.atlas.de (Postfix) with ESMTP id B70F52717B;
	Mon, 31 Oct 2011 15:17:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184507>

Am 31.10.2011 06:00, schrieb Junio C Hamano:
> A release candidate Git 1.7.8.rc0 is available for testing.
> 
> [...]
> 
> 
> Git v1.7.8 Release Notes (draft)
> ================================
> 
> Updates since v1.7.7
> --------------------
> 
> [...]
> 
>  * HTTP transport did not use pushurl correctly, and also did not tell
>    what host it is trying to authenticate with when asking for
>    credentials.
>    (merge deba493 jk/http-auth later to maint).

This seems to break pushing with https for me.
It never uses values from my '~/.netrc'.
I'll come up with a detailed scenario later.

 
Stefan
-- 
----------------------------------------------------------------
/dev/random says: Justice is incidental to law and order.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
