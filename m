From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 13:18:40 -0500
Message-ID: <20111115181840.GA15290@sigill.intra.peff.net>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
 <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch>
 <20111115173715.GA4478@sigill.intra.peff.net>
 <CABPQNSbu9bb5UG1ihi2vGX5ZkpvjfjaXrT8bhDGZHb=n9RbjSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 19:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQNap-0002zg-Lw
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 19:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757113Ab1KOSSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 13:18:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42731
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757099Ab1KOSSm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 13:18:42 -0500
Received: (qmail 8925 invoked by uid 107); 15 Nov 2011 18:18:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Nov 2011 13:18:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:18:40 -0500
Content-Disposition: inline
In-Reply-To: <CABPQNSbu9bb5UG1ihi2vGX5ZkpvjfjaXrT8bhDGZHb=n9RbjSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185478>

On Tue, Nov 15, 2011 at 06:44:38PM +0100, Erik Faye-Lund wrote:

> > I think the code would be more readable if it just used the new
> > argv_array.
> >
> Oooh, nice. The whole argv_array slipped past me, I like it!

I don't think it existed when you started on this series. :)

-Peff
