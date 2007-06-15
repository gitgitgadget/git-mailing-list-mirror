From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [CORRECTED PATCH] Introduce file with the common default build-time items.
Date: Fri, 15 Jun 2007 09:40:02 +0400
Message-ID: <20070615054002.GD3779@void.codelabs.ru>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org> <20070614095654.GT86872@void.codelabs.ru> <20070614150929.GA18491@spearce.org> <20070614190739.GA3779@void.codelabs.ru> <20070615032204.GC18491@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 07:40:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz4Xd-0004pa-Au
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 07:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXFOFkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 01:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbXFOFkL
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 01:40:11 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:63900 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbXFOFkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 01:40:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=IdBISlBKFNhaQ0jApIG91hvB4YrjnYBt31ke1mV/Io6oDZ0j/obyy4EgNpyyFO2PJMFFv1bW65PNljba6BZcW0MvrAR/2oHXAOCHTne4V+YMcaMqN31YhLrdmeimI8puc5J8OfghGKKTu4yB+pHRANJeh/wbI6Vi15LEb8Npk7Q=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1Hz4XX-0004IQ-AY; Fri, 15 Jun 2007 09:40:07 +0400
Content-Disposition: inline
In-Reply-To: <20070615032204.GC18491@spearce.org>
X-Spam-Status: No, score=-2.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50242>

Shawn, good da.y

Thu, Jun 14, 2007 at 11:22:04PM -0400, Shawn O. Pearce wrote:
> > OK, it means that git-gui will be totally separated from the
> > git.git?  And one will download it as the separate tarball?
> 
> That's one option.  But Junio and I are also considering keeping
> it inside the git tarball as well, as many users have gotten used
> to it being in the core Git distribution.  I think it all depends
> on if myself (or someone else) adds subproject recursion support
> into git-archive.  ;-)

OK, I just wondered what to expect from the 1.6, since I am
trying to keep FreeBSD port in sync with the latest Git release.
> ...
> >  Makefile             |   17 +++++++++++------
> >  common-make-vars.def |   11 +++++++++++
> >  configure.ac         |    4 +++-
> >  3 files changed, 25 insertions(+), 7 deletions(-)
> >  create mode 100644 common-make-vars.def
> ...
> 
> I dunno.  25 insertions and 7 deletions to reduce two uses of 'wish'
> into one use of 'wish'?  That hardly seems worth the additional
> 18 lines of code.

11 of new lines are common-make-vars.def: it is heavily commented.

> Feels like code churn to me.  And I rarely feel
> code churn.  I'm usually a lot more caviler about changing things
> than Junio, Dscho, Nico, Linus, ...

OK, let us wait for the other's reaction.  May be you're right and
it doesn't worth it.  But I always felt that if I can change something
by changing it only in one place, then it worth it.  Otherwise I
should remember all places where it is used and this leads to errors.
But maybe the 'wish' and 'tclsh' are not worth it.

Thank you!
-- 
Eygene
