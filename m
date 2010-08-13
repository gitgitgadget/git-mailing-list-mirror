From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [SOLVED] `git fetch tag NAME' into mirror repo does not update HEAD, what to do?
Date: Fri, 13 Aug 2010 09:03:56 +0200
Message-ID: <201008130903.56375.brian.foster@innova-card.com>
References: <201008120954.27648.brian.foster@innova-card.com> <201008121522.55020.brian.foster@innova-card.com> <4C63F860.2090600@dbservice.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 09:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjoJn-0002LZ-Dq
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 09:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab0HMHEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 03:04:37 -0400
Received: from 6-61.252-81.static-ip.oleane.fr ([81.252.61.6]:59593 "EHLO
	zebulon.innova-card.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752763Ab0HMHEg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 03:04:36 -0400
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 13 Aug 2010 09:04:06 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.28-15-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <4C63F860.2090600@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153463>

On Thursday 12 August 2010 15:34:24 Tomas Carnecky wrote:
> On 8/12/10 3:22 PM, Brian Foster wrote:
> > On Thursday 12 August 2010 14:32:41 Tomas Carnecky wrote:
> >>                                                         When you u=
se
> >> 'git update-ref --no-deref HEAD v2' it will modify HEAD
> >=20
> >  NO, it gets an error [ ... ]
>=20
> Oh the subtleties when working with plumbing:
>    git update-ref --no-deref HEAD v2^{commit}

 Yes, that updates HEAD, leaving SLAVE in the odd state
 of HEAD being v2 and master's head being v1 (which I
 presume is another example of detached head?).

> >[ ... ]
> >  I do_not_ want a detached head!  This has perhaps been
> >  confused by my improperly saying =E2=80=9Cupdate HEAD=E2=80=9D whe=
n I
> >  meant =E2=80=9Cupdate the master branch=E2=80=9D.  [ ... ]
> >                                 Having HEAD continue to
> >  be a symref to refs/heads/master (which, in this case,
> >  is the same commit as v2) is correct.
>=20
> Just make sure your tools and scripts don't break when you reset the
> branch like that (especially when the update is non-fast forward as
> fetch+reset won't warn you when this happens).

 Understood.  And I'm not too worried about that happening,
 albeit the current procedures are perhaps not as robust as
 they could or should be.  Again, thanks for the suggestions
 and help.

cheers!
	-blf-
