From: milki <milki@rescomp.berkeley.edu>
Subject: Re: git-config: case insensitivity for subsections
Date: Thu, 25 Aug 2011 14:57:57 -0700
Message-ID: <20110825215757.GA94231@hal.rescomp.berkeley.edu>
References: <20110818063528.GH13342@hal.rescomp.berkeley.edu>
 <20110825205849.GA10384@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:58:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwhw4-0003mM-0L
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab1HYV56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:57:58 -0400
Received: from hal.Rescomp.Berkeley.EDU ([169.229.70.150]:54277 "EHLO
	hal.rescomp.berkeley.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab1HYV56 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:57:58 -0400
Received: by hal.rescomp.berkeley.edu (Postfix, from userid 1070)
	id B4B08119E67; Thu, 25 Aug 2011 14:57:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110825205849.GA10384@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180126>

On 16:58 Thu 25 Aug     , Jeff King wrote:
> Is there a reason that you can't use the canonical version in your "git
> config" invocation? Or was it simply confusing that it didn't work? I'd
> much prefer to document this limitation in git-config(1) than change the
> code.

This was simply surprising as I was trying to figure out what exactly
case sensitivity meant and how it affacted sections. This definitely
clears this up for me. I'm actually working on a config parser because I
don't think I've seen a complete implementation besides git-config in a
different language.
