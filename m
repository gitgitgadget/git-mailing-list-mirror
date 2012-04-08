From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 8 Apr 2012 07:04:51 -0400
Message-ID: <20120408110451.GA21217@sigill.intra.peff.net>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
 <20120408044825.GA4296@sigill.intra.peff.net>
 <7v62daye43.fsf@alter.siamese.dyndns.org>
 <20120408054251.GA8100@sigill.intra.peff.net>
 <20120408081245.GA18407@sigill.intra.peff.net>
 <m27gxqk2vs.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Apr 08 13:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGpvl-0008I4-C8
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 13:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab2DHLE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 07:04:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54428
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892Ab2DHLE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 07:04:57 -0400
Received: (qmail 2868 invoked by uid 107); 8 Apr 2012 11:05:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 07:05:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 07:04:51 -0400
Content-Disposition: inline
In-Reply-To: <m27gxqk2vs.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194990>

On Sun, Apr 08, 2012 at 11:07:51AM +0200, Andreas Schwab wrote:

> >    Bash will continue after a failed exec.
> 
> Only when interactive.  A non-interactive shell respects the execfail
> shopt (off by default).

Thanks, I didn't know that. Let's not worry about error-handling after
the exec then.

-Peff
