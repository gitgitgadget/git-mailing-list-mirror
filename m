From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path
	to patch
Date: Thu, 22 Nov 2007 06:36:00 -0500
Message-ID: <20071122113600.GB12913@sigill.intra.peff.net>
References: <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org> <20071122091356.GD7153@sigill.intra.peff.net> <7v8x4q7gns.fsf@gitster.siamese.dyndns.org> <887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com> <7vlk8q5xj4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:36:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvAM3-00045i-WB
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbXKVLgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXKVLgE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:36:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3024 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbXKVLgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:36:02 -0500
Received: (qmail 22846 invoked by uid 111); 22 Nov 2007 11:36:00 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 06:36:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 06:36:00 -0500
Content-Disposition: inline
In-Reply-To: <7vlk8q5xj4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65802>

On Thu, Nov 22, 2007 at 03:29:03AM -0800, Junio C Hamano wrote:

> There was one funny thing I fixed up.  The arguments to the
> interactive_add() function in builtin-add.c was like this:
> 
> 	int interactive_add(const char **argv, int argc)
> 
> Anybody who writes a function with such a signature and do not
> notice its craziness before sending it out either (1) has never
> programmed in C, (2) did not review the code before submitting,
> or (3) worked too hard and was too tired.

Heh. I looked the patch over, noticed a subtle memcpy issue, and didn't
even notice the craziness. I claim 3, also.

-Peff
