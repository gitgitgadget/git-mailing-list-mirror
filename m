From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 12:05:20 -0400
Message-ID: <20110913160520.GA28634@sigill.intra.peff.net>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vk49d5t8u.fsf@alter.siamese.dyndns.org>
 <4E6E928A.6080003@sunshineco.com>
 <7vwrdd1gyc.fsf@alter.siamese.dyndns.org>
 <20110912233348.GE28994@sigill.intra.peff.net>
 <DJ8J88If0KG_BPR1BK-feQRQ5yjv1AIYHW3sMosJzbrjCLKCIJABAFuSAH9IrkEl-y3-8mIKsysdqADcV6A7C7f4UuM9aZNpztbz_L9pXXw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Boaz Harrosh <bharrosh@panasas.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Shumkin <zapped@mail.ru>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 13 18:05:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3VUH-0000vf-Vv
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 18:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233Ab1IMQFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 12:05:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39295
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab1IMQFX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 12:05:23 -0400
Received: (qmail 30087 invoked by uid 107); 13 Sep 2011 16:06:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Sep 2011 12:06:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2011 12:05:20 -0400
Content-Disposition: inline
In-Reply-To: <DJ8J88If0KG_BPR1BK-feQRQ5yjv1AIYHW3sMosJzbrjCLKCIJABAFuSAH9IrkEl-y3-8mIKsysdqADcV6A7C7f4UuM9aZNpztbz_L9pXXw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181287>

On Tue, Sep 13, 2011 at 10:15:15AM -0500, Brandon Casey wrote:

> ...and I see there is already an fnmatch_icase() in dir.c which adds
> FNM_CASEFOLD when the global var ignore_case is set.  So, maybe it's as
> easy as:
> [...]
> -               return (fnmatch(pattern, basename, 0) == 0);
> +               return (fnmatch_icase(pattern, basename, 0) == 0);

OK, wow. That's exactly the level of easy I was hoping for. Do you want
to roll that up into a patch with some tests?

-Peff
