From: Jeff King <peff@peff.net>
Subject: Re: Status shows untracked directory without any untracked file in it
Date: Fri, 6 Apr 2012 02:14:47 -0400
Message-ID: <20120406061447.GC25301@sigill.intra.peff.net>
References: <CAGAhT3n3hHV+UhT+D1o60OAS23WFmx+Lxg=aqYMGC=U-LR1QUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 08:14:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SG2Rk-0004qr-3S
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 08:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab2DFGOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 02:14:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49680
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab2DFGOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 02:14:51 -0400
Received: (qmail 32108 invoked by uid 107); 6 Apr 2012 06:14:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 02:14:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 02:14:47 -0400
Content-Disposition: inline
In-Reply-To: <CAGAhT3n3hHV+UhT+D1o60OAS23WFmx+Lxg=aqYMGC=U-LR1QUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194849>

On Thu, Apr 05, 2012 at 10:19:00PM -0700, Alexander Kostikov wrote:

> How that is possible? Is it a bug?

Maybe. What git version and what platform are you on? There was a bug in
versions of git earlier than v1.7.8 that showed the symptom you describe
on case-insensitive filesystems. It was fixed by commit 2548183, which
contains more details.

-Peff
