From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 5 Apr 2012 20:12:00 -0400
Message-ID: <20120406001200.GA6736@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:12:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFwn4-0003qK-8W
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 02:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280Ab2DFAM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 20:12:29 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:59847 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab2DFAM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 20:12:28 -0400
Received: from [2001:470:8:a08:4a5d:60ff:fe96:79da] (helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFwmt-0006nl-3A; Thu, 05 Apr 2012 20:12:25 -0400
Content-Disposition: inline
In-Reply-To: <20120405232429.GA8654@hmsreliant.think-freely.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194823>

On Thu, Apr 05, 2012 at 07:24:29PM -0400, Neil Horman wrote:
> On Thu, Apr 05, 2012 at 01:12:51PM -0700, Junio C Hamano wrote:
> > Neil Horman <nhorman@tuxdriver.com> writes:
> > 
> > > As a convienience, it would be nice if we could pop entries off the argv_array
> > > structs so that if they had multiple uses in a function, we wouldn't have to
> > > clear them and repopulate common entries.  This patch adds the argv_array_pop
> > > function to do just that.  Common entries can be added to an argv_array first,
> > > then useage specific ones can be added on the end and removed later on.
> > >
> > > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > 
> > 
> > > CC: Jeff King <peff@peff.net>
> > > CC: Phil Hord <phil.hord@gmail.com>
> > > CC: Junio C Hamano <gitster@pobox.com>
> > > ---
> > 
> > Please don't do "Cc:" here; they belong to your e-mail header.
> > 
> You mean place them below the snip line?  I can do that.
> 
Actually, I can't do that, git-send-email looks for CC: in the patch text, and
git-format-patch automatically inserts the snip line.  I can put the cc's on the
command line, but if git-send-email is parsing this out of the wrong place, that
seems like a bug.  FWIW, CC's in this location are standard practice for kernel
patch submissions.
Neil
