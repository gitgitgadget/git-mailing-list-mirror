From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 07 May 2010 16:29:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005071626040.14468@xanadu.home>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>
 <cover.1273183206.git.eyvind.bernhardsen@gmail.com>
 <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071529050.14468@xanadu.home>
 <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_jqoGWFB7TiGz7pQXAiaGtg)"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:29:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUAm-0007bs-Bb
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260Ab0EGU3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:29:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:15007 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880Ab0EGU3T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 16:29:19 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L22003NNGWUTFF0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 07 May 2010 16:29:18 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146590>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_jqoGWFB7TiGz7pQXAiaGtg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 7 May 2010, Avery Pennarun wrote:

> On Fri, May 7, 2010 at 3:31 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Fri, 7 May 2010, Linus Torvalds wrote:
> >> Btw, another option might be to start searching ".gitconfig", but only
> >> allow a certain "safe subset" of config options in that. Things that can
> >> really be about the project itself, and not per-user or per-repository.
> >>
> >> And parse it before ~/.gitconfig and .git/config, so that people can
> >> always override it.
> >>
> >> I dunno. Looking at the config options, there really aren't a lot of them
> >> that make sense on a project scale. There's a few, though. Things like
> >>
> >>       core.autocrlf
> >>       i18n.commitEnconfig
> >>
> >> and possibly others..
> >
> > Given that only a subset of gitconfig could make sense to have
> > distributed, I think the file should be named .gitparams to make the
> > distinction clear.
> 
> Since the options it *does* have are exactly the same as .git/config,
> however, naming it .gitconfig makes sense.

Well, I disagree.

> I'd say just print a
> warning when reading options that are going to be ignored for security
> reasons (or because they're not known at all, or whatever).

Or just make it .gitparams (or anything you wish) which is not the same 
as gitconfig. This way it is less likely to get bogus bug reports for 
options that aren't supported.


Nicolas

--Boundary_(ID_jqoGWFB7TiGz7pQXAiaGtg)--
