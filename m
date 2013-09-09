From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Git: Having trouble merging two repositories by interweaving their histories
Date: Tue, 10 Sep 2013 01:06:49 +0200
Message-ID: <87fvtdbnna.fsf@igel.home>
References: <522E3D12.4090004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: THILLOSEN Andreas <thillosen@free.fr>
X-From: git-owner@vger.kernel.org Tue Sep 10 01:07:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJAXq-00064F-MP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 01:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab3IIXGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 19:06:54 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37253 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755807Ab3IIXGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 19:06:54 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cYlPQ5gVpz4KK2Q;
	Tue, 10 Sep 2013 01:06:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cYlPQ5Z5YzbbgZ;
	Tue, 10 Sep 2013 01:06:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id dD1cvJV8yDpq; Tue, 10 Sep 2013 01:06:49 +0200 (CEST)
X-Auth-Info: aqevFJ5JNDvAh+OWYH1ap0CKNTRNyziat14d/8dVJX8=
Received: from igel.home (ppp-88-217-125-251.dynamic.mnet-online.de [88.217.125.251])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 10 Sep 2013 01:06:49 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 89E362C1732; Tue, 10 Sep 2013 01:06:49 +0200 (CEST)
X-Yow: YOW!!
In-Reply-To: <522E3D12.4090004@free.fr> (THILLOSEN Andreas's message of "Mon,
	09 Sep 2013 23:26:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234399>

THILLOSEN Andreas <thillosen@free.fr> writes:

> It implies "interweaving" their histories, so that I can get a "state"
> of both RepA and RepB around a same time period of time.

This is only possible by rewriting every commit to point to a new tree
containing the combined trees of the two repositories.  To get a
meaningful result this requires that both repositories have a completely
linear history.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
