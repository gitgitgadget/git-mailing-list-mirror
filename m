From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [TopGit RFC PATCH] tg mail: new command for mailing patches
Date: Fri, 19 Sep 2008 14:23:55 +0400
Organization: St.Petersburg State University
Message-ID: <20080919102355.GG4423@roro3>
References: <1221815301-25090-1-git-send-email-kirr@landau.phys.spbu.ru> <36ca99e90809190252q45f01eb2xd02b62b88f0cf3a9@mail.gmail.com> <20080919100441.GF4423@roro3> <36ca99e90809190320l4765e50eqe38bf1d2672cfcca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 12:33:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgdIh-0001is-Ar
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 12:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbYISKcP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 06:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbYISKcO
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 06:32:14 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:52279 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbYISKcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 06:32:14 -0400
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgdOB-0000io-Uj; Fri, 19 Sep 2008 12:39:04 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1Kgd9X-0000w7-RM; Fri, 19 Sep 2008 14:23:55 +0400
Content-Disposition: inline
In-Reply-To: <36ca99e90809190320l4765e50eqe38bf1d2672cfcca@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96276>

On Fri, Sep 19, 2008 at 12:20:49PM +0200, Bert Wesarg wrote:
> On Fri, Sep 19, 2008 at 12:04, Kirill Smelkov <kirr@landau.phys.spbu.=
ru> wrote:
> > On Fri, Sep 19, 2008 at 11:52:03AM +0200, Bert Wesarg wrote:
> >> On Fri, Sep 19, 2008 at 11:08, Kirill Smelkov <kirr@landau.phys.sp=
bu.ru> wrote:
> >> > Petr, since you've asked for help on this, here you are:
> >> >
> >> >    $ tg mail [NAME]
> >> >
> >> > a simple script to send one patch over email.
> >> >
> >> >
> >> > All it does is
> >> >
> >> >    - call `tg patch` for actual patch preparation
> >> >    - extract email addresses from whom and where to send a mail
> >> That shouldn't be needed. git send-email parses Cc: headers and th=
e
> >
> > Exactly for this reason I do not extract Cc. And git send-mail does=
 not
> > extract From: -- it just asks to confirm From is GIT_COMMITTER_IDEN=
T,
> > and there is no option to stop it doing so except providing explici=
t
> > --from <someone> (maybe i'm missing something?).
> Ahh, my fault, I should take a break, sorry for the noise.

No problem, your "noise" is welcome :)

--=20
    =D0=92=D1=81=D0=B5=D0=B3=D0=BE =D1=85=D0=BE=D1=80=D0=BE=D1=88=D0=B5=
=D0=B3=D0=BE, =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB.
