From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase: support -X to pass through strategy options
Date: Wed, 4 Aug 2010 11:51:08 +0200
Message-ID: <201008041151.08650.trast@student.ethz.ch>
References: <80763c667fa4685d2b6451838c0f1809e86fe07e.1280354419.git.trast@student.ethz.ch> <7vd3u6uv41.fsf@alter.siamese.dyndns.org> <7vaap3i9c0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mike Lundy <mike@fluffypenguin.org>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 11:51:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgadN-0006xa-O3
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 11:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393Ab0HDJvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 05:51:32 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:57861 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756874Ab0HDJvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 05:51:32 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 4 Aug
 2010 11:51:30 +0200
Received: from thomas.site (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 4 Aug
 2010 11:51:10 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7vaap3i9c0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152570>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Looks good; thanks both.
> 
> I spoke too fast.  You would need something like this on top to avoid
> confusing certain implementations of "expr" (e.g. FreeBSD 8.0).

Annoying, but thanks...  and it turns out this is even in the expr
info manual, so I should have known.  Sigh.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
