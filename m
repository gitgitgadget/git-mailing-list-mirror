From: Jeff King <peff@peff.net>
Subject: Re: [BUG] assertion failure in builtin-mv.c with "git mv -k"
Date: Wed, 14 Jan 2009 11:47:43 -0500
Message-ID: <20090114164742.GA15758@coredump.intra.peff.net>
References: <vpqwscy81o8.fsf@bauges.imag.fr> <496DFC75.2000904@drmicha.warpmail.net> <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de> <496E0D1C.20807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN8vT-00081r-Li
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764529AbZANQrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764514AbZANQrq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:47:46 -0500
Received: from peff.net ([208.65.91.99]:46937 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764498AbZANQrp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 11:47:45 -0500
Received: (qmail 1777 invoked by uid 107); 14 Jan 2009 16:47:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Jan 2009 11:47:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2009 11:47:43 -0500
Content-Disposition: inline
In-Reply-To: <496E0D1C.20807@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105656>

On Wed, Jan 14, 2009 at 05:04:44PM +0100, Michael J Gruber wrote:

> It was a lame attempt at getting around it, it's just one line... I
> didn't know I've been being noticed long enough ;)
> So, should I prepare a series like:
> 
> 1: test case and mark known fail
> 2: the 1 line fix
> 3: mark test pass
> 
> Or should 2+3 be squashed into one?

Definitely the fix and marking the test as passing should be one patch,
since then you see that it is the fix which causes the test to pass. But
really, for a simple fix I usually just squash it all into a single
patch. Then somebody looking at the patch later says "Oh, this is what
was broken, and here is how it was fixed."

-Peff
