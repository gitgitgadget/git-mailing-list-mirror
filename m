From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Re-re-re-fix common tail optimization
Date: Wed, 19 Dec 2007 14:18:45 +0000
Message-ID: <20071219141845.GA2146@hashpling.org>
References: <20071215111621.GA8139@coredump.intra.peff.net> <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net> <20071216070614.GA5072@sigill.intra.peff.net> <7v8x3ul927.fsf@gitster.siamese.dyndns.org> <7v7ijejq6j.fsf@gitster.siamese.dyndns.org> <20071216212104.GA32307@coredump.intra.peff.net> <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 15:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4zlm-0001mt-LM
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 15:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbXLSOTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 09:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbXLSOTK
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 09:19:10 -0500
Received: from fhw-relay07.plus.net ([212.159.14.215]:48011 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbXLSOTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 09:19:09 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1J4zl2-0003xH-1U; Wed, 19 Dec 2007 14:18:48 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBJEIjVg002629;
	Wed, 19 Dec 2007 14:18:46 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBJEIjjt002628;
	Wed, 19 Dec 2007 14:18:45 GMT
Content-Disposition: inline
In-Reply-To: <7v3au2joo2.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68908>

On Sun, Dec 16, 2007 at 01:49:17PM -0800, Junio C Hamano wrote:
> 
> Kind'a embarrassing that both of us cannot get this right without so
> many rounds, isn't it?
> 
> -- >8 --
> Subject: [PATCH] Re-re-re-fix common tail optimization
> 
> We need to be extra careful recovering the removed common section, so
> that we do not break context nor the changed incomplete line (i.e. the
> last line that does not end with LF).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Just to add to the woe on this one, this test breaks on MacOS X due to
the pattern length limitations of the default sed on that platform.

Interested in a patch?

Charles.
