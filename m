From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v4 4/4] git-rebase: add keep_empty flag
Date: Wed, 11 Apr 2012 19:59:09 -0400
Message-ID: <20120411235909.GC16937@hmsreliant.think-freely.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-5-git-send-email-nhorman@tuxdriver.com>
 <7vsjgaht7d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI7Rm-0003AW-3J
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab2DKX71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 19:59:27 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41028 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab2DKX7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 19:59:24 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SI7RO-0005uw-2v; Wed, 11 Apr 2012 19:59:22 -0400
Content-Disposition: inline
In-Reply-To: <7vsjgaht7d.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195287>

On Wed, Apr 11, 2012 at 02:08:54PM -0700, Junio C Hamano wrote:
> This looks quite nice, but it seems that the change breaks at least t3416
> and t3404.  Has this series been tested?
> 
I did not, mostly because those tests didn't seem to work with empty commits at
all.  And rebases (interactive and automatic) that I've done manually in testing
worked fine.  I'll check on them in the AM though.

Neil
