From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 09:23:08 +0200
Message-ID: <20080619072308.GA12727@diana.vm.bytemark.co.uk>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain> <20080618223821.GJ29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 09:25:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9EVy-0000s1-HX
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 09:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbYFSHYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 03:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756057AbYFSHYF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 03:24:05 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1580 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbYFSHYE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 03:24:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K9EU8-0003Ma-00; Thu, 19 Jun 2008 08:23:08 +0100
Content-Disposition: inline
In-Reply-To: <20080618223821.GJ29404@genesis.frugalware.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85451>

On 2008-06-19 00:38:21 +0200, Miklos Vajna wrote:

> On Wed, Jun 18, 2008 at 03:01:24PM -0700, Jakub Narebski
> <jnareb@gmail.com> wrote:
>
> > As a part of patch series introducing new fast-forward strategies
> > (--ff=3Dnever, --ff=3Donly) there was patch which did merge reducti=
on
> > before selecting merge strategy, by Sverre Hvammen Johansen
> >   "[PATCH 4/5] Head reduction before selecting merge strategy"
> >   http://thread.gmane.org/gmane.comp.version-control.git/80288/focu=
s=3D80335
> > (I'm not sure if the link above is to nevest version of patch
> > series).
>
> Side note: builtin-merge does not have problem with merging 25+ refs
> even in case every ref contains "new" commits.

So how many parents can a commit have, exactly? Is there a hard limit
somewhere, or just a point beyond which some git tools will start
behaving strangely?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
