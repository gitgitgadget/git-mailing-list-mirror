From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Bring "format-patch --notes" closer to a real feature
Date: Thu, 18 Oct 2012 06:02:34 -0400
Message-ID: <20121018100234.GF9999@sigill.intra.peff.net>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 12:02:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOmwE-0006QQ-Sx
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 12:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755393Ab2JRKCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 06:02:38 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37673 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143Ab2JRKCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 06:02:37 -0400
Received: (qmail 4232 invoked by uid 107); 18 Oct 2012 10:03:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 06:03:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 06:02:34 -0400
Content-Disposition: inline
In-Reply-To: <1350539128-21577-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207991>

On Wed, Oct 17, 2012 at 10:45:22PM -0700, Junio C Hamano wrote:

> We never advertised the "--notes" option to format-patch (or
> anything related to the pretty format options for that matter)
> because the behaviour of these options was whatever they happened to
> do, not what they were designed to do.
> 
> It had a few obvious glitches:
> 
>  * The notes section was appended immediately after the log message,
>    and then the three-dash line was added.  Such a supplimental
>    material should come after the three-dash line.
> 
>  * The logic to append a new sign-off with "format-patch --signoff"
>    worked on the message after the note was added, which made the
>    detection of existing sign-off lines incorrect.
> 
> This updates the handling of "--notes" option to correct these, in
> an attempt to bring it closer to a real feature.

I just read through the whole series. Aside from the tangent about
strbuf_detach, I didn't see anything wrong. Thanks for moving this
forward.

-Peff
