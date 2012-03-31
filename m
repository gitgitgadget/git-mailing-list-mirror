From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH 1/4] git-cherry-pick: add keep-empty option
Date: Sat, 31 Mar 2012 08:57:16 -0400
Message-ID: <20120331125716.GA2409@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-2-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 14:57:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDxsN-0005Yc-AQ
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 14:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab2CaM5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 08:57:33 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:42752 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452Ab2CaM5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 08:57:25 -0400
Received: from neilslaptop.think-freely.org ([2001:470:8:a08:4a5d:60ff:fe96:79da] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SDxrp-0005hy-Q7; Sat, 31 Mar 2012 08:57:19 -0400
Content-Disposition: inline
In-Reply-To: <1333136922-12872-2-git-send-email-nhorman@tuxdriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194449>

On Fri, Mar 30, 2012 at 03:48:39PM -0400, Neil Horman wrote:
> git cherry-pick fails when picking a non-ff commit that is empty.  The advice
> given with the failure is that a git-commit --allow-empty should be issued to
> explicitly add the empty commit during the cherry pick.  This option allows a
> user to specify before hand that they want to keep the empty commit.  This
> eliminates the need to issue both a cherry pick and a commit operaion.
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Jeff King <peff@peff.net>
> CC: Phil Hord <phil.hord@gmail.com>
> CC: Junio C Hamano <gitster@pobox.com>
As you and Jeff noted, I can certainly change keep-empty to allow-empty, both
here and in the rebase command.  I'll add a test for it as well, early this
comming week.  Thanks!

Neil
