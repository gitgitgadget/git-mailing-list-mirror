From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH v3 3/8] mingw: make failures to unlink or move
	raise a question
Date: Wed, 15 Dec 2010 08:28:04 +0100
Message-ID: <20101215072803.GA14646@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <20101214222122.GD4084@sandbox> <AANLkTi=cHb2kV2MaYu72nXVOksO7O9HhJLEo-fU0sV5N@mail.gmail.com> <alpine.DEB.1.00.1012150109340.1461@bonsai2> <7v1v5jrb1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Albert Dvornik <dvornik+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 08:28:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSlmX-0006nH-Jk
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 08:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab0LOH2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Dec 2010 02:28:07 -0500
Received: from darksea.de ([83.133.111.250]:60416 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752380Ab0LOH2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 02:28:06 -0500
Received: (qmail 25969 invoked from network); 15 Dec 2010 08:28:03 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 15 Dec 2010 08:28:03 +0100
Content-Disposition: inline
In-Reply-To: <7v1v5jrb1f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163737>

On Tue, Dec 14, 2010 at 07:05:00PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > @@ -129,6 +130,78 @@ static inline int is_file_in_use_error(DWORD errcode)
> >> >        return 0;
> >> >  }
> >> >
> >> > +static int read_yes_no_answer()
> >> 
> >> Perhaps "static int read_yes_no_answer(void)" for portability?
> >
> > LOL. This file is called compat/mingw.c... :-)
> 
> I had the same reaction.  Maybe MinGW will get a different compiler
> someday ;-)
> 
> > But I have no objection to stay with the convention of the rest of Git. 
> > Nobody needs to convince me that consistency is good.
> 
> I recall there are a few old-style declaration in compat/ directory,
> especially in borrowed code like nedmalloc/ and possibly regex/, and
> I am not so sure if we want to touch them.
> 
> I'll leave this up to msysgit folks.

I do not mind changing this sincce I need to change this patch anyway.
Will do in the next iteration.

Cheers Heiko
