From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] makefile: add ability to run specific test files
Date: Thu, 10 Jul 2014 16:44:24 -0400
Message-ID: <20140710204424.GB4459@sigill.intra.peff.net>
References: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
 <xmqq61j69m0m.fsf@gitster.dls.corp.google.com>
 <1404949763.23510.42.camel@jekeller-desk1.amr.corp.intel.com>
 <CAPc5daWNB0m23tPdYxWmQEpu8PshFWwwZ3n_bSxF6evwM7-61g@mail.gmail.com>
 <1405024797.4925.1.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "gitster@pobox.com" <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:44:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5LCh-0004AQ-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbaGJUo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:44:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:59596 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751786AbaGJUo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:44:27 -0400
Received: (qmail 13087 invoked by uid 102); 10 Jul 2014 20:44:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jul 2014 15:44:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 16:44:24 -0400
Content-Disposition: inline
In-Reply-To: <1405024797.4925.1.camel@jekeller-desk1.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253213>

On Thu, Jul 10, 2014 at 08:39:57PM +0000, Keller, Jacob E wrote:

> Ok, I'll give it a shot. All I know for sure right now is running the
> test directly passed and running from "make test" it failed.

When you say directly, I assume you mean "cd t && ./1234-xxx.sh".
You can also run a single-shot test like:

  cd t && make t1234-...

which may make the environment more like "make test".

-Peff
