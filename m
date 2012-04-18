From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v6 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Wed, 18 Apr 2012 06:49:19 -0400
Message-ID: <20120418104919.GC22172@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-3-git-send-email-nhorman@tuxdriver.com>
 <20120417214521.GB19908@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:49:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKSS5-0002qB-Mx
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 12:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab2DRKt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 06:49:28 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:35004 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab2DRKt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 06:49:28 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKSRs-0004Uu-7x; Wed, 18 Apr 2012 06:49:26 -0400
Content-Disposition: inline
In-Reply-To: <20120417214521.GB19908@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195853>

On Tue, Apr 17, 2012 at 11:45:22PM +0200, Clemens Buchacher wrote:
> On Tue, Apr 17, 2012 at 02:20:07PM -0400, Neil Horman wrote:
> >
> > +	if (!empty && !opts->keep_redundant_commits && index_unchanged)
> > +			/*
> > +			 * The head tree and the index match
> > +			 * meaning the commit is empty.  Since it wasn't created
> > +			 * empty (based on the previous test), we can conclude
> > +			 * the commit has been made redundant.  Since we don't
> > +			 * want to keep redundant commits, we can just return
> > +			 * here, skipping this commit
> > +			 */
> > +			return 0;
> 
> You can remove one level of indentation (yay!).
>
Doh!  Thanks.
Neil
