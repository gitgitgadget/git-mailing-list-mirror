From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v4 4/4] git-rebase: add keep_empty flag
Date: Thu, 12 Apr 2012 11:58:49 -0400
Message-ID: <20120412155849.GA2749@neilslaptop.think-freely.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-5-git-send-email-nhorman@tuxdriver.com>
 <7vsjgaht7d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:59:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIMQU-0005YL-8B
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965504Ab2DLP7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:59:09 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:50459 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965265Ab2DLP7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:59:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.202] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SIMQC-0002F2-Bk; Thu, 12 Apr 2012 11:59:03 -0400
Content-Disposition: inline
In-Reply-To: <7vsjgaht7d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195341>

On Wed, Apr 11, 2012 at 02:08:54PM -0700, Junio C Hamano wrote:
> This looks quite nice, but it seems that the change breaks at least t3416
> and t3404.  Has this series been tested?
> 
I've looked at these, and I think it appears that this is the result of the
changes I made to interactive rebasing in which empty comments were commented
out, and additional notes were added to the commit editor template.  It seems to
be messing with what the fake editor for these tests is expecting.  I've got
some things I need to do tonight and tomorrow, but I'll fix this up over the
weekend.

Thanks!
Neil
