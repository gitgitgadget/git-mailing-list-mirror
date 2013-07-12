From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] t0008: avoid SIGPIPE race condition on fifo
Date: Fri, 12 Jul 2013 12:42:30 -0400
Message-ID: <68152DD0-64A0-4B69-A788-48F9D93BEEC3@gernhardtsoftware.com>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com> <20130711133414.GF6015@sigill.intra.peff.net> <7vli5drsbw.fsf@alter.siamese.dyndns.org> <20130712103522.GA4750@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 18:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxgR0-0003ih-UO
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 18:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023Ab3GLQnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 12:43:04 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54293 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964817Ab3GLQnC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 12:43:02 -0400
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id CDBEB27361E2;
	Fri, 12 Jul 2013 16:42:58 +0000 (UTC)
In-Reply-To: <20130712103522.GA4750@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230206>


On Jul 12, 2013, at 6:35 AM, Jeff King <peff@peff.net> wrote:

> Subject: [PATCH] t0008: avoid SIGPIPE race condition on fifo

Was able to complete a prove run with this patch.  Many thanks.

~~ Brian
