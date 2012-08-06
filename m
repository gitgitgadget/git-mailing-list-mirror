From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 06 Aug 2012 19:31:30 -0400
Message-ID: <1344295889-sup-7899@pinkfloyd.chass.utoronto.ca>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca> <7vboio231n.fsf@alter.siamese.dyndns.org> <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca> <20120806193958.GA10039@sigill.intra.peff.net> <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca> <20120806213404.GA14320@sigill.intra.peff.net> <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca> <20120806223113.GA16298@sigill.intra.peff.net> <1344292395-sup-1921@pinkfloyd.chass.utoronto.ca> <20120806224222.GA16721@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 01:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyWlw-0004QY-Kd
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 01:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074Ab2HFXbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 19:31:35 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:53744 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab2HFXbf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 19:31:35 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54772 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyWlm-0008T5-Qx; Mon, 06 Aug 2012 19:31:30 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyWlm-0005AJ-Ok; Mon, 06 Aug 2012 19:31:30 -0400
In-reply-to: <20120806224222.GA16721@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202999>

Excerpts from Jeff King's message of Mon Aug 06 18:42:22 -0400 2012:

> +    if (strbuf_getwholeline(sb, fd, term))

Shouldn't this be strbuf_getwholeline_fd though?

Otherwise, I think this is a good addition.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
