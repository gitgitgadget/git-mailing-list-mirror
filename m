From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the
 documentation
Date: Tue, 30 Sep 2014 12:15:43 -0400
Message-ID: <20140930161543.GA10581@peff.net>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
 <1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>
 <xmqq8ul6869o.fsf@gitster.dls.corp.google.com>
 <542AB323.4080402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 30 18:15:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZ05e-0004xh-BN
	for gcvg-git-2@plane.gmane.org; Tue, 30 Sep 2014 18:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbaI3QPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2014 12:15:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:53203 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751245AbaI3QPp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2014 12:15:45 -0400
Received: (qmail 31985 invoked by uid 102); 30 Sep 2014 16:15:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Sep 2014 11:15:45 -0500
Received: (qmail 18730 invoked by uid 107); 30 Sep 2014 16:15:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Sep 2014 12:15:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Sep 2014 12:15:43 -0400
Content-Disposition: inline
In-Reply-To: <542AB323.4080402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257673>

On Tue, Sep 30, 2014 at 03:41:55PM +0200, Michael Haggerty wrote:

> I didn't fix it because IMO the correct fix is to add a stdio-oriented
> entry point to the lockfile API, and teach the lockfile code to handle
> closing the FILE correctly when necessary.

I think so, too, after our discussion[1] surrounding 9540ce5 (refs: write
packed_refs file using stdio, 2014-09-10).

> But I didn't want to add even more changes to this patch series, so I am
> working on this as a separate patch series. I hope to submit it soon.

Yay.

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/256729/focus=256734
