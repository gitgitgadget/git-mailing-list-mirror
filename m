From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] compat: Add simplified merge sort implementation from glibc
Date: Tue, 5 Feb 2008 08:11:39 -0600
Message-ID: <20080205141139.GN26392@lavos.net>
References: <20080204024644.GM26392@lavos.net> <1202209509-13760-1-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Edgar Toernig <froese@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 15:12:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOX2-0006tb-Ai
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbYBEOLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYBEOLm
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:11:42 -0500
Received: from mxsf04.insightbb.com ([74.128.0.74]:5033 "EHLO
	mxsf04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbYBEOLl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:11:41 -0500
X-IronPort-AV: E=Sophos;i="4.25,308,1199682000"; 
   d="scan'208";a="215332726"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf04.insightbb.com with ESMTP; 05 Feb 2008 09:11:40 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAEj9p0dKhvkY/2dsb2JhbACBWKt9
X-IronPort-AV: E=Sophos;i="4.25,308,1199682000"; 
   d="scan'208";a="198943913"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 05 Feb 2008 09:11:40 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id D7B4A309F21; Tue,  5 Feb 2008 08:11:39 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <1202209509-13760-1-git-send-email-bdowning@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72658>

I didn't notice that the previous patch made it into pu.  The only other
changes to this patch was changing the makefile variable name from
"NEED_QUICK_QSORT" to "INTERNAL_QSORT", and some changes to the commit
message.

I am fine with either version going in.

-bcd
