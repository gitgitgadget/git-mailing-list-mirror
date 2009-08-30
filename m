From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add date formatting and parsing functions relative
 to a given time
Date: Sun, 30 Aug 2009 05:15:57 -0400
Message-ID: <20090830091557.GA28531@coredump.intra.peff.net>
References: <20090828150212.GA6013@coredump.intra.peff.net>
 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
 <20090828190319.GA9233@blimp.localdomain>
 <20090828191521.GA12292@coredump.intra.peff.net>
 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
 <20090828193302.GB9233@blimp.localdomain>
 <20090828205232.GD9233@blimp.localdomain>
 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
 <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
 <20090830091346.GA14928@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 11:16:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhgWE-0007LC-FW
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 11:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbZH3JQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 05:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZH3JQA
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 05:16:00 -0400
Received: from peff.net ([208.65.91.99]:51557 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbZH3JP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 05:15:58 -0400
Received: (qmail 16649 invoked by uid 107); 30 Aug 2009 09:16:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 Aug 2009 05:16:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Aug 2009 05:15:57 -0400
Content-Disposition: inline
In-Reply-To: <20090830091346.GA14928@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127403>

On Sun, Aug 30, 2009 at 11:13:46AM +0200, Alex Riesen wrote:

> Have show_date_relative supplied the output buffer. As it is a new
> interface, it can as well be a little bit more generic than its sole
> caller. test-date.c is updated and shall follow in a moment.

FYI, I am munging test-date to match the test script I am writing, so
don't bother with that patch.

-Peff
