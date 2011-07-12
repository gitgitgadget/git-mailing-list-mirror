From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 15:36:02 +0900
Message-ID: <buovcv8f1kd.fsf@dhlpc061.dev.necel.com>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:36:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWZo-00045y-6x
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab1GLGgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:36:07 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:46020 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab1GLGgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:36:05 -0400
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LO700F1UJO4WW70@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Tue, 12 Jul 2011 15:36:04 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LO700BOBJO3X870@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Tue, 12 Jul 2011 15:36:04 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id DC57E28076; Tue, 12 Jul 2011 15:36:03 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id D79E828070; Tue,
 12 Jul 2011 15:36:03 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac2.idc.renesas.com with ESMTP id RAC10434; Tue,
 12 Jul 2011 15:36:03 +0900
X-IronPort-AV: E=Sophos;i="4.65,519,1304262000";   d="scan'208";a="36365383"
Received: from unknown (HELO relay31.aps.necel.com) ([10.29.19.54])
 by relmlii1.idc.renesas.com with ESMTP; Tue, 12 Jul 2011 15:36:03 +0900
Received: from relay31.aps.necel.com ([10.29.19.54] [10.29.19.54])
 by relay31.aps.necel.com with ESMTP; Tue, 12 Jul 2011 15:36:03 +0900
Received: from dhlpc061 ([10.114.97.129] [10.114.97.129])
 by relay31.aps.necel.com with ESMTP; Tue, 12 Jul 2011 15:36:03 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 5E86B52E22E; Tue,
 12 Jul 2011 15:36:03 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20110711220107.GC30155@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176931>

Jeff King <peff@peff.net> writes:
>> Sounds like a good thing to aim for, but "Object Cache" sounded too much
>> like giving access to the object data that is faster than either loose or
>> packed objects.
>
> Agreed. I'm open to better suggestions for the name. I would have just
> called it a straight out "cache" as it can be used for caching anything,
> but that term is already taken in git. :)

"Info Cache"?  Even more generic, but avoids the loaded term "object"....

-miles

-- 
`Life is a boundless sea of bitterness'
