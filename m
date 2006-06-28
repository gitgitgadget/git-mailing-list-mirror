From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] Makefile: set USE_PIC on Linux x86_64 for linking with Git.pm
Date: Wed, 28 Jun 2006 21:08:14 +0200
Message-ID: <20060628190814.GC5713@fiberbit.xs4all.nl>
References: <20060628183557.GA5713@fiberbit.xs4all.nl> <7vr719159v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 21:08:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvfOj-0003iJ-D8
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 21:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWF1TIS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 15:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWF1TIS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 15:08:18 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:11170 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1750762AbWF1TIS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 15:08:18 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.62)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1FvfOY-0001X8-4A; Wed, 28 Jun 2006 21:08:14 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr719159v.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22819>

On Wednesday June 28th 2006 Junio C Hamano wrote:

> I agree with it in principle but was too lazy to do that myself.
> I wonder it should be inside Linux, though.
> 
> >  ifeq ($(uname_S),Linux)
> >  	NO_STRLCPY = YesPlease
> > +	ifneq (,$(findstring x86_64,$(uname_M)))
> > +		USE_PIC = YesPlease
> > +	endif
> >  endif

Yes, I wondered about that myself. I chose to be on the safe side: I
can and have tested this myself on Linux x86-64 but am not sure if it's
needed on the BSD's for example.

Even for Linux someone mentioned that probably i386 is the exception in
_not_ needing the -fPIC linkage. It might even be specific to the Perl
"xs" implementation specifics?

So I should have added "Works for me (TM)"! ;-)
-- 
Marco Roeland
