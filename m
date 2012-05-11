From: Jeff King <peff@peff.net>
Subject: Re: XSS in search form at git-scm.com
Date: Fri, 11 May 2012 17:51:33 -0400
Message-ID: <20120511215133.GA20371@sigill.intra.peff.net>
References: <CANurz1edia5ctzRn9b=H-VZX6o=bmEiS2WMbqyQTXN0VrhYtcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anton <forshr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 23:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSxkS-0005tP-VW
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 23:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251Ab2EKVvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 17:51:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40305
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758710Ab2EKVvg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 17:51:36 -0400
Received: (qmail 15468 invoked by uid 107); 11 May 2012 21:51:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 May 2012 17:51:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2012 17:51:33 -0400
Content-Disposition: inline
In-Reply-To: <CANurz1edia5ctzRn9b=H-VZX6o=bmEiS2WMbqyQTXN0VrhYtcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197699>

On Fri, May 11, 2012 at 04:28:39PM +0400, Anton wrote:

> Search form at git-scm.com is vulnerable to XSS.

Thanks, this is a known issue and has just been fixed:

  https://github.com/github/gitscm-next/issues/45

-Peff
