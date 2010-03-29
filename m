From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite
 description
Date: Mon, 29 Mar 2010 01:09:15 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003290055000.14365@iabervon.org>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com> <4BAFFFAB.4080808@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 07:09:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw7E1-0006E4-T5
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 07:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab0C2FJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 01:09:17 -0400
Received: from iabervon.org ([66.92.72.58]:59185 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab0C2FJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 01:09:16 -0400
Received: (qmail 9711 invoked by uid 1000); 29 Mar 2010 05:09:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2010 05:09:15 -0000
In-Reply-To: <4BAFFFAB.4080808@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143438>

On Sun, 28 Mar 2010, Gabriel Filion wrote:

> Hello,
> 
> On 2010-03-28 14:03, Ramkumar Ramachandra wrote:
> [...]
> > diff --git a/Documentation/git-remote-helpers.txt
> > b/Documentation/git-remote-helpers.txt
> > index 1b5f61a..1304813 100644
> > --- a/Documentation/git-remote-helpers.txt
> > +++ b/Documentation/git-remote-helpers.txt
> [...]
> > @@ -12,11 +12,31 @@ SYNOPSIS
> [...]
> > +repositories. They implement a subset of the capabilities documented
> > +here, and conform to the "remote helper protocol". When git needs
> > +needs to interact with a repository served by a remote helper, it
> 
> Oops, "needs" is repeated twice here...
> 
> Apart from that, it seems nice and helps to better understand what they
> should be used for.
> 
> It doesn't really concern this patch but If I'm not wrong, there still
> is no documentation written on how exactly git invokes the remote
> helpers. A good description was given previously by Ilari Liusvaara (so
> I've added you, Ilari in the cc list). The description can be seen here:
> 
> http://lists.zerezo.com/git/msg712892.html
> 
> Should we add this information on this man page?

That information ought to be in the documentation, but possibly not on 
this man page in particular. I think it would be better to document that 
part in the documentation of the code and programs that call the helper, 
not in the helper documentation. In general, I'd like the helpers to make 
as few assumptions about their caller as possible, and similarly keep the 
information about the caller out of their documentation.

Also, I think it would be more helpful in general to get that information 
into documentation of the transport and remote code and configuration of 
these things, because users are going to come at this from that side ("I 
want to access an SVN repository, how does that work?") rather than from 
the helper documentation side ("I want to exercise git-remote-svn's export 
support, just to run that code").

	-Daniel
*This .sig left intentionally blank*
