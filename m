From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 14:02:23 -0400
Message-ID: <20160324180223.GA9817@sigill.intra.peff.net>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
 <xmqqpoujama8.fsf@gitster.mtv.corp.google.com>
 <56F42820.5000003@assembla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stanislav Kolotinskiy <stanislav@assembla.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 19:02:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9aY-0007Pd-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbcCXSC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:02:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:37657 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750865AbcCXSC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:02:26 -0400
Received: (qmail 16193 invoked by uid 102); 24 Mar 2016 18:02:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 14:02:25 -0400
Received: (qmail 15284 invoked by uid 107); 24 Mar 2016 18:02:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Mar 2016 14:02:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Mar 2016 14:02:23 -0400
Content-Disposition: inline
In-Reply-To: <56F42820.5000003@assembla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289776>

On Thu, Mar 24, 2016 at 07:47:12PM +0200, Stanislav Kolotinskiy wrote:

> >Thanks for noticing; the above explanation however does not make it
> >very clear why the symptom exhibits itself only when "directory" is
> >given (it also is unclear if "target" being a directory is special,
> >or if any remote repository specification, e.g. host:/path/to/dir,
> >triggers the same problem).
> I'll think about a better explanation and will post it here - thanks.

Feel free to steal from the explanation I posted earlier.

-Peff
