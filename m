From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Sat, 01 Sep 2012 17:13:10 +0200
Message-ID: <87pq65hj3t.fsf@centaur.cmartin.tk>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
	<1346347393-8425-2-git-send-email-cmn@elego.de>
	<CAN0XMOKar3jdDMfY=rRkcmNy0i0zKMuhBQ=Z4bi=eus_xAFWyA@mail.gmail.com>
	<87mx1b3x3m.fsf@centaur.cmartin.tk>
	<CAN0XMOK1_JqMuAkW-XzGfkn8pkTUqt879-+E0cGBn79GzEXWkQ@mail.gmail.com>
	<7vy5kvng2t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 17:14:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7pOe-0003to-5Q
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 17:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436Ab2IAPNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Sep 2012 11:13:20 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:60509 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab2IAPNT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2012 11:13:19 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id D53A4805D3;
	Sat,  1 Sep 2012 17:13:13 +0200 (CEST)
Received: (nullmailer pid 11806 invoked by uid 1000);
	Sat, 01 Sep 2012 15:13:13 -0000
In-Reply-To: <7vy5kvng2t.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 31 Aug 2012 10:09:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204633>

Junio C Hamano <gitster@pobox.com> writes:

> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> On Fri, Aug 31, 2012 at 5:22 PM, Carlos Mart=C3=ADn Nieto <cmn@elego=
=2Ede> wrote:
>>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>>
>>>> On Thu, Aug 30, 2012 at 7:23 PM, Carlos Mart=C3=ADn Nieto <cmn@ele=
go.de> wrote:
>>>>> behaviour. To work around this, introduce --set-upstream-to which
>>>>> accepts a compulsory argument indicating what the new upstream br=
anch
>>>>> should be and one optinal argument indicating which branch to cha=
nge,
>>>>> defaulting to HEAD.
>>>>>
>>>>
>>>> Could you please also add this new option to the
>>>> "contrib/completion/git-completion.bash"
>>>> script?
>>>
>>> If I knew how those things work... Is this enough?
>>>
>>
>> Yes, Thanks.
>
> While you are at it, perhaps you may want to unadvertise --set-upstre=
am?
>

Yeah, that'd be good.

   cmn

--8<--
Subject: [PATCH] completion: add --set-upstream-to and --unset-upstream

Remove --set-upstream as it's deprecated now.
---
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ffedce7..4a4d30a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -879,7 +879,8 @@ _git_branch ()
 		__gitcomp "
 			--color --no-color --verbose --abbrev=3D --no-abbrev
 			--track --no-track --contains --merged --no-merged
-			--set-upstream --edit-description --list
+			--set-upstream-to=3D --edit-description --list
+			--unset-upstream
 			"
 		;;
 	*)
--=20
1.7.12.3.g0dd8ef6
