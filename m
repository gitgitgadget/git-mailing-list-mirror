From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] parse_dirstat_params(): use string_list to split
 comma-separated string
Date: Wed, 31 Oct 2012 08:48:07 -0700
Message-ID: <20121031154807.GA19483@ftbfs.org>
References: <1351443054-10472-1-git-send-email-mhagger@alum.mit.edu>
 <loom.20121030T193428-242@post.gmane.org>
 <20121031140636.GA24291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 17:33:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTbEc-0000d6-B0
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 17:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab2JaQda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 12:33:30 -0400
Received: from kvm.ftbfs.org ([46.22.115.26]:36571 "EHLO kvm.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983Ab2JaQd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 12:33:29 -0400
X-Greylist: delayed 2719 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Oct 2012 12:33:29 EDT
Received: from kraai by kvm.ftbfs.org with local (Exim 4.72)
	(envelope-from <kraai@ftbfs.org>)
	id 1TTaWV-00054W-V5; Wed, 31 Oct 2012 08:48:07 -0700
Content-Disposition: inline
In-Reply-To: <20121031140636.GA24291@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208840>

On Wed, Oct 31, 2012 at 10:06:36AM -0400, Jeff King wrote:
> On Tue, Oct 30, 2012 at 06:43:51PM +0000, Matt Kraai wrote:
> 
> > Michael Haggerty <mhagger <at> alum.mit.edu> writes:
> > > +	if (*params_copy)
> > 
> > params_copy is set to the value returned by xstrdup, which cannot be NULL.
> > This check can be removed and if params_string can be NULL, it should be
> > checked before being passed to xstrdup.
> 
> If you are referring to the last line, isn't it checking whether the
> string is empty, not NULL?

Oops, you're right.  Sorry for misreading that.

-- 
Matt Kraai
https://ftbfs.org/kraai
