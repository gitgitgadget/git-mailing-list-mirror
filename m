From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Falling back "diff -C -C" to "diff -C" more
 gracefully
Date: Thu, 6 Jan 2011 17:28:36 -0500
Message-ID: <20110106222836.GA13727@sigill.intra.peff.net>
References: <1juopju.rh4v4z97i9hmM%lists@haller-berlin.de>
 <7vhbdlahnp.fsf@alter.siamese.dyndns.org>
 <1294350606-19530-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 23:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PayKm-0000c8-Dm
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 23:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820Ab1AFW2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 17:28:41 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59880 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab1AFW2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 17:28:40 -0500
Received: (qmail 8682 invoked by uid 111); 6 Jan 2011 22:28:39 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 06 Jan 2011 22:28:39 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jan 2011 17:28:36 -0500
Content-Disposition: inline
In-Reply-To: <1294350606-19530-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164683>

On Thu, Jan 06, 2011 at 01:50:03PM -0800, Junio C Hamano wrote:

> Junio C Hamano (3):
>   diffcore-rename: refactor "too many candidates" logic
>   diffcore-rename: record filepair for rename src
>   diffcore-rename: fall back to -C when -C -C busts the rename limit

I read through the series, and it looks good to me. I didn't do any
testing, though. :)

-Peff
