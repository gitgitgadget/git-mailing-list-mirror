From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 2/5] check-ignore: allow incremental streaming of queries
 via --stdin
Date: Thu, 11 Apr 2013 12:20:00 +0100
Message-ID: <20130411112000.GC24296@pacific.linksys.moosehall>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
 <1365645575-11428-2-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 13:20:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQFY2-0007iX-Dn
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 13:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab3DKLUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 07:20:03 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58984 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab3DKLUC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 07:20:02 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id A4A4058EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 12:20:01 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1365645575-11428-2-git-send-email-git@adamspiers.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220846>

On Thu, Apr 11, 2013 at 02:59:32AM +0100, Adam Spiers wrote:
> +test_expect_success STDBUF 'streaming support for --stdin' '
> +	(
> +		echo one
> +		sleep 2
> +		echo two
> +	) | stdbuf -oL git check-ignore -v -n --stdin >out &

I just noticed that this patch precedes the one in the same series
which adds -n support.  I'll reorder them accordingly to avoid
breaking git bisect.
