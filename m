From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Makefile: add missing dependencies on url.h
Date: Sun, 8 Aug 2010 19:00:48 -0400
Message-ID: <20100808230048.GC27206@coredump.intra.peff.net>
References: <20100808211910.GA7210@burratino>
 <20100808212510.GA6962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 01:01:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiErW-0005S4-F9
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 01:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab0HHXA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 19:00:56 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33349 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab0HHXAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 19:00:55 -0400
Received: (qmail 17532 invoked by uid 111); 8 Aug 2010 23:00:53 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Sun, 08 Aug 2010 23:00:53 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Aug 2010 19:00:48 -0400
Content-Disposition: inline
In-Reply-To: <20100808212510.GA6962@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152939>

On Sun, Aug 08, 2010 at 04:25:11PM -0500, Jonathan Nieder wrote:

> v1.7.2-rc0~56^2 and its parent (decode file:// and ssh://
> URLs, 2010-05-23) introduced a new url library.  Update the
> Makefile with the relevant dependencies.
> 
> Detected with "make CHECK_HEADER_DEPENDENCIES=1".

Makes sense to me. Thanks.

-Peff
