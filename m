From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Fri, 31 Aug 2012 17:22:21 +0200
Message-ID: <87mx1b3x3m.fsf@centaur.cmartin.tk>
References: <1346347393-8425-1-git-send-email-cmn@elego.de>
	<1346347393-8425-2-git-send-email-cmn@elego.de>
	<CAN0XMOKar3jdDMfY=rRkcmNy0i0zKMuhBQ=Z4bi=eus_xAFWyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:22:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7T3H-0002Ny-7W
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 17:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab2HaPWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Aug 2012 11:22:22 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:59467 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753666Ab2HaPWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2012 11:22:21 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id 03E17800D4;
	Fri, 31 Aug 2012 17:22:14 +0200 (CEST)
Received: (nullmailer pid 28009 invoked by uid 1000);
	Fri, 31 Aug 2012 15:22:21 -0000
In-Reply-To: <CAN0XMOKar3jdDMfY=rRkcmNy0i0zKMuhBQ=Z4bi=eus_xAFWyA@mail.gmail.com>
	(Ralf Thielow's message of "Thu, 30 Aug 2012 19:51:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204587>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> On Thu, Aug 30, 2012 at 7:23 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.=
de> wrote:
>> behaviour. To work around this, introduce --set-upstream-to which
>> accepts a compulsory argument indicating what the new upstream branc=
h
>> should be and one optinal argument indicating which branch to change=
,
>> defaulting to HEAD.
>>
>
> Could you please also add this new option to the
> "contrib/completion/git-completion.bash"
> script?

If I knew how those things work... Is this enough?

   cmn

--8<--
Subject: [PATCH] completion: add --set-upstream-to and --unset-upstream

---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index ffedce7..4f46357 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -880,6 +880,7 @@ _git_branch ()
 			--color --no-color --verbose --abbrev=3D --no-abbrev
 			--track --no-track --contains --merged --no-merged
 			--set-upstream --edit-description --list
+			--unset-upstream --set-upstream-to=3D
 			"
 		;;
 	*)
--=20
1.7.12.3.g0dd8ef6
