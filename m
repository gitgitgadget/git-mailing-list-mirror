From: Miles Bader <miles@gnu.org>
Subject: Re: git diff --added (Re: Command-line interface thoughts)
Date: Mon, 13 Jun 2011 13:11:00 +0900
Message-ID: <buotybu2wx7.fsf@dhlpc061.dev.necel.com>
References: <201106051311.00951.jnareb@gmail.com>
 <201106101844.16146.jnareb@gmail.com> <4DF25D50.5020107@ira.uka.de>
 <201106102035.42525.jnareb@gmail.com> <4DF29EA5.60502@ira.uka.de>
 <20110613034347.GA4222@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 06:17:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVyaz-0002pJ-4t
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 06:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795Ab1FMELH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 00:11:07 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:39446 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1FMELG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 00:11:06 -0400
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LMP00BW0NMG9U50@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Mon, 13 Jun 2011 13:11:04 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LMP00FDYNMGH850@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Mon, 13 Jun 2011 13:11:04 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id 0A8E128070; Mon, 13 Jun 2011 13:11:03 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id EDCE778002; Mon,
 13 Jun 2011 13:11:03 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac2.idc.renesas.com with ESMTP id PAN04417; Mon,
 13 Jun 2011 13:11:03 +0900
X-IronPort-AV: E=Sophos;i="4.65,356,1304262000";   d="scan'208";a="31737586"
Received: from unknown (HELO relay31.aps.necel.com) ([10.29.19.54])
 by relmlii2.idc.renesas.com with ESMTP; Mon, 13 Jun 2011 13:11:03 +0900
Received: from relay31.aps.necel.com ([10.29.19.54] [10.29.19.54])
 by relay31.aps.necel.com with ESMTP; Mon, 13 Jun 2011 13:11:03 +0900
Received: from dhlpc061 ([10.114.97.171] [10.114.97.171])
 by relay31.aps.necel.com with ESMTP; Mon, 13 Jun 2011 13:11:03 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 9396252E1F6; Mon,
 13 Jun 2011 13:11:01 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20110613034347.GA4222@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175681>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Do you think it would be valuable to introduce --added as a synonym
> for --cached and slowly steer documentation to encourage the latter
> in place of the former?

"--added" sounds very awkward though; "--staged" is much more natural.

-miles

-- 
Idiot, n. A member of a large and powerful tribe whose influence in human
affairs has always been dominant and controlling.
