From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 2 Jul 2008 04:32:14 -0400
Message-ID: <20080702083214.GA22301@sigill.intra.peff.net>
References: <20080701101114.GA6379@sigill.intra.peff.net> <1214912674-9443-1-git-send-email-trast@student.ethz.ch> <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org> <20080702080200.GA21367@sigill.intra.peff.net> <7vd4lwemja.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 10:33:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxm6-0001D4-QA
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 10:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbYGBIcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 04:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbYGBIcS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 04:32:18 -0400
Received: from peff.net ([208.65.91.99]:4841 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbYGBIcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 04:32:17 -0400
Received: (qmail 1912 invoked by uid 111); 2 Jul 2008 08:32:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 02 Jul 2008 04:32:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Jul 2008 04:32:14 -0400
Content-Disposition: inline
In-Reply-To: <7vd4lwemja.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87102>

On Wed, Jul 02, 2008 at 01:08:09AM -0700, Junio C Hamano wrote:

> > So if the problem is "old perl", I don't think it is an issue. Are there
> > modern perl installations in the wild that don't have File::Temp?
> 
> The thing is, I think I heard quite similar explanation why Test::More is
> safe to use when the patch to add t/t9700 was submit.  Then what happened?

ISTR the Test::More problem was reported by Linus, who is a Fedora user?
I tried searching for any reasonable information on which of the core
perl modules are installed by default on Fedora systems, but didn't come
up with anything useful.

I really have no clue as to what is out there, and I suspect we must
either play it totally safe, or push the limits and wait for people to
complain about breakage.

-Peff
