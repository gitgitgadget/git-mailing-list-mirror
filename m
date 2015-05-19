From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (May 2015, #05; Tue, 19)
Date: Tue, 19 May 2015 18:28:44 -0400
Message-ID: <20150519222843.GB994@peff.net>
References: <xmqqbnhg6y8h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:28:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuq0J-0006yd-HA
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbbESW2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:28:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:32900 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751375AbbESW2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:28:46 -0400
Received: (qmail 20097 invoked by uid 102); 19 May 2015 22:28:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 17:28:46 -0500
Received: (qmail 18289 invoked by uid 107); 19 May 2015 22:28:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 18:28:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 18:28:44 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnhg6y8h.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269427>

On Tue, May 19, 2015 at 02:42:06PM -0700, Junio C Hamano wrote:

> * jk/http-backend-deadlock (2015-05-15) 2 commits
>  - http-backend: spool ref negotiation requests to buffer
>  - http-backend: fix die recursion with custom handler
> 
>  Communication between the HTTP server and http_backend process can
>  lead to a dead-lock when relaying a large ref negotiation request.
>  Diagnose the situation better, and mitigate it by reading such a
>  request first into core (to a reasonable limit).
> 
>  Will merge to 'next'.

FYI, my plan was to re-roll this with a configurable max-buffer value
(and a higher default). That can come on top if you prefer, though.

-Peff
