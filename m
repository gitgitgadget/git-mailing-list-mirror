From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
 everything up-to-date
Date: Wed, 20 Aug 2008 18:25:03 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808201808400.19665@iabervon.org>
References: <1219263969579-736663.post@n2.nabble.com>  <8585F10E-C33C-481E-B044-A7125F3316F2@web.de>  <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com>  <7vbpznpeup.fsf@gitster.siamese.dyndns.org>
 <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1232006117-1219270337=:19665"
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>,
	ir0s <imirene@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:26:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVw83-0007sM-AX
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbYHTWZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYHTWZH
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:25:07 -0400
Received: from iabervon.org ([66.92.72.58]:57848 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062AbYHTWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:25:06 -0400
Received: (qmail 12809 invoked by uid 1000); 20 Aug 2008 22:25:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Aug 2008 22:25:03 -0000
In-Reply-To: <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Content-ID: <alpine.LNX.1.00.0808201812360.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93065>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1232006117-1219270337=:19665
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.1.00.0808201812361.19665@iabervon.org>

On Wed, 20 Aug 2008, Avery Pennarun wrote:

> On Wed, Aug 20, 2008 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > "Avery Pennarun" <apenwarr@gmail.com> writes:
> >
> >> On Wed, Aug 20, 2008 at 4:40 PM, Andreas Färber <andreas.faerber@web.de> wrote:
> >>> You need to name the local branch, not the remote one:
> >>>
> >>> $ git push origin mybranch
> >>>
> >>> It should then push to remotebranch.
> >>
> >> Not only that, but the "ahead of tracked branch" message depends on
> >> your local copy of the remote branch, not the remote copy of the
> >> remote branch.
> >
> > I think we have long been doing so.  Daniel, correct me.
> 
> ...and I'm dumb.
> 
> I apologize.  "git pull origin mybranch" does not update
> origin/mybranch.  "git push origin mybranch" does.
> 
> It could be argued that pull should update the local reference too,
> but that's irrelevant at the moment.

That is actually to say that fetch should do it (pull calls fetch for that 
part), and I agree with that, assuming you've actually got that fetch 
config, of course.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1232006117-1219270337=:19665--
