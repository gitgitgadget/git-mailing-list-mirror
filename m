From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG] git bisect should not expand file globs in log
Date: Tue, 12 Feb 2008 22:10:50 +0100
Message-ID: <200802122210.50990.elendil@planet.nl>
References: <200802122023.28879.elendil@planet.nl> <alpine.LSU.1.00.0802121950210.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:11:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2Pm-0007yQ-Lv
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763355AbYBLVLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762583AbYBLVLH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:11:07 -0500
Received: from hpsmtp-eml13.KPNXCHANGE.COM ([213.75.38.113]:45056 "EHLO
	hpsmtp-eml13.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760884AbYBLVLF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 16:11:05 -0500
Received: from cpsmtp-eml108.kpnxchange.com ([213.75.84.108]) by hpsmtp-eml13.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Feb 2008 22:11:03 +0100
Received: from faramir.fjphome.nl ([84.85.147.182]) by cpsmtp-eml108.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Feb 2008 22:10:51 +0100
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0802121950210.3870@racer.site>
Content-Disposition: inline
X-OriginalArrivalTime: 12 Feb 2008 21:10:51.0471 (UTC) FILETIME=[BF3B5DF0:01C86DBB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73692>

On Tuesday 12 February 2008, you wrote:
> does this help?  (It is a really trivial patch...)

Yes, it does. Thanks.

You beat Alex by about 15 minutes. If I'd known this was just shell script, 
I could've done the patch myself :-P

> [PATCH] bisect: use verbatim commit subject in the bisect log
>
> Due to a typo, the commit subject was shell expanded in the bisect log.
> That is, if you had some shell pattern in the commit subject, bisect
> would happily put all matching file names into the log.
>
> Noticed by Frans Pop.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Tested-by: Frans Pop <elendil@planet.nl>
