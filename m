From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 13:00:10 -0400
Message-ID: <20140521170010.GE2040@sigill.intra.peff.net>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
 <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
 <20140520182443.GA30533@sigill.intra.peff.net>
 <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
 <20140521164255.GA2040@sigill.intra.peff.net>
 <20140521165543.GA3743@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 19:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn9sJ-0000OA-AR
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 19:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbaEURAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 13:00:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:56638 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752066AbaEURAM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 13:00:12 -0400
Received: (qmail 21482 invoked by uid 102); 21 May 2014 17:00:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 12:00:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 13:00:10 -0400
Content-Disposition: inline
In-Reply-To: <20140521165543.GA3743@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249810>

On Wed, May 21, 2014 at 09:55:43AM -0700, Jeremiah Mahler wrote:

> I am fine with including your previous patch.

I think that would be my preference, but we'll see what Junio says.

> Would like me to test it out and create another patch set?

Yeah, that would be the logical next step. I think the only thing you
should need to adjust in your patch is to strip only one line from the
output, rather than two.

-Peff
