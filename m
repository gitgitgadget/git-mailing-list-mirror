From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation/tutorial: misc updates
Date: Wed, 03 Jan 2007 08:24:23 -0800
Message-ID: <7vejqcoz7s.fsf@assigned-by-dhcp.cox.net>
References: <sbejar@gmail.com> <87fyastgoo.fsf@gmail.com>
	<200701031350.l03Doulu015800@laptop13.inf.utfsm.cl>
	<8aa486160701030609g22eadf0brf8743dad5701f315@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Jan 03 17:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H28vK-0005vr-Lf
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 17:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbXACQYa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 11:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbXACQY3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 11:24:29 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36091 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbXACQY2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jan 2007 11:24:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103162425.SNTO15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 3 Jan 2007 11:24:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6gPd1W0051kojtg0000000; Wed, 03 Jan 2007 11:23:37 -0500
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <8aa486160701030609g22eadf0brf8743dad5701f315@mail.gmail.com>
	(Santi =?iso-8859-1?Q?B=E9jar's?= message of "Wed, 3 Jan 2007 08:09:02
 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35875>

"Santi B=E9jar" <sbejar@gmail.com> writes:

> On 1/3/07, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
>> Santi B=E9jar <sbejar@gmail.com> wrote:
>> >
>> > -Every commit has at least one "parent" commit, which points to th=
e
>> > -previous state of the project:
>> > +Every commit has at least one "parent" commit (except the first),
>> > +which points to the previous state of the project:
>>
>> And how can it have more than one parent? If you mention it, better =
come
>> clean about merges (can be explained in detail later).
>
> I have not mentined it, I've just added the exception that the
> firt/root commits have zero parents.

Well, it does not matter who originally is at fault ;-).

Let's just do this.

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index f0a5526..0cc234f 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -400,7 +400,7 @@ $ git show HEAD		# the tip of the current branch
 $ git show experimental	# the tip of the "experimental" branch
 -------------------------------------
=20
-Every commit has at least one "parent" commit (except the first),
+Every commit usually has one "parent" commit
 which points to the previous state of the project:
=20
 -------------------------------------

After this paragraph, we say "merge has more than one", so it's
all consistent and presented in the right order.  By the time
the reader starts wondering about the initial commit, we've
shown the use of HEAD^^^^ and HEAD~$n enough that the reader can
experiment on his/her own.
