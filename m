From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5 v2] dashed externals: kill children on exit
Date: Sun, 8 Jan 2012 16:07:39 -0500
Message-ID: <20120108210739.GA18311@sigill.intra.peff.net>
References: <7vipkoih0e.fsf@alter.siamese.dyndns.org>
 <1325936567-3136-1-git-send-email-drizzd@aon.at>
 <1325936567-3136-3-git-send-email-drizzd@aon.at>
 <20120107145004.GB2461@sigill.intra.peff.net>
 <7v4nw6hfpy.fsf@alter.siamese.dyndns.org>
 <20120108204109.GA3394@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jan 08 22:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjzxy-0003wi-IC
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 22:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab2AHVHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 16:07:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60433
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383Ab2AHVHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 16:07:41 -0500
Received: (qmail 26601 invoked by uid 107); 8 Jan 2012 21:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Jan 2012 16:14:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jan 2012 16:07:39 -0500
Content-Disposition: inline
In-Reply-To: <20120108204109.GA3394@ecki.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188136>

On Sun, Jan 08, 2012 at 09:41:09PM +0100, Clemens Buchacher wrote:

> What I had previously enabled child cleanup for all callers of
> run_command_v_opt. There is quite a few of those as well, most of them
> not related to dashed externals at all.
> 
> So I reworked that patch a bit to enable cleanup only for dashed
> externals. This is a replacement for "[PATCH 2/5] run-command: kill
> children on exit by default".

Thanks, this looks much closer to what I was expecting.

-Peff
