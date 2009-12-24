From: Jeff King <peff@peff.net>
Subject: Re: git tag --contains <commit> -n=1 ?
Date: Thu, 24 Dec 2009 00:52:58 -0500
Message-ID: <20091224055257.GA419@sigill.intra.peff.net>
References: <4B324327.5010809@gmail.com>
 <m2fx71pq0p.fsf@whitebox.home>
 <4B327F8F.2060106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "NODA, Kai" <nodakai@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 24 06:53:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNgdQ-000344-8q
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 06:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbZLXFxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 00:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbZLXFxE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 00:53:04 -0500
Received: from peff.net ([208.65.91.99]:36217 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbZLXFxB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 00:53:01 -0500
Received: (qmail 21401 invoked by uid 107); 24 Dec 2009 05:57:39 -0000
Received: from c-71-206-170-120.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.170.120)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Dec 2009 00:57:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Dec 2009 00:52:58 -0500
Content-Disposition: inline
In-Reply-To: <4B327F8F.2060106@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135640>

On Thu, Dec 24, 2009 at 05:37:35AM +0900, NODA, Kai wrote:

> >Since the output of git tag is sorted by name, generally not.
> 
> Wow, I didn't know that.
> But then, under the assumption that tags have names like verNNN,
> that behavior ensures me that "head -1" works as intended.

If that assumption does not hold, you can also sort by date. See:

  http://article.gmane.org/gmane.comp.version-control.git/133586

-Peff
