From: Jeff King <peff@peff.net>
Subject: Re: Disk waste with packs and .keep files
Date: Tue, 10 Jun 2014 15:48:22 -0400
Message-ID: <20140610194822.GA23234@sigill.intra.peff.net>
References: <vpqmwdljhu8.fsf@anie.imag.fr>
 <20140610185321.GA25845@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:30:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSgN-0005TL-P5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbaFJUaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:30:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:41221 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753038AbaFJTsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 15:48:23 -0400
Received: (qmail 12126 invoked by uid 102); 10 Jun 2014 19:48:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 14:48:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 15:48:22 -0400
Content-Disposition: inline
In-Reply-To: <20140610185321.GA25845@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251232>

On Tue, Jun 10, 2014 at 02:53:21PM -0400, Jeff King wrote:

> This patch is the minimal fix to restore the desired
> behavior for the default state. However, the real fix will
> be more involved.

This patch actually breaks t7700, but because the test is wrong. Double
yikes. All fixed in my series, which should be along in a moment.

-Peff
