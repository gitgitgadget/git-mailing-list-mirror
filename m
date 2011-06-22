From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all
 untracked files
Date: Wed, 22 Jun 2011 16:47:03 +0900
Message-ID: <buotybi2tqg.fsf@dhlpc061.dev.necel.com>
References: <1308612986-26593-1-git-send-email-david@porkrind.org>
 <20110621003852.GB2050@sigill.intra.peff.net> <4DFFF5AA.4030401@porkrind.org>
 <4E002762.3050803@sohovfx.com> <4E003A0F.5080601@viscovery.net>
 <20110621141843.GA18700@sigill.intra.peff.net> <4E00C2BD.6000903@esperanto.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andrew Wong <andrew.w@sohovfx.com>,
	David Caldwell <david@porkrind.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Ebermann <Paul.Ebermann@esperanto.de>
X-From: git-owner@vger.kernel.org Wed Jun 22 09:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZI9b-0002Yk-BB
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 09:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab1FVHrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 03:47:09 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:41851 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab1FVHrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 03:47:08 -0400
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LN6003DILMIYFE0@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Wed, 22 Jun 2011 16:47:06 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LN60040ZLMI63D0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Wed, 22 Jun 2011 16:47:06 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 3FCA74807B; Wed, 22 Jun 2011 16:47:05 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id D9DF54808E; Wed,
 22 Jun 2011 16:47:05 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac4.idc.renesas.com with ESMTP id SAC25134; Wed,
 22 Jun 2011 16:47:05 +0900
X-IronPort-AV: E=Sophos;i="4.65,404,1304262000";   d="scan'208";a="33319105"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii2.idc.renesas.com with ESMTP; Wed, 22 Jun 2011 16:47:05 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.97.87])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id p5M7l4sw011378;
 Wed, 22 Jun 2011 16:47:04 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id A2F6352E1F6; Wed,
 22 Jun 2011 16:47:03 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4E00C2BD.6000903@esperanto.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176226>

Paul Ebermann <Paul.Ebermann@esperanto.de> writes:
>>   $ git stash --untracked-too --ignored-too
>> 
>> is fairly clear, but somehow strikes me as unnecessarily ugly and
>> verbose.
>
> I think `--also-untracked` sounds better. It is even longer, though.

"--include-untracked" sounds a bit smoother to my ears.

-Miles

-- 
Would you like fries with that?
