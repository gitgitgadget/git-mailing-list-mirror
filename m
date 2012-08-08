From: Jeff King <peff@peff.net>
Subject: Re: fast-import error: fatal: 'refs/heads/master' - not a valid ref
Date: Wed, 8 Aug 2012 13:54:33 -0400
Message-ID: <20120808175433.GA12772@sigill.intra.peff.net>
References: <CAHSUVA5y1nZG69JbvC-wbmHhjyBGLx8Z2TM3htEyuCsWj=A+aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrey Pavlenko <andrey.a.pavlenko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 19:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzAT2-0008Hh-Iq
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 19:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab2HHRyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 13:54:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57489 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759061Ab2HHRyn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 13:54:43 -0400
Received: (qmail 9014 invoked by uid 107); 8 Aug 2012 17:54:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Aug 2012 13:54:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Aug 2012 13:54:33 -0400
Content-Disposition: inline
In-Reply-To: <CAHSUVA5y1nZG69JbvC-wbmHhjyBGLx8Z2TM3htEyuCsWj=A+aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203105>

On Wed, Aug 08, 2012 at 11:25:02AM +0400, Andrey Pavlenko wrote:

> I'm developing a remote helper which uses the fast-import stream for
> fetching. When I perform cloning git prints error message - "fatal:
> 'refs/heads/master' - not a valid ref", however the clonning completes
> normally. Each my fast-import commit command starts with "commit
> refs/heads/master" header.
> 
> What does this error message mean and how can I fix it?

What version of git are you using? The only command which produces that
exact message is "git show-ref", and it is not called by current
versions of the cloning process (but it used to be in old versions).

-Peff
