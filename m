From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 08:22:09 -0500
Message-ID: <20070814132209.GJ21692@lavos.net>
References: <11870975181798-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 15:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKwLn-0005KX-Pp
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 15:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755831AbXHNNWU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 09:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468AbXHNNWU
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 09:22:20 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:17172 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbXHNNWT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 09:22:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtZjAN9IwUZKhvbzRmdsb2JhbACBVIUlhxUBAQE1AQ
X-IronPort-AV: E=Sophos;i="4.19,259,1183348800"; 
   d="scan'208";a="64657554"
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 14 Aug 2007 09:22:18 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id A7E7D309F31; Tue, 14 Aug 2007 08:22:09 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <11870975181798-git-send-email-bdowning@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55830>

On Tue, Aug 14, 2007 at 08:18:38AM -0500, Brian Downing wrote:
> We can now read .gitattributes files out of the index, but the index
> must be loaded for this to work.

This was supposed to be In-Reply-To Junio's patch, "attr.c: read
.gitattributes from index as well."  It's not much use without it.

-bcd
