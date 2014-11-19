From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Wed, 19 Nov 2014 17:36:43 -0500
Message-ID: <20141119223643.GA13599@peff.net>
References: <20141119013532.GA861@peff.net>
 <20141119013739.GC2135@peff.net>
 <20141119020009.GR6527@google.com>
 <20141119020451.GA2734@peff.net>
 <20141119020713.GT6527@google.com>
 <20141119222852.GA12236@peff.net>
 <xmqq61earfa3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 23:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrDrt-0005Xz-2w
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 23:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757621AbaKSWgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 17:36:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:42561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757607AbaKSWgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 17:36:45 -0500
Received: (qmail 2095 invoked by uid 102); 19 Nov 2014 22:36:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 16:36:45 -0600
Received: (qmail 8609 invoked by uid 107); 19 Nov 2014 22:36:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 17:36:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 17:36:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61earfa3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 19, 2014 at 02:34:12PM -0800, Junio C Hamano wrote:

> > Subject: lock_ref_sha1_basic: do not die on locking errors
> 
> Will queue; thanks.

I just noticed that when I pasted it into the mail, I dropped the

  From: Ronnie Sahlberg <sahlberg@google.com>

header. Can you please make sure to credit Ronnie as you apply?

Thanks.

-Peff
