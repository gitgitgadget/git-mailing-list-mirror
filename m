From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] Use __VA_ARGS__ for all of error's arguments
Date: Thu, 7 Feb 2013 20:39:16 -0800
Message-ID: <20130208043915.GB4525@ftbfs.org>
References: <20130207212438.GA22253@ftbfs.org>
 <1360272632-22566-1-git-send-email-kraai@ftbfs.org>
 <20130208042428.GA4157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 05:40:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3fkr-0000bU-P2
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 05:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759873Ab3BHEjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 23:39:43 -0500
Received: from zoom.lafn.org ([108.92.93.123]:39932 "EHLO zoom.lafn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759724Ab3BHEjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 23:39:42 -0500
Received: from hpe-490t.ftbfs.org (pool-108-23-63-172.lsanca.fios.verizon.net [108.23.63.172])
	(authenticated bits=0)
	by zoom.lafn.org (8.14.3/8.14.2) with ESMTP id r184dSPO080275;
	Thu, 7 Feb 2013 20:39:28 -0800 (PST)
	(envelope-from kraai@ftbfs.org)
Received: from kraai by hpe-490t.ftbfs.org with local (Exim 4.80)
	(envelope-from <kraai@ftbfs.org>)
	id 1U3fk4-0006uR-1l; Thu, 07 Feb 2013 20:39:16 -0800
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Max Horn <max@quendi.de>, Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <matt.kraai@amo.abbott.com>
Content-Disposition: inline
In-Reply-To: <20130208042428.GA4157@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97 at zoom.lafn.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215750>

On Thu, Feb 07, 2013 at 11:24:28PM -0500, Jeff King wrote:
> Should you be dropping most of the comment like this? I would expect it
> to be more like:
> 
>   We have to restrict this trick to gcc, though, because we do not
>   assume all compilers support variadic macros. But since...

I'll submit a new patch with this change tomorrow.

> Other than that, I think it is OK. The compiler will still catch
> "error()" with no arguments and generate the appropriate diagnostic (in
> fact, it is better, because the error is now passing too few args to a
> function, not to the macro).

Great, thanks for the review.

-- 
Matt
