From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Thu, 7 Apr 2016 15:02:50 -0400
Message-ID: <20160407190249.GB4478@sigill.intra.peff.net>
References: <20160406171503.GA2345@dinwoodie.org>
 <20160407044219.GA29710@sigill.intra.peff.net>
 <20160407095006.GB2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Webb <chris@arachsys.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 21:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoFCl-0006hb-HE
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 21:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbcDGTCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 15:02:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:46009 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751509AbcDGTCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 15:02:54 -0400
Received: (qmail 27706 invoked by uid 102); 7 Apr 2016 19:02:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 15:02:54 -0400
Received: (qmail 29411 invoked by uid 107); 7 Apr 2016 19:02:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 15:02:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2016 15:02:50 -0400
Content-Disposition: inline
In-Reply-To: <20160407095006.GB2345@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290951>

On Thu, Apr 07, 2016 at 10:50:06AM +0100, Adam Dinwoodie wrote:

> > PS Is there a previous thread? I see a couple people cc'd, including me,
> >    but I don't remember a previous discussion. Did I just forget it?
> 
> No previous thread: I noticed the odd behaviour, and figured I'd report
> it.  The best way to report a problem seemed to be providing a test
> showing the behaviour, and the SubmittingPatches doc said I should CC
> folk who looked they're involved in the area...

Ah, yeah, that's definitely a good thing to do. I just didn't realize I
was ever involved with "-m". :)

-Peff
