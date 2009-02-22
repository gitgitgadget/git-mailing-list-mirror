From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Is this a git-bisect bug?
Date: Sun, 22 Feb 2009 07:47:29 +0100
Message-ID: <200902220747.29932.chriscool@tuxfamily.org>
References: <gnpccl$l69$1@ger.gmane.org> <87skm7em72.fsf@iki.fi> <gnppph$r8r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 07:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb89u-0002z4-4T
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 07:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbZBVGsP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 01:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbZBVGsP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 01:48:15 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:44910 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbZBVGsO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 01:48:14 -0500
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 1C7DBD480B9;
	Sun, 22 Feb 2009 07:48:07 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E5B28D4808C;
	Sun, 22 Feb 2009 07:48:04 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <gnppph$r8r$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110992>

Le samedi 21 f=E9vrier 2009, walt a =E9crit :
> Teemu Likonen wrote:
> > On 2009-02-21 09:07 (-0800), walt wrote:
> >> I'm using the current git.git to bisect a bug in Linus.git.
> >>
> >> I got this far and then ran into trouble:
> >> good 2.6.29-rc5-00094-gc951aa6
> >> bad  2.6.29-rc5-00112-g3501033
> >>
> >> A glance at git log will show that those two commits were
> >> both from Feb 17 with only one other commit between them.
> >>
> >> So, why does this happen?:
> >>
> >> $git bisect start 3501033 c951aa6
> >> Bisecting: 8 revisions left to test after this
> >> be716615fe596ee117292dc615e95f707fb67fd1] x86, vm86: fix preemptio=
n
> >> bug
> >
> > Someone will probably give real explanation but non-linear developm=
ent
> > is part of it:
> >
> > $ git log --graph --pretty=3Doneline --abbrev-commit c951aa6..35010=
33
> >
> > *   3501033 Merge branch 'x86-fixes-for-linus' of git:// [...]
> >
> > |\
> > | * be71661 x86, vm86: fix preemption bug
>  >
>  > ...
>
> I see now that git bisect actually found the guilty commit for me,
> but completely confused me by turning out five kernels in a row
> with the names 2.6.29-rc3-00nnn while I was bisecting an rc5 kernel.
> I stopped because of those tag names when I should have just forged
> ahead.
>
> I would be interested to hear opinions on whether that rc3 tag is
> the correct one to use for the bisected kernels.

Please have a look at this:

http://thread.gmane.org/gmane.comp.version-control.git/99967/focus=3D99=
977

Regards,
Christian.
