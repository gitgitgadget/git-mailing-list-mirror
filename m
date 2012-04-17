From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH v6 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Tue, 17 Apr 2012 23:45:22 +0200
Message-ID: <20120417214521.GB19908@ecki>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-1-git-send-email-nhorman@tuxdriver.com>
 <1334686809-17634-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:05:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGWU-0000q0-CS
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab2DQWFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:05:11 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:13622 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757Ab2DQWFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:05:10 -0400
Received: from [127.0.0.1] (p5B22CC82.dip.t-dialin.net [91.34.204.130])
	by bsmtp.bon.at (Postfix) with ESMTP id D6ED2130049;
	Wed, 18 Apr 2012 00:05:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1334686809-17634-3-git-send-email-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195813>

On Tue, Apr 17, 2012 at 02:20:07PM -0400, Neil Horman wrote:
>
> +	if (!empty && !opts->keep_redundant_commits && index_unchanged)
> +			/*
> +			 * The head tree and the index match
> +			 * meaning the commit is empty.  Since it wasn't created
> +			 * empty (based on the previous test), we can conclude
> +			 * the commit has been made redundant.  Since we don't
> +			 * want to keep redundant commits, we can just return
> +			 * here, skipping this commit
> +			 */
> +			return 0;

You can remove one level of indentation (yay!).
