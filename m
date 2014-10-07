From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Tue, 7 Oct 2014 14:31:36 -0400
Message-ID: <20141007183136.GA32374@peff.net>
References: <5430427A.5080800@web.de>
 <20141005224919.GA19998@google.com>
 <20141006011827.GA11027@peff.net>
 <xmqqfvezg2pl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:31:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZXz-0003Xi-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbaJGSbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 14:31:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:55829 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754719AbaJGSbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 14:31:39 -0400
Received: (qmail 24643 invoked by uid 102); 7 Oct 2014 18:31:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 13:31:39 -0500
Received: (qmail 8092 invoked by uid 107); 7 Oct 2014 18:31:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 14:31:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2014 14:31:36 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvezg2pl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257937>

On Tue, Oct 07, 2014 at 11:21:58AM -0700, Junio C Hamano wrote:

> > The fix you proposed below is along the same line, and looks good to me
> > (and grepping for 'var *+ *ofs' shows only the two sites you found, so
> > hopefully that is the last of it).
> 
> builtin/commit.c::parse_status_slot() has the same construct.

Thanks, I missed it because it uses "offset" instead of "ofs".

-Peff
