From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/3] Documentation/Makefile: move infodir to be with
 other '*dir's
Date: Tue, 12 Feb 2013 21:18:05 +0000
Message-ID: <20130212211804.GI2270@serenity.lan>
References: <cover.1360700102.git.john@keeping.me.uk>
 <dcc4f597f26531b79bd9f097c73f6f186b73c81d.1360700102.git.john@keeping.me.uk>
 <20130212210138.GE12240@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:18:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5NFT-0002FS-KV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759847Ab3BLVSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:18:16 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:35131 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759486Ab3BLVSP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:18:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3C1FB606531;
	Tue, 12 Feb 2013 21:18:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E4+woT8SjVLV; Tue, 12 Feb 2013 21:18:13 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id EC4A460651E;
	Tue, 12 Feb 2013 21:18:07 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130212210138.GE12240@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216204>

On Tue, Feb 12, 2013 at 01:01:38PM -0800, Jonathan Nieder wrote:
> John Keeping wrote:
> 
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> [...]
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -81,6 +81,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
> >  prefix ?= $(HOME)
> >  bindir ?= $(prefix)/bin
> >  htmldir ?= $(prefix)/share/doc/git-doc
> > +infodir ?= $(prefix)/share/info
> >  pdfdir ?= $(prefix)/share/doc/git-doc
> >  mandir ?= $(prefix)/share/man
> >  man1dir = $(mandir)/man1
> > @@ -98,7 +99,6 @@ RM ?= rm -f
> >  MAN_REPO = ../../git-manpages
> >  HTML_REPO = ../../git-htmldocs
> >  
> > -infodir ?= $(prefix)/share/info
> >  MAKEINFO = makeinfo
> 
> Is this another stylefix or is there a functional reason for this
> change?

Another stylefix - this arrangement seems more logical to me and makes
the comment in the next patch simpler.
