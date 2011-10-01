From: Jeff King <peff@peff.net>
Subject: Re: 6d4bb3833c3d2114d (fetch: verify we have everything we need
 before updating our ref) breaks fetch
Date: Sat, 1 Oct 2011 06:54:05 -0400
Message-ID: <20111001105405.GA4396@sigill.intra.peff.net>
References: <1317225869.30267.18.camel@bee.lab.cmartin.tk>
 <m3y5x8o527.fsf@localhost.localdomain>
 <1317426849.4331.29.camel@centaur.lab.cmartin.tk>
 <20111001060353.GA25228@sigill.intra.peff.net>
 <BED2B875AEDF4E52843F1C9211A8D2A1@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Oct 01 12:54:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9xCy-0004Cx-Dl
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 12:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab1JAKyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 06:54:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50791
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045Ab1JAKyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 06:54:10 -0400
Received: (qmail 11016 invoked by uid 107); 1 Oct 2011 10:59:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Oct 2011 06:59:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Oct 2011 06:54:05 -0400
Content-Disposition: inline
In-Reply-To: <BED2B875AEDF4E52843F1C9211A8D2A1@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182546>

On Sat, Oct 01, 2011 at 11:38:08AM +0100, Philip Oakley wrote:

> Is there a write up of the the git testing method and how to use
> bin-wrappers etc. I didn't see anything in the Documentation, but I
> may not have looked carefully enough

Bin-wrappers (and the alternative, which is setting up the exec-path
yourself) are mentioned briefly in INSTALL. Running tests is described
in t/README.

Other than that, you're left on your own to read the code and the commit
messages. :)

-Peff
