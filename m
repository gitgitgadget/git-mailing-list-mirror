From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Thu, 23 Feb 2012 16:29:29 +0900
Message-ID: <buor4xmj9d2.fsf@dhlpc061.dev.necel.com>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
 <CACsJy8AXH6xm-ShH_HF6RwATFwsYtAZQfcWoB9VpaiCMj6e8vQ@mail.gmail.com>
 <4F43C23C.8070304@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Michael J Gruber <git@drmicha.warpmail.net>,
	j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Feb 23 08:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0T7W-0000cy-GY
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 08:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab2BWH3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 02:29:37 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:52290 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab2BWH3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 02:29:36 -0500
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LZU0045I4TBW450@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Thu, 23 Feb 2012 16:29:35 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LZU00L454TBD060@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Thu, 23 Feb 2012 16:29:35 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 60F0A48082; Thu, 23 Feb 2012 16:29:35 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 600A9480A4; Thu,
 23 Feb 2012 16:29:35 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac4.idc.renesas.com with ESMTP id SAR05315; Thu,
 23 Feb 2012 16:29:35 +0900
X-IronPort-AV: E=Sophos;i="4.73,468,1325430000";   d="scan'208";a="69569527"
Received: from unknown (HELO relay61.aps.necel.com) ([10.29.19.64])
 by relmlii2.idc.renesas.com with ESMTP; Thu, 23 Feb 2012 16:29:35 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.98.89])
	by relay61.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id q1N7TVTn021309;
 Thu, 23 Feb 2012 16:29:31 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 06E3152E1E3; Thu,
 23 Feb 2012 16:29:30 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4F43C23C.8070304@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191331>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:
> I use (or would like to be able to use) the --stat output to select w=
ith
> the mouse and paste into something like
>   emacsclient -n <pathname>
> This would be harder with the grouping, because I'd have to select tw=
o
> parts and paste two times and type a slash. So for me this would be a
> minus.

Of course, git's diffstats often already violate that property (e.g.,
abbreviations and the renaming syntax)...  In cases where such a
grouping syntax avoids information-losing abbreviations, it might even
be an improvement over the current situation (even if the info was
split up, at least it would be there).

If the heuristics were tuned so that the syntax only kicked in for
cases where deep nesting or long names would otherwise make
abbreviations likely, maybe it would be a general improvement.

However, it does seem like the additional inconsistency of
presentation might make diffstats harder to read or more ugly in some
cases...

-miles

--=20
Dawn, n. When men of reason go to bed.
