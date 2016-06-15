From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] refs.c: Have a write_in_full_to_lock_file wrapping
 write_in_full
Date: Wed, 21 Jan 2015 18:40:26 -0500
Message-ID: <20150121234026.GC11115@peff.net>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
 <1421882625-916-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:40:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4sy-0003Ct-CF
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbbAUXk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:40:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:37102 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751503AbbAUXk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:40:27 -0500
Received: (qmail 2399 invoked by uid 102); 21 Jan 2015 23:40:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 17:40:27 -0600
Received: (qmail 1926 invoked by uid 107); 21 Jan 2015 23:40:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jan 2015 18:40:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2015 18:40:26 -0500
Content-Disposition: inline
In-Reply-To: <1421882625-916-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262785>

On Wed, Jan 21, 2015 at 03:23:43PM -0800, Stefan Beller wrote:

> Now we only have one place where we need to touch the internals of
> the lock_file struct.

I wonder if the point of the previous patch would be more obvious if it
were combined with this one. I am OK leaving them separate, though.

-Peff
