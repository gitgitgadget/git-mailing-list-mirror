From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Thu, 28 May 2009 14:47:58 -0400
Message-ID: <20090528184758.GC13499@coredump.intra.peff.net>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org> <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil> <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil> <7vskiw4ooe.fsf@alter.siamese.dyndns.org> <7vhbzc4oht.fsf@alter.siamese.dyndns.org> <20090525092027.GA22382@coredump.intra.peff.net> <xZbeuW5cnER48WqsONW1BxZmepHjuwJtRUnpLAV0nv4mheMkGHT26g@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 28 20:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9keG-0001xb-2h
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 20:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861AbZE1SsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 14:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755202AbZE1SsF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 14:48:05 -0400
Received: from peff.net ([208.65.91.99]:33397 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbZE1SsF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 14:48:05 -0400
Received: (qmail 22290 invoked by uid 107); 28 May 2009 18:48:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 14:48:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 14:47:58 -0400
Content-Disposition: inline
In-Reply-To: <xZbeuW5cnER48WqsONW1BxZmepHjuwJtRUnpLAV0nv4mheMkGHT26g@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120208>

On Tue, May 26, 2009 at 09:57:41AM -0500, Brandon Casey wrote:

> > With current 'next' and NO_PERL set, I can pass every test except:
> 
> Oh, and have the recent changes that are now in next _allowed_ any new
> tests to pass that were previously failing?

Just one. It had been a while since I re-checked the skipped tests, so
most of what I found I could now pass was unrelated. But I believe your
recent patches fixed t3901 for me. On current 'next', it passes, but on
current 'maint', it says something like "cannot convert UTF-8 to utf-8".

-Peff
