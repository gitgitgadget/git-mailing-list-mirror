From: Miles Bader <miles@gnu.org>
Subject: Re: I suggest that git commit support -A option,
 just like hg does.thanks.
Date: Mon, 08 Aug 2011 13:33:39 +0900
Message-ID: <buoy5z4ed3w.fsf@dhlpc061.dev.necel.com>
References: <20110806150246.GA20650@jpl.local>
 <35a2b515.12f42.1319f82c79d.Coremail.sinojelly@163.com>
 <4d88745.134ea.1319fe29f01.Coremail.sinojelly@163.com>
 <1312659297-sup-2956@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 08 06:33:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqHXH-0002vS-6I
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 06:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab1HHEdn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 00:33:43 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:41688 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab1HHEdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 00:33:43 -0400
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LPL00A5KE05VH30@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Mon, 08 Aug 2011 13:33:41 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LPL003SRE05CJ00@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Mon, 08 Aug 2011 13:33:41 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 63E0748087; Mon, 08 Aug 2011 13:33:41 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 51E5E4807B; Mon,
 08 Aug 2011 13:33:41 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id PAC23632; Mon,
 08 Aug 2011 13:33:41 +0900
X-IronPort-AV: E=Sophos;i="4.67,335,1309705200";   d="scan'208";a="40385161"
Received: from unknown (HELO relay21.aps.necel.com) ([10.29.19.50])
 by relmlii1.idc.renesas.com with ESMTP; Mon, 08 Aug 2011 13:33:41 +0900
Received: from relay21.aps.necel.com ([10.29.19.50] [10.29.19.50])
 by relay21.aps.necel.com with ESMTP; Mon, 08 Aug 2011 13:33:41 +0900
Received: from dhlpc061 ([10.114.97.87] [10.114.97.87])
 by relay21.aps.necel.com with ESMTP; Mon, 08 Aug 2011 13:33:41 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 8D57B52E238; Mon,
 08 Aug 2011 13:33:40 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <1312659297-sup-2956@nixos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178937>

Marc Weber <marco-oweber@gmx.de> writes:
>> I don't want to run "git add -A" before commit,=C2=A0
>> I want to use "git commit -A -m 'msg' " instead.
>
> if you need it that often add to your .bashrc:
> gcA(){ git add -A && git commit -m "$@"; }
>
> which is even faster.

Remember:  "just add an alias!" is an acceptable answer only if the
desired feature is odd/unusual.  For desired features that are likely
to be generally useful, git should do the right thing, out of the box,
for everybody.

Which case this particular request falls into, is a matter of
judgement, but such a feature looks "generally useful" to me.

The annoying thing, of course, is that commit and add already have
inconsistent long options for this type of functionality (commit --all
vs add --all). [I'd consider that a bug, regardless of whether commit
gets -A type functionality, but I suppose it's too late to fix...]

-Miles

--=20
Absurdity, n. A statement or belief manifestly inconsistent with one's =
own
opinion.
