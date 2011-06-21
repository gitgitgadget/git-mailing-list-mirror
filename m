From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all untracked
 files
Date: Tue, 21 Jun 2011 17:23:32 -0400
Message-ID: <4E010BD4.5000902@xiplink.com>
References: <1308612986-26593-1-git-send-email-david@porkrind.org> <20110621003852.GB2050@sigill.intra.peff.net> <4DFFF5AA.4030401@porkrind.org> <4E002762.3050803@sohovfx.com> <4E003A0F.5080601@viscovery.net> <20110621141843.GA18700@sigill.intra.peff.net> <4E00C2BD.6000903@esperanto.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andrew Wong <andrew.w@sohovfx.com>,
	David Caldwell <david@porkrind.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Ebermann <Paul.Ebermann@esperanto.de>
X-From: git-owner@vger.kernel.org Tue Jun 21 23:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ8QL-0001E4-UB
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 23:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750Ab1FUVXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 17:23:49 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:34943 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab1FUVXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 17:23:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 31591348647;
	Tue, 21 Jun 2011 17:23:46 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9160E34857E;
	Tue, 21 Jun 2011 17:23:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Thunderbird/3.1.10
In-Reply-To: <4E00C2BD.6000903@esperanto.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176199>

On 11-06-21 12:11 PM, Paul Ebermann wrote:
> 
> I think `--also-untracked` sounds better. It is even longer, though.
> 
> There could also be `--only-untracked`, which would stack only the
> untracked files (and let changes of tracked files there).

Perhaps -uall to match git-status's -u[<mode>] option (and also the long
version thereof)?

		M.
