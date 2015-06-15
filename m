From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 06/12] prune_remote(): use delete_refs()
Date: Mon, 15 Jun 2015 14:39:06 -0400
Message-ID: <20150615183906.GA10080@peff.net>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
 <aab9d191609b34fbfee0b68883a5b14fba2421ad.1434206062.git.mhagger@alum.mit.edu>
 <xmqq381sakgf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:39:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ZHu-00019T-V1
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbbFOSjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:39:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:46355 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752531AbbFOSjI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:39:08 -0400
Received: (qmail 2012 invoked by uid 102); 15 Jun 2015 18:39:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 13:39:08 -0500
Received: (qmail 6073 invoked by uid 107); 15 Jun 2015 18:39:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 14:39:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jun 2015 14:39:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqq381sakgf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271704>

On Mon, Jun 15, 2015 at 11:35:28AM -0700, Junio C Hamano wrote:

> But the log message puzzles me.  Didn't refs that cannot be deleted
> cause the original to fail?  After repacking without these refs, it
> called delete-ref, and a failure to delete or commit the deletion
> would have hit the error() down there, no?

I think this discussion:

  http://thread.gmane.org/gmane.comp.version-control.git/271017/focus=271164

from v1 is relevant.

-Peff
