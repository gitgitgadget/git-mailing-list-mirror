From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Tue, 29 Dec 2009 20:05:13 +0900
Message-ID: <20091229200513.6117@nanako3.lavabit.com>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 12:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPZtJ-0001O2-Sa
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 12:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbZL2LFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 06:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZL2LFR
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 06:05:17 -0500
Received: from karen.lavabit.com ([72.249.41.33]:38996 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbZL2LFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 06:05:16 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 3E48F11B8BA;
	Tue, 29 Dec 2009 05:05:16 -0600 (CST)
Received: from 4391.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 0VT56T9DX3EJ; Tue, 29 Dec 2009 05:05:16 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=sIr233a8ydJ+3ci873bbTqlhC2Rvt3UQzI7Su0OTwwK+Gw4KcNqFv7oUvqXJP9dmz8rGhDaqpE3K674fER8Ejr7ifkcaNt6Nnxsyr2R0Yieop9GmYsuL13J2tNG4HO5a0/00NCMpAJONDvM9UMakXcMGj2h50pr5A0awau1me8o=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135787>

Junio, could you tell us what happened to this thread?

The patch rejects "git pull repo A:B" because it is almost always a mistake;
I think it makes sense.
