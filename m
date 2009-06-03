From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/4] make it possible to skip away from broken commits
Date: Wed, 3 Jun 2009 08:29:48 +0200
Message-ID: <200906030829.48470.chriscool@tuxfamily.org>
References: <20090602200731.3630.33652.chriscool@tuxfamily.org> <7vmy8qe4ru.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBjz6-0002d5-84
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 08:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbZFCG3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 02:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbZFCG3w
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 02:29:52 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:44111 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbZFCG3v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 02:29:51 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 0CD234B00DD;
	Wed,  3 Jun 2009 08:29:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B08AC4B013A;
	Wed,  3 Jun 2009 08:29:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vmy8qe4ru.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120584>

Le Tuesday 02 June 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This patch series adds a "--ratio=3Dx/y" option to "git bisect skip=
" so
> > that it is possible to skip away from an area were the commits cann=
ot
> > be tested.
> >
> > Note that in this series "--ratio=3D4" means the same as "--ratio=3D=
1/4".
> > But I am not sure if this shortcut is worth it.
>
> Actually my gut feeling is that a tweakable knob itself is worth it,
> because the user can never tell what the right value should be.

You mean a boolean configuration variable like "bisect.skip_away" or=20
a "--skip_away" switch to "git bisect start" or both?

> Especially without any documentation updates that explains what this
> ratio refers to ;-), but I suspect, unless the user is very familiar =
with
> how the revision graph bisection internally works, such an explanatio=
n
> would not help him find a skip ratio that is closer to the optimum th=
an a
> random guess.  Why not use a constant ratio (or perhaps a pair of
> alternating ratios) on "bisect skip" without any new options?

Ok, I will have a look at that too.

Thanks,
Christian.
