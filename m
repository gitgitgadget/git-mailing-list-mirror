From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar
 to disable display of #
Date: Wed, 28 Aug 2013 16:18:03 -0400
Message-ID: <20130828201803.GB8088@sigill.intra.peff.net>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
 <1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
 <1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
 <xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 22:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmBx-0007mb-6P
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab3H1USI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 16:18:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:58551 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab3H1USH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 16:18:07 -0400
Received: (qmail 5728 invoked by uid 102); 28 Aug 2013 20:18:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Aug 2013 15:18:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Aug 2013 16:18:03 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1u5da8dp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233208>

On Wed, Aug 28, 2013 at 01:05:38PM -0700, Junio C Hamano wrote:

> What are our plans to help existing scripts people have written over
> time, especially before "status -s" was invented, that will be
> broken by use of this?

I thought that our response to parsing the long output of "git status"
was always "you are doing it wrong". The right way has always been to
run the plumbing tools yourself, followed eventually by the --porcelain
mode to "git status" being blessed as a convenient plumbing.

I will not say that people might not do it anyway, but at what point do
we say "you were warned"?

-Peff
