From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the
 meta-pacakge to git-all.
Date: Sat, 16 Feb 2008 00:45:00 -0800
Message-ID: <7vskztb88j.fsf@gitster.siamese.dyndns.org>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 09:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQIgV-0000md-DY
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 09:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYBPIpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 03:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbYBPIpR
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 03:45:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbYBPIpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Feb 2008 03:45:15 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 13D7527A2;
	Sat, 16 Feb 2008 03:45:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 10A3227A1; Sat, 16 Feb 2008 03:45:09 -0500 (EST)
In-Reply-To: <1203100163-17509-1-git-send-email-krh@redhat.com> (Kristian
 =?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 15 Feb 2008 13:29:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74032>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> ---
>
> So here's change to fix my favorite annoyance with the git rpm
> packaging: don't pull in tla when I say yum install git!  The decisio=
n
> to make 'git' a metapackage is to say the least unconventional and
> continues to surprise people (here's today discussion:
> http://marc.info/?t=3D120309228600004&r=3D1&w=3D2).
>
> I know it's late and most people who use the git rpms are used to ins=
talling
> git-core by now, but myself and most of my Red Hat co-workers (who sh=
ould
> know a thing or two about rpm packaging) have been fooled by the 'git=
'
> rpm that pulls in everything.  There's really no precendence for this=
, quite
> the opposite: you wouldn't expect yum install gcc to pull in fortran,=
 right?
>
> The patch below only affects people who know that 'git' is a metapack=
age
> and actually use that to pull in everything (but who does?).  The pat=
ch
> renames the 'git-core' rpm to just 'git', but adds a 'Provides: git-c=
ore'
> there so people who have trained themselves to say yum install git-co=
re
> wont get burned.

Why all of these good information is below the three-dash lines
and without Sign-off?

The spec file I ship in git.git was written by somebody else for
Linus a long time ago, augmented with patches from others over
time, and I freely admit that I am RPM challenged.  I do not
exactly know what I have been shipping, and I do not personally
manage an RPM based system.  Having no way of testing any
changes myself makes me first go hide whenever I see a patch to
the spec file and then re-approach the patch slowly, prodding
with ten-foot pole.  The only thing that is saving the world
from disaster is that Distro people tend to have and do use
their own spec file, not mine ;-)

So I am more than Ok with a patch like this from somebody whose
RPM skills and common sense I can trust.

I have to wonder where the git-p4 obsoletion went, though.
