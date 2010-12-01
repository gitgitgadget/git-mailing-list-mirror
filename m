From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config
 options
Date: Wed, 1 Dec 2010 12:58:15 -0500
Message-ID: <20101201175815.GB7774@sigill.intra.peff.net>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
 <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
 <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
 <20101201160503.GB26120@burratino>
 <m3aakp4g5o.fsf@localhost.localdomain>
 <20101201163406.GD26120@burratino>
 <4CF67D36.9020908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 18:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNqwi-0003oP-4o
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 18:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab0LAR6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 12:58:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55747 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545Ab0LAR6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 12:58:17 -0500
Received: (qmail 5812 invoked by uid 111); 1 Dec 2010 17:58:16 -0000
Received: from 129-79-255-226.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.226)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 01 Dec 2010 17:58:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Dec 2010 12:58:15 -0500
Content-Disposition: inline
In-Reply-To: <4CF67D36.9020908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162558>

On Wed, Dec 01, 2010 at 05:52:06PM +0100, Michael J Gruber wrote:

> So you guys are going to break current behaviour (for "cvsimport.r" etc.)?

I have not been following this thread, but as I understand it,
"cvsimport.r" is somewhat broken already, isn't it? I thought the
original problem was that it got parsed as both "-r" and "-R", and one
of them tried to enforce some type semantics on the value.

If there are short config options that work, though, we should probably
keep them. It surely can't be that hard for the perl code to accept both
"cvsimport.r" and "cvsimport.remote" for "-r" and
"cvsimport.generaterevisions" (or whatever) for "-R"?

-Peff
