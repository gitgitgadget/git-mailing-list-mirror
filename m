From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 17:04:42 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909171654500.14907@iabervon.org>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>  <20090917041440.4048.16353.chriscool@tuxfamily.org>  <7vk4zykv7o.fsf@alter.siamese.dyndns.org> <c07716ae0909170525h21ab26f5y84b0fbce2192c69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-471574974-1253221482=:14907"
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 23:04:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoO9q-0000yw-9G
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 23:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbZIQVEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 17:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbZIQVEk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 17:04:40 -0400
Received: from iabervon.org ([66.92.72.58]:33784 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbZIQVEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 17:04:40 -0400
Received: (qmail 20796 invoked by uid 1000); 17 Sep 2009 21:04:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Sep 2009 21:04:42 -0000
In-Reply-To: <c07716ae0909170525h21ab26f5y84b0fbce2192c69@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128771>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-471574974-1253221482=:14907
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 17 Sep 2009, Christian Couder wrote:

> On Thu, Sep 17, 2009 at 7:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> > I'd like to see at least the following rows filled as well.
> >
> >    X      U     A     A   --m-s      ???    ???   ???
> >                           --merge    ???    ???   ???
> >    X      U     B     A   --m-s      ???    ???   ???
> >                           --merge    ???    ???   ???
> >
> >> In this table, A, B and C are some different states of a file.
> >
> > ... and X is "don't care", and U is "unmerged index".
> 
> I will have a look, but it seems to me that --m-s and --merge
> behave the same in these cases.

It's still worth documenting, since it used to be entirely undocumented 
(and probably not what it should have been), and also because you're 
making it something reliable for the first time in this series.

	-Daniel
*This .sig left intentionally blank*
--1547844168-471574974-1253221482=:14907--
