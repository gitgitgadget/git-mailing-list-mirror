From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring the
 packed-refs lock
Date: Mon, 11 May 2015 12:49:41 -0400
Message-ID: <20150511164941.GA30541@peff.net>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu>
 <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu>
 <CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com>
 <20150501182257.GA27728@peff.net>
 <55445E60.6010205@alum.mit.edu>
 <20150505192110.GD10463@peff.net>
 <555083CF.8010205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 11 18:49:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrqtv-0007VK-LE
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 18:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbbEKQtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 12:49:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:56663 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753116AbbEKQtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 12:49:45 -0400
Received: (qmail 10251 invoked by uid 102); 11 May 2015 16:49:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 May 2015 11:49:44 -0500
Received: (qmail 11859 invoked by uid 107); 11 May 2015 16:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 May 2015 12:50:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 May 2015 12:49:41 -0400
Content-Disposition: inline
In-Reply-To: <555083CF.8010205@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268796>

On Mon, May 11, 2015 at 12:26:23PM +0200, Michael Haggerty wrote:

> > So something like 100ms max backoff makes sense to me, in that it keeps
> > us in the same order of magnitude as the expected time that the lock is
> > held. [...]
> 
> I don't understand your argument. If another process blocks us for on
> the order of 100 ms, the backoff time (reading from my table) is less
> than half of that.

I think it is just that I was agreeing with you, but communicated it
badly. I think your series is fine as-is.

-Peff
