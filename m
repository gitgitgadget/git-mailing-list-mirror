From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Ignore file filter
Date: Sat, 14 May 2005 14:21:34 +0200
Message-ID: <20050514122134.GF3905@pasky.ji.cz>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 14:21:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWveC-0006Ys-4v
	for gcvg-git@gmane.org; Sat, 14 May 2005 14:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVENMVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 08:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVENMVi
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 08:21:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54166 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262752AbVENMVf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 08:21:35 -0400
Received: (qmail 1088 invoked by uid 2001); 14 May 2005 12:21:34 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4285B6A8.4080309@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 10:28:24AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> >>#. ${COGITO_LIB}cg-Xlib
> >>_git=${GIT_DIR:-.git}
> >>    
> >>
> >
> >...but it makes no sense anyway I think to reinclude this stuff from a
> >cg-Xfile you are including from other scripts anyway.
> >  
> >
> cg-Xignore isn't included - only called.

Oh yes, I'm stupid.

> it's also just a library program.
> Also I don't think cg-Xlib should be doing arg handling.
> As an include it should provide an arg handling function that the
> scripts call.

I'd prefer the few and scattered users which don't want arg handling to
explicitly set some magic variable before calling cg-Xlib rather than
adding the arg parser function call everywhere else.

> >>	    if [[ $file =~ $patt ]]; then
> >>    
> >>
> >
> >I'm sorry but this is really nothing my bash-2.05.0(1)-release supports.
> >We're already bash-only, but further reducing that to bash3 really won't
> >work. I *might* get convinced to add some bash2+-only feature, but only
> >if you'll be really good at explaining that it makes sense.
> >  
> >
> Ah
> OK
> I don't know how to do that.
> I was actually aiming for glob matching when I came upon this in the
> manpage.

Ok, so what's the outcome? Are you going to stop at this point, or will
you change the scripts so that they use the glob list?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
