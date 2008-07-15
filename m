From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Increased maintainer work during Summer of Code
Date: Tue, 15 Jul 2008 08:52:37 -0700
Message-ID: <7vr69v16wq.fsf@gitster.siamese.dyndns.org>
References: <20080715060427.GB3337@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J.H." <warthog19@eaglescrag.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:54:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImql-0005hS-4o
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbYGOPwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 11:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbYGOPwv
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:52:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbYGOPwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jul 2008 11:52:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 16B992D6F6;
	Tue, 15 Jul 2008 11:52:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8FFE52D6ED; Tue, 15 Jul 2008 11:52:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 131E4662-5286-11DD-8D89-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88575>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio, I know you have been working extra hard lately with the
> merge of builtin merge, and now gitweb and the sequencer are also
> being looked at in much greater detail.

I do not currently perceive much problem.  If they are being looked at =
in
much greater detail, that is good.

> What can we do to smooth out this workload better?  Its awesome
> that we were so fortunate to get these great students this year,
> and have so much contributed in so little time, but we also do
> not want to see maintainer burn-out.  We also want to avoid a
> huge backlog of patches.

=46or GSoC participants, it might be of utmost importance that their pa=
tches
are looked at, reviewed and integrated.  To me, there is no reason to g=
ive
any preferential treatment for GSoC students.  Students may need to lea=
rn
how to cope with busy, overloaded, and/or grumpy maintainer. It is a
necessary skill to work effectively in an open source project they need=
 to
acquire.

When there are more urgent issues than their projects, patches from GSo=
C
students may drop through the crack in the floor just like any other
submitters', and more importantly, the urgency is determined solely by
judging how important the issue is for git.git project, not GSoC.  Usua=
lly
when patches are dropped, its the original submitters job to remind,
resend, or make it easier for the maintainer to take any corrective
measure (e.g. host her own tree to be pulled from) --- GSoC students
should learn to do the same, and their mentors would help them with thi=
s.

The community has matured to the point that there are a few areas with
trustworthy area experts, and I do not have to look at certain patches
very deeply myself.  To name only a few, I just apply patches to git-sv=
n
that are either from Eric or acked by him without looking at them (I ma=
y
spot obvious typos by accident and fix them up, though); patches to
"archive" from Ren=C3=A9 are the same way.

People can help widen areas that are covered like so.  I admit that I a=
m
hesitant to let go of certain areas, e.g. sha1_file.c layer, even thoug=
h I
know Nico and you are as competent and knowledgeable in that area as I =
am
if not more, simply because such a very core part of the system really
matters.  I expect there will always be areas in which I have to look a=
t
all changes for my own peace of mind, but even in these areas I do not
have to be the only person to look at and review the patches.
