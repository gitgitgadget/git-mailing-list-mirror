From: Jeff King <peff@peff.net>
Subject: Re: [PATCH +warn] Implement https public key pinning
Date: Mon, 15 Feb 2016 20:22:11 -0500
Message-ID: <20160216012210.GB11961@sigill.intra.peff.net>
References: <87y4amcby5.fsf@mitoraj.siccegge.de>
 <20160215140422.GA1747@mitoraj.siccegge.de>
 <xmqqr3gdo8sz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christoph Egger <christoph@christoph-egger.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 02:22:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVULJ-0002IC-HE
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 02:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbcBPBWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 20:22:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:42691 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751491AbcBPBWN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 20:22:13 -0500
Received: (qmail 12679 invoked by uid 102); 16 Feb 2016 01:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 20:22:13 -0500
Received: (qmail 15143 invoked by uid 107); 16 Feb 2016 01:22:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 20:22:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 20:22:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3gdo8sz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286301>

On Mon, Feb 15, 2016 at 03:25:32PM -0800, Junio C Hamano wrote:

> Thanks.  This, when applied on top of 2.7.1, however seems to break
> at least t5541 and t5551.

Hrm. I cannot see how the new code can possibly do anything unless
http.pinnedpubkey is set, and our tests don't do that. Neither t5541 nor
t5551 fails for me with the patch on top of v2.7.1 (or current "pu", for
that matter).

What does the failure look like?

-Peff
