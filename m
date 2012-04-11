From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v4 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Wed, 11 Apr 2012 19:35:58 -0400
Message-ID: <20120411233558.GA16937@hmsreliant.think-freely.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com>
 <7v62d6j8qz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:36:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI75T-00072J-MF
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 01:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761524Ab2DKXgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 19:36:21 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40480 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab2DKXgR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 19:36:17 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SI74y-0005af-A3; Wed, 11 Apr 2012 19:36:11 -0400
Content-Disposition: inline
In-Reply-To: <7v62d6j8qz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195281>

On Wed, Apr 11, 2012 at 01:47:48PM -0700, Junio C Hamano wrote:
> You inherited the following from your previous round.
> 
> Applying: git-cherry-pick: Add keep-redundant-commits option
> /srv/project/git/git.git/.git/rebase-apply/patch:115: space before tab in indent.
>  			 * The head tree and the parent tree match
> /srv/project/git/git.git/.git/rebase-apply/patch:116: space before tab in indent.
>  			 * meaning the commit is empty.  Since it wasn't created
> /srv/project/git/git.git/.git/rebase-apply/patch:117: space before tab in indent.
>  			 * empty (based on the previous test), we can conclude
> /srv/project/git/git.git/.git/rebase-apply/patch:118: space before tab in indent.
>  			 * the commit has been made redundant.  Since we don't
> /srv/project/git/git.git/.git/rebase-apply/patch:119: space before tab in indent.
>  			 * want to keep redundant commits, just skip this one
> warning: squelched 3 whitespace errors
> fatal: 8 lines add whitespace errors.
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> Patch failed at 0001 git-cherry-pick: Add keep-redundant-commits option
> 

Grr, thanks, forgot to run checkpatch
Neil
