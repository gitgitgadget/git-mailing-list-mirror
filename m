From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Tue, 16 Sep 2008 15:12:42 -0400
Message-ID: <20080916191241.GB9870@sigill.intra.peff.net>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch> <1221470398-8698-3-git-send-email-trast@student.ethz.ch> <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com> <200809160205.23371.trast@student.ethz.ch> <32541b130809151710j59963af9id84b3c1553ec738d@mail.gmail.com> <7vy71s7b26.fsf@gitster.siamese.dyndns.org> <32541b130809160858k3c019f6pdc4831c831e22b55@mail.gmail.com> <7vhc8g6nqt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:14:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kffzk-0005cG-Pj
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 21:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbYIPTMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 15:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYIPTMo
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 15:12:44 -0400
Received: from peff.net ([208.65.91.99]:2489 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135AbYIPTMo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 15:12:44 -0400
Received: (qmail 24034 invoked by uid 111); 16 Sep 2008 19:12:43 -0000
Received: from lawn-128-61-126-143.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.126.143)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 16 Sep 2008 15:12:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2008 15:12:42 -0400
Content-Disposition: inline
In-Reply-To: <7vhc8g6nqt.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96027>

On Tue, Sep 16, 2008 at 09:48:10AM -0700, Junio C Hamano wrote:

> Ok, how about this patch?  I do not have an access to the box with
> AsciiDoc 8 handy right now, so I cannot test this myself, but there must
> be somebody on the list who can give a quick test to this.

No, using this patch and your test procedure, +old and +new are
identically broken with my version of asciidoc (8.2.7). Both contain
<sub> tags.

-Peff
