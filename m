From: Miles Bader <miles@gnu.org>
Subject: Re: Git global usage and tests
Date: Tue, 31 May 2011 14:12:47 +0900
Message-ID: <buor57f78s0.fsf@dhlpc061.dev.necel.com>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
 <20110530153620.GA24431@sigill.intra.peff.net>
 <B369AA28-DEF2-48F3-8E4E-F387E8A57D26@gmail.com>
 <20110530161230.GA25291@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Romain Geissler <romain.geissler@gmail.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 07:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRHGC-0003aO-2h
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 07:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab1EaFMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 01:12:50 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:37291 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab1EaFMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 01:12:50 -0400
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LM1009XDNTCI200@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Tue, 31 May 2011 14:12:48 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LM100D9ONTC28A0@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Tue, 31 May 2011 14:12:48 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id 78BE228076; Tue, 31 May 2011 14:12:48 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id 7295928070; Tue,
 31 May 2011 14:12:48 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac2.idc.renesas.com with ESMTP id QAK32221; Tue,
 31 May 2011 14:12:48 +0900
X-IronPort-AV: E=Sophos;i="4.65,295,1304262000";   d="scan'208";a="29510822"
Received: from unknown (HELO relay11.aps.necel.com) ([10.29.19.46])
 by relmlii1.idc.renesas.com with ESMTP; Tue, 31 May 2011 14:12:48 +0900
Received: from relay11.aps.necel.com ([10.29.19.46] [10.29.19.46])
 by relay11.aps.necel.com with ESMTP; Tue, 31 May 2011 14:12:48 +0900
Received: from dhlpc061 ([10.114.97.129] [10.114.97.129])
 by relay11.aps.necel.com with ESMTP; Tue, 31 May 2011 14:12:48 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 0367D52E1EF; Tue,
 31 May 2011 14:12:47 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20110530161230.GA25291@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174791>

Jeff King <peff@peff.net> writes:
>> Yes and No. We have already copied some code from git : parse-option,
>> the error handling functions, a part of the run-command block and a
>> part of the compatibility layer. To my mind, there is no reason to
>> pull it into libgit2 as it's only a client feature that works on
>> strings, and libgit2 does not aim at being a client, only a git
>> library.
>
> Yeah, good point. Definitely it should not be part of the libgit2
> library itself.

But maybe there's room for another library to hold such things
(libgitapp...)?

-Miles

-- 
`Cars give people wonderful freedom and increase their opportunities.
 But they also destroy the environment, to an extent so drastic that
 they kill all social life' (from _A Pattern Language_)
