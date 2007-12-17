From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt
	restriction.
Date: Mon, 17 Dec 2007 18:07:29 -0500
Message-ID: <20071217230729.GE2105@coredump.intra.peff.net>
References: <7vd4t5eq52.fsf@gitster.siamese.dyndns.org> <20071217090749.GC7453@artemis.madism.org> <7vir2xa8z7.fsf@gitster.siamese.dyndns.org> <20071217105834.GG7453@artemis.madism.org> <7v1w9la7o8.fsf@gitster.siamese.dyndns.org> <20071217123307.GK7453@artemis.madism.org> <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org> <20071217203143.GA2105@coredump.intra.peff.net> <20071217204204.GA13004@artemis.madism.org> <20071217210116.GB13004@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 00:07:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4P3z-00060z-Eo
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758965AbXLQXHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760061AbXLQXHc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:07:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4717 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758965AbXLQXHb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:07:31 -0500
Received: (qmail 14412 invoked by uid 111); 17 Dec 2007 23:07:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 17 Dec 2007 18:07:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Dec 2007 18:07:29 -0500
Content-Disposition: inline
In-Reply-To: <20071217210116.GB13004@artemis.madism.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68653>

On Mon, Dec 17, 2007 at 10:01:16PM +0100, Pierre Habouzit wrote:

>   Err I misread your point, _yes_ we do, see builtin-show-ref.c, or see
> --start-number in builtin-log.c. There is a precedent.

Ugh. Well, in that case, it seems we are stuck with it, and I think
the behavior Junio laid out is the right course of action.

-Peff
