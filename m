From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated submodules
Date: Wed, 14 Sep 2011 09:20:25 -0400
Message-ID: <4E70AA19.6060701@xiplink.com>
References: <20110912195652.GA27850@sigill.intra.peff.net> <7vr53l5u7h.fsf@alter.siamese.dyndns.org> <20110912224934.GA28994@sigill.intra.peff.net> <4E6FAB46.30508@web.de> <20110913221745.GB24549@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 15:20:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3pOZ-00045w-6T
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 15:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616Ab1INNUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 09:20:50 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:58458 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406Ab1INNUu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 09:20:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp27.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 7B75C118587;
	Wed, 14 Sep 2011 09:20:49 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp27.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 43C4311844B;
	Wed, 14 Sep 2011 09:20:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
In-Reply-To: <20110913221745.GB24549@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181357>

On 11-09-13 06:17 PM, Jeff King wrote:
> 
> And superproject repositories are probably not going
> to have the same number of commits as submodule repositories, so it may
> be less of an issue.

Just a side note:  I don't think this is a safe assumption.  It's certainly
not the case in our repo, where the submodules are infrequently updated.

		M.
