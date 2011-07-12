From: Miles Bader <miles@gnu.org>
Subject: Re: [GSoC update] Sequencer for inclusion
Date: Tue, 12 Jul 2011 15:28:34 +0900
Message-ID: <buo1uxwggh9.fsf@dhlpc061.dev.necel.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <20110711171713.GA5963@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWSY-0001Oq-2x
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1GLG2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:28:38 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:62242 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab1GLG2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:28:37 -0400
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LO7000WYJBN0M60@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Tue, 12 Jul 2011 15:28:35 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LO7007UHJBNESC0@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Tue, 12 Jul 2011 15:28:35 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id ABF2E80088; Tue, 12 Jul 2011 15:28:35 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id A4B6380086; Tue,
 12 Jul 2011 15:28:35 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac1.idc.renesas.com with ESMTP id RAC05643; Tue,
 12 Jul 2011 15:28:35 +0900
X-IronPort-AV: E=Sophos;i="4.65,519,1304262000";   d="scan'208";a="36363571"
Received: from unknown (HELO relay31.aps.necel.com) ([10.29.19.54])
 by relmlii1.idc.renesas.com with ESMTP; Tue, 12 Jul 2011 15:28:35 +0900
Received: from relay31.aps.necel.com ([10.29.19.54] [10.29.19.54])
 by relay31.aps.necel.com with ESMTP; Tue, 12 Jul 2011 15:28:35 +0900
Received: from dhlpc061 ([10.114.97.129] [10.114.97.129])
 by relay31.aps.necel.com with ESMTP; Tue, 12 Jul 2011 15:28:35 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id E565B52E22E; Tue,
 12 Jul 2011 15:28:34 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20110711171713.GA5963@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176928>

Jonathan Nieder <jrnieder@gmail.com> writes:
> To be precise, the format used includes
>
> 	strategy-option = patience | renormalize
>
> to represent the effect of "-Xpatience -Xrenormalize".  My only worry
> about that is that the "|" can sound like "or", which would seem
> strange to a user that does not necessarily develop software (so is
> not thinking about bitfields).

How about using "+" instead of "|"...?

I think that would make sense both for bitfield-thinking and
non-bitfield-thinking readers ... :]

-Miles

-- 
Occam's razor split hairs so well, I bought the whole argument!
