From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] t9129: fix UTF-8 locale detection
Date: Wed, 19 May 2010 11:44:14 +0900
Message-ID: <87r5l8mwzl.fsf@catnip.gol.com>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
	<4BF2BABC.2010405@drmicha.warpmail.net>
	<1274215074.16337.4.camel@localhost>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Wed May 19 04:44:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEZGn-0005qX-AI
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 04:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab0ESCoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 22:44:23 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:54631 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab0ESCoW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 22:44:22 -0400
Received: from 218.231.149.129.eo.eaccess.ne.jp ([218.231.149.129] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	id 1OEZGZ-0002J4-Cs; Wed, 19 May 2010 11:44:15 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id D19C4DF70; Wed, 19 May 2010 11:44:14 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <1274215074.16337.4.camel@localhost> (Yann Droneaud's message of
	"Tue, 18 May 2010 22:37:54 +0200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147317>

Yann Droneaud <yann@droneaud.fr> writes:
> I've tested on:
>  - FreeBSD 8.0
>  - NetBSD 5.0.1
>  - OpenSolaris 2009.06
>
> and none of these systems report en_US.utf8 in locale -a, they're all
> reporting en_US.UTF-8

Still, "utf8" is common enough, so clearly it should be supported (along
with "utf-8" and "UTF-8" etc).

[On my system::

   $ locale -a
   C
   POSIX
   en_US.utf8
   ja_JP.utf8
   ko_KR
   ko_KR.euckr
   ko_KR.utf8
   korean
   korean.euc
]

-miles

-- 
Idiot, n. A member of a large and powerful tribe whose influence in human
affairs has always been dominant and controlling.
