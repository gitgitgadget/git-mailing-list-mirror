From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH 4/6] Add pack-objects window memory usage limit
Date: Thu, 12 Jul 2007 08:04:00 -0500
Message-ID: <20070712130400.GU4087@lavos.net>
References: <1184244952554-git-send-email-bdowning@lavos.net> <11842449521798-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 15:04:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yLA-0007Eo-9O
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760554AbXGLNEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760041AbXGLNEL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:04:11 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:1752 "EHLO
	asav04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759509AbXGLNEK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:04:10 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav04.insightbb.com with ESMTP; 12 Jul 2007 09:04:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AutRAGDDlUZKhvbzRmdsb2JhbACBS4VfiAgBAQE+
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 61351309F31; Thu, 12 Jul 2007 08:04:00 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <11842449521798-git-send-email-bdowning@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52280>

On Thu, Jul 12, 2007 at 07:55:50AM -0500, Brian Downing wrote:
> +		if (!prefixcmp(arg, "--window-memory=")) {
> +			if (!git_parse_ulong(arg+15, &window_memory_limit))
> +				usage(pack_usage);
> +			continue;
> +		}

This is incorrect.  I had this fixed to +16, but somewhere in my remaking
the series it got lost.  I will resend the correct patch.

-bcd
