From: Jeff King <peff@peff.net>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Tue, 27 Jul 2010 01:30:40 -0400
Message-ID: <20100727053040.GA6014@coredump.intra.peff.net>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
 <AANLkTimdYfv-Z57iHD+YLfjKi66av5xmaC3JEMRNRw+Y@mail.gmail.com>
 <AANLkTin9kbMp5nOS=GaM2rX1w+y8vbzYfWunkSSeoPZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 07:30:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odckk-0004Wf-MH
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 07:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358Ab0G0Faq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 01:30:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60195 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab0G0Fap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 01:30:45 -0400
Received: (qmail 13588 invoked by uid 111); 27 Jul 2010 05:30:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 27 Jul 2010 05:30:43 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jul 2010 01:30:40 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin9kbMp5nOS=GaM2rX1w+y8vbzYfWunkSSeoPZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151909>

On Fri, Jul 23, 2010 at 02:16:45AM -0400, Avery Pennarun wrote:

> Only this: Junio said that there are no major downsides to this change
> - and given the slow pace of change in gitk/git-gui, this is probably
> true - but are there any *upsides*?  What problem does this solve?

One minor complaint with the current setup is that browsing the history
with path limiting is unintuitive. You can't do "gitk gitk" in the
gitk-git directory. You must instead do "cd .. && gitk -- gitk".

-Peff
