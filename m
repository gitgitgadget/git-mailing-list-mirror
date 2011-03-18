From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Q: rebasing (moving) a whole tree (not just one branch)
Date: Fri, 18 Mar 2011 23:53:23 +0100
Message-ID: <201103182353.24517.j6t@kdbg.org>
References: <4D83BB0A.8070307@dirk.my1.cc> <20110318202637.GA23255@elie> <7vaagsw2qb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dirk =?utf-8?q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 23:53:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0iY2-00025b-5n
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 23:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504Ab1CRWxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 18:53:30 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:7788 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752904Ab1CRWx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 18:53:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id DCC512C4002;
	Fri, 18 Mar 2011 23:53:24 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9965319F704;
	Fri, 18 Mar 2011 23:53:24 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7vaagsw2qb.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169377>

On Freitag, 18. M=C3=A4rz 2011, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > Dirk S=C3=BCsserott wrote:
> >> I'd like to rebase a whole tree from A to B. Not just a single
> >> branch, but a whole tree. Let's say I have the following history:
> >>
> >> --- A --- B
> >>
> >>     + -- C -- D
> >>
> >>          + E -- F
> >>
> >> I'd like to rebase C and its descendants from A to B
> >
> > I'd suggest cheating by making a merge of D and F and "rebase -p"-i=
ng
> > that. :)
> >
> > To say something more sensible would probably require more informat=
ion
> > about the particular application, though.
>
> I am not a huge fan of filter-branch, but shouldn't you be able to
> filter-branch D and F (and no other branch) on top of B?

Not in a trival way. You would need a tree-filter that re-applies the c=
hange=20
between A and B to every transcribed commit. That will work well only i=
f=20
there are no conflicts.

-- Hannes
