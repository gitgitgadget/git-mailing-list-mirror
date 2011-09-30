From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] port upload-archive to Windows
Date: Fri, 30 Sep 2011 06:46:27 -0400
Message-ID: <20110930104627.GC24507@sigill.intra.peff.net>
References: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, j6t@kdbg.org, gitster@pobox.com,
	rene.scharfe@lsrfire.ath.cx
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 12:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9aby-0005zc-Ea
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 12:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174Ab1I3Kqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 06:46:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50228
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847Ab1I3Kq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 06:46:29 -0400
Received: (qmail 451 invoked by uid 107); 30 Sep 2011 10:51:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Sep 2011 06:51:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2011 06:46:27 -0400
Content-Disposition: inline
In-Reply-To: <1317329963-6656-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182476>

On Thu, Sep 29, 2011 at 10:59:19PM +0200, Erik Faye-Lund wrote:

> It's been a while, but here's another updated version of this
> series.
> 
> The only change since last time is that the series has been made
> compatible with Peff's "when remote, disable some features"
> changes.
> 
> Erik Faye-Lund (4):
>   compat/win32/sys/poll.c: upgrade from upstream
>   mingw: fix compilation of poll-emulation
>   enter_repo: do not modify input
>   upload-archive: use start_command instead of fork

Thanks. I can't comment on the earlier patches, but 4/4 looks sane to
me.

-Peff
