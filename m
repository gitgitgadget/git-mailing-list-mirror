From: Jeff King <peff@peff.net>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 02:03:53 -0400
Message-ID: <20100410060353.GA4585@coredump.intra.peff.net>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
 <20100410054645.GA17711@progeny.tock>
 <20100410055124.GA17778@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 08:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Tnu-0000yV-5y
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 08:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268Ab0DJGES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 02:04:18 -0400
Received: from peff.net ([208.65.91.99]:36015 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab0DJGER (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 02:04:17 -0400
Received: (qmail 15221 invoked by uid 107); 10 Apr 2010 06:04:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 02:04:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 02:03:53 -0400
Content-Disposition: inline
In-Reply-To: <20100410055124.GA17778@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144515>

On Sat, Apr 10, 2010 at 12:51:24AM -0500, Jonathan Nieder wrote:

> >> If you really want a list of ignored files, I think you are stuck
> >> comparing the output of "git ls-files -o" and "git ls-files -o
> >> --exclude-standard".
> >
> > "git clean -n -d" may help.
> 
> err, "git clean -n -d -X".
> 
> I am also not sure how stable the "Would remove " output format is,
> or how stable we want it to be.  Probably not stable at all, so
> sorry about that.

That's the same information, isn't it? You do "git clean -ndX" to see
_everything_ that is untracked, and "git clean -nd" to see things that
are untracked but not ignored. So I think it is just as painful to use
as ls-files, but as you noted, it is not really plumbing.

-Peff
