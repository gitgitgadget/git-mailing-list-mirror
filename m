From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 12/25] contrib: remove 'vim'
Date: Thu, 8 May 2014 22:02:05 -0400
Message-ID: <20140509020205.GC9787@sigill.intra.peff.net>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-13-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 04:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wia8b-0003Rp-CT
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989AbaEICCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:02:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:47909 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755963AbaEICCH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:02:07 -0400
Received: (qmail 15365 invoked by uid 102); 9 May 2014 02:02:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 May 2014 21:02:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 22:02:05 -0400
Content-Disposition: inline
In-Reply-To: <1399597116-1851-13-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248498>

On Thu, May 08, 2014 at 07:58:23PM -0500, Felipe Contreras wrote:

> There's nothing there.

It's not nothing; we used to carry the tools here, and replaced them
with pointers when the tools themselves went away. That was certainly
useful for a period of time.

However, I would certainly agree that that period of time is probably
over; the scripts started shipping in upstream vim in mid-2008. I'd be
happy to see this directory go away whether or not the rest of contrib/
is dropped.

-Peff
