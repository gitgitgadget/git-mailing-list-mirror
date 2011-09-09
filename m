From: Miles Bader <miles@gnu.org>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 09 Sep 2011 17:12:39 +0900
Message-ID: <buopqjaw2vc.fsf@dhlpc061.dev.necel.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
 <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
 <4E68C04F.9060804@drmicha.warpmail.net>
 <CAEBDL5VAFaWYctJotxTA8ajy_0KtR8H_4SoDHK29Ofd65mYdKw@mail.gmail.com>
 <20110908191842.GB16064@sigill.intra.peff.net>
 <4E69C8DC.7060008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, John Szakmeister <john@szakmeister.net>,
	Kyle Neath <kneath@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 10:12:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1wCj-0002Mi-II
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 10:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758565Ab1IIIMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 04:12:45 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:61253 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534Ab1IIIMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 04:12:42 -0400
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LR800ES8XH5IC40@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Fri, 09 Sep 2011 17:12:41 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LR8006BZXH4KT30@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Fri, 09 Sep 2011 17:12:41 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 30A7348070; Fri, 09 Sep 2011 17:12:41 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 2EE7C4808F; Fri,
 09 Sep 2011 17:12:41 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac4.idc.renesas.com with ESMTP id TAH20350; Fri,
 09 Sep 2011 17:12:41 +0900
X-IronPort-AV: E=Sophos;i="4.68,355,1312124400";   d="scan'208";a="44923352"
Received: from unknown (HELO relay31.aps.necel.com) ([10.29.19.54])
 by relmlii2.idc.renesas.com with ESMTP; Fri, 09 Sep 2011 17:12:40 +0900
Received: from relay31.aps.necel.com ([10.29.19.54] [10.29.19.54])
 by relay31.aps.necel.com with ESMTP; Fri, 09 Sep 2011 17:12:41 +0900
Received: from dhlpc061 ([10.114.96.156] [10.114.96.156])
 by relay31.aps.necel.com with ESMTP; Fri, 09 Sep 2011 17:12:40 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 6288A52E21F; Fri,
 09 Sep 2011 17:12:40 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4E69C8DC.7060008@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181032>

Michael J Gruber <git@drmicha.warpmail.net> writes:
>> Agreed. Anything harder than ssh keys is right out the window,
>> because they're always the alternative these people could be using
>> (but can't or don't want to).
>
> Sue, the question was: What is easy enough? I hoped that people
> would be using gpg to check signed tags, and that there might be a
> simple, convenient gnupg installer for Win and Mac which ties into
> the respective wallet systems or provides one they use already.

I wouldn't be surprised if many people just don't check signed tags at
all -- if the repositories they're using even have them in the first
place -- particularly amongst the audience in question.

-miles

-- 
What the fuck do white people have to be blue about!?  Banana Republic ran
out of Khakis?  The Espresso Machine is jammed?  Hootie and The Blowfish
are breaking up??!  Shit, white people oughtta understand, their job is to
GIVE people the blues, not to get them!  -- George Carlin
