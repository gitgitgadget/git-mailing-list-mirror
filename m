From: David Abrahams <dave@boostpro.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 20:39:12 -0400
Message-ID: <78D97574-74AB-4A4D-AEB2-874BFBB4345E@boostpro.com>
References: <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com> <20090423201636.GD3056@coredump.intra.peff.net> <b4087cc50904231345x2613308eh640e50f4a2680890@mail.gmail.com> <B873CD38-2CFE-4138-8A77-8957FA3DB81C@boostpro.com> <20090424141847.GD10761@coredump.intra.peff.net> <91225E09-505A-4CD6-AC8E-FBB500A95984@boostpro.com> <20090424181539.GB11360@coredump.intra.peff.net> <0FC64949-689C-43A4-B656-9618E808962B@boostpro.com> <20090424202403.GB13561@coredump.intra.peff.net> <2B5084A3-9BDB-4463-8530-3C8AB2E09A1F@boostpro.com> <20090424224517.GA10155@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Michael Witten <mfwitten@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVwo-0007dy-8y
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 02:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbZDYAjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Apr 2009 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbZDYAjP
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 20:39:15 -0400
Received: from boost-consulting.com ([206.71.190.141]:52421 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbZDYAjO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 20:39:14 -0400
Received: from [192.168.188.150] (207-172-223-249.c3-0.smr-ubr3.sbo-smr.ma.static.cable.rcn.com [207.172.223.249])
	(Authenticated sender: dave)
	by boost-consulting.com (Postfix) with ESMTPSA id 987121CC1F;
	Fri, 24 Apr 2009 17:36:42 -0700 (PDT)
In-Reply-To: <20090424224517.GA10155@atjola.homenet>
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117531>


On Apr 24, 2009, at 6:45 PM, Bj=F6rn Steinbrink wrote:

>> I think UI/API works way better than porcelain/plumbing. We are, =20
>> after
>> all, programmers.
>
> We are programmers, but not all git users are programmers.

I'm sure you will admit that the vast majority are programmers.  This =20
is about speaking effectively to your primary audience.

>> It would also be good to link to a definition any time you use a ter=
m
>> of art in the docs. I would even do that in the case of UI/API since
>> the distinction could appear to be subtle.
>>
>> I should also say, most of the docs and interfaces I see in Git (and
>> its wrappers, web interfaces, etc.) give the SHA1 hashes way too muc=
h
>> exposure. The times when it's actually more convenient to use a hash
>> instead of one of the other notations are rare,
>
> How often do you need a name for a commit shown by a command and can
> accept that it is not stable?

I can accept it as long as it's stable inside my own repo.  Maybe I =20
need the SHA1 to talk about it wherever it may roam.  I think you =20
could count in the other direction (i.e. from the roots instead of the =
=20
leaves) to get fairly stable symbolic names.

Also, I don't think I need to see the hashes for trees and blobs most =20
of the time.

> I usually need a name because I
> want to reference that commit later on, either because I need to =20
> talk to
> other users, or because I'm working on something and might need to =20
> look
> at that commit now and then, regardless on my current state of things=
=2E
> One big exception in my workflow is when I use "git blame", then I
> usually just need the name once to look at the full commit. But then =
I
> prefer a 7-8 characters long sha-1 prefix to something like
> improve_foo_speed~132^12~1^3. And "pseudo-stable" numbers have been
> discussed to death.

Okay, I "say uncle."

>> and if hashes weren't so exposed I bet most interfaces would make
>> those other names more available. One reason I think hashes retain
>> their prominent exposure is that you have no other reasonably stable
>> way of referring to commits, since branch~NN counts backward from
>> HEAD. Adding such a thing would help.
>
> It counts backwards from "branch".

Right, thanks.

>> Oh, one other specific issue: the rev-parse manpage uses $GIT_DIR
>> without saying what it is. I *think* that means the root of the
>> working copy and has nothing to do with environment variables, but
>> it's hard to be sure, and if I'm right about that, it's misleading
>> notation.
>
> $GIT_DIR means the .git directory of a non-bare repo.


Thanks for clarifying.  But don't neglect to fix the docs so the next =20
guy doesn't have to ask ;-)

BTW, "[non-]bare repo" is yet another Git-specific jargon.  I know =20
what it means... again, only because I asked someone.

--
David Abrahams
BoostPro Computing
http://boostpro.com
