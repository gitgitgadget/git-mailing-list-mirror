From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t8005: convert CP1251 character set to ISO8859-5
Date: Mon, 25 May 2009 05:26:43 -0400
Message-ID: <20090525092643.GB22382@coredump.intra.peff.net>
References: <7vhbzd85ux.fsf@alter.siamese.dyndns.org> <p2A1PR1KFf_G_uMMwQZtVeaDE_VcBr8lFjs9Jsg_OIkeypNbwPPRHP32EUHJ4leCZsycUOhFjHc@cipher.nrlssc.navy.mil> <p2A1PR1KFf_G_uMMwQZtVXPPBSNcQqEAV1ZnkoQLMJaPzWwJrkH_HCs5Kbt70yQlltZJxs4WxXo@cipher.nrlssc.navy.mil> <7vskiw4ooe.fsf@alter.siamese.dyndns.org> <7vhbzc4oht.fsf@alter.siamese.dyndns.org> <20090525092027.GA22382@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 11:27:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8WSd-0007m0-IR
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbZEYJ0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbZEYJ0p
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:26:45 -0400
Received: from peff.net ([208.65.91.99]:45992 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbZEYJ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:26:45 -0400
Received: (qmail 2670 invoked by uid 107); 25 May 2009 09:26:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 May 2009 05:26:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 May 2009 05:26:43 -0400
Content-Disposition: inline
In-Reply-To: <20090525092027.GA22382@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119906>

On Mon, May 25, 2009 at 05:20:27AM -0400, Jeff King wrote:

> With current 'next' and NO_PERL set, I can pass every test except:
> [...]
>   t7700 - seems to be some problem invoking touch. This might be easily
>           fixable, so I'll look into it.

Never mind about this one. It is broken with /usr/ucb/touch (because it
uses "-r"), but I usually do my auto-builds with /usr/bin/touch (I just
noticed it because I was testing by hand).

-Peff
