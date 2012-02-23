From: Jeff King <peff@peff.net>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 14:34:51 -0500
Message-ID: <20120223193451.GB30132@sigill.intra.peff.net>
References: <4F46036F.3040406@gmail.com>
 <20120223102426.GB2912@sigill.intra.peff.net>
 <4F462E61.4020203@gmail.com>
 <m34nuhelnf.fsf@localhost.localdomain>
 <4F4643BB.8090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nikolaj Shurkaev <snnicky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 20:35:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0eRO-0007Lk-Fm
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 20:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791Ab2BWTey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 14:34:54 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48947
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755746Ab2BWTex (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 14:34:53 -0500
Received: (qmail 13756 invoked by uid 107); 23 Feb 2012 19:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Feb 2012 14:34:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2012 14:34:51 -0500
Content-Disposition: inline
In-Reply-To: <4F4643BB.8090001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191388>

On Thu, Feb 23, 2012 at 04:48:43PM +0300, Nikolaj Shurkaev wrote:

> For example there are commits that affect not only files in folder A
> but files in folder B, C and so on.  If I do format-patch that will
> give me nice patches, but there are modifications of folders B, C and
> so on there.  I do not know a way to generate patches via format-patch
> that affect only files in folder A.

Doesn't:

  git format-patch HEAD~3..HEAD SomePath

do what you want? It is certainly designed to, and it seems to work for
me.

-Peff
