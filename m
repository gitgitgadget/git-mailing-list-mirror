From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] add description parameter to OPT__QUIET
Date: Mon, 8 Nov 2010 14:57:52 -0500
Message-ID: <20101108195752.GA31270@sigill.intra.peff.net>
References: <4CD83917.3040801@lsrfire.ath.cx>
 <4CD83ABD.30804@lsrfire.ath.cx>
 <20101108181801.GB30428@sigill.intra.peff.net>
 <20101108195448.GA12660@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 20:57:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFXpv-0002uJ-Gy
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 20:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab0KHT45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 14:56:57 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58874 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab0KHT45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 14:56:57 -0500
Received: (qmail 31945 invoked by uid 111); 8 Nov 2010 19:56:56 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 08 Nov 2010 19:56:56 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Nov 2010 14:57:52 -0500
Content-Disposition: inline
In-Reply-To: <20101108195448.GA12660@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160978>

On Mon, Nov 08, 2010 at 01:54:48PM -0600, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Maybe my "don't repeat yourself" spider sense is over-reacting, but of
> > 12 callsites, 11 of them will continue to use "be quiet".
> 
> Maybe something like this would help alleviate the smell.
> [patch with actual per-command descriptions of quiet mode]

Yeah, that is even better.

-Peff
