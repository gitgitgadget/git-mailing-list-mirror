From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 02/15] const-expr.patch
Date: Sun, 25 Apr 2010 03:38:13 -0500 (CDT)
Message-ID: <20100317060108.GB27121@thor.il.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
 <20100316054306.167331000@mlists.thewrittenword.com>
 <4B9F33DC.3030309@viscovery.net>
 <32541b131003161643g1a1cbf6ck3089ae5fb016a985@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:38:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xM4-0006dG-M5
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab0DYIiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:38:15 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:61374 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:38:14 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 84E7A5CC0
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:59:16 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 84E7A5CC0
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 35B2F9A4
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:38:14 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id EAD5F57C; Sun, 25 Apr 2010 03:38:13 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <32541b131003161643g1a1cbf6ck3089ae5fb016a985@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145725>

[It seems like all my replies to this list don't make it through, even
though I'm able to post a new thread.  Please forward on my behalf.]

On Tue, Mar 16, 2010 at 07:43:54PM -0400, Avery Pennarun wrote:
> On Tue, Mar 16, 2010 at 3:31 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > Gary V. Vaughan schrieb:
> >> Unfortunately, there are still plenty of production systems with
> >> vendor compilers that choke unless all compound declarations can be
> >> determined statically at compile time, for example hpux10.20 (I can
> >> provide a comprehensive list of our supported platforms that exhibit
> >> this problem if necessary).
> >
> > Yes, a comprehensive list would be appreciated. This change is an
> > uglification that I personally would prefer to stay out of the code base
> > unless many consumers of git are hurt.
> >
> > The problem with this non-feature is that it is all too easy that new code
> > introduces new incompatibilities.
> 
> This is probably a stupid question, but why not just build it using
> gcc on systems with a broken vendor compiler?  You don't have to
> distribute gcc just to distribute binaries built with it, so it seems
> like there's no downside... and less suffering for the build
> maintainer.

More often than not the vendor compiler produces better code than gcc
on any given architecture, and one of the features of the TWW package
builds is that in the vast majority of cases we port the upstream code
to build using the vendor compiler, because this is what our customers
want.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
