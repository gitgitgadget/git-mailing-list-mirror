From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 18:03:33 +0900
Message-ID: <buobp1w350a.fsf@dhlpc061.dev.necel.com>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
 <4D68D630.9000608@drmicha.warpmail.net>
 <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
 <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>
 <7v39n8ll0s.fsf@alter.siamese.dyndns.org>
 <4D6B5D09.8010806@drmicha.warpmail.net>
 <buomxlg35zq.fsf@dhlpc061.dev.necel.com>
 <4D6B6101.9090504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 10:03:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptz13-0003ss-Ai
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 10:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab1B1JDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 04:03:36 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:63110 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab1B1JDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 04:03:35 -0500
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHB003QBL5Y2X90@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Mon, 28 Feb 2011 18:03:34 +0900 (JST)
Received: from relmlac3.idc.renesas.com ([10.200.69.23])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHB00K2CL5Y3AA0@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Mon, 28 Feb 2011 18:03:34 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
	id 51C8C18071; Mon, 28 Feb 2011 18:03:34 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
	by relmlac3.idc.renesas.com (Postfix) with ESMTP id 411911807C; Mon,
 28 Feb 2011 18:03:34 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac3.idc.renesas.com with ESMTP id UAB03897; Mon,
 28 Feb 2011 18:03:34 +0900
X-IronPort-AV: E=Sophos;i="4.62,238,1297004400";   d="scan'208";a="13905969"
Received: from unknown (HELO relay21.aps.necel.com) ([10.29.19.50])
 by relmlii2.idc.renesas.com with ESMTP; Mon, 28 Feb 2011 18:03:34 +0900
Received: from relay21.aps.necel.com ([10.29.19.50] [10.29.19.50])
 by relay21.aps.necel.com with ESMTP; Mon, 28 Feb 2011 18:03:33 +0900
Received: from dhlpc061 ([10.114.97.66] [10.114.97.66])
 by relay21.aps.necel.com with ESMTP; Mon, 28 Feb 2011 18:03:33 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id C7FFE52E1DD; Mon,
 28 Feb 2011 18:03:33 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4D6B6101.9090504@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168079>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> Miles Bader venit, vidit, dixit 28.02.2011 09:42:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>> - "commit -a,--add <addopts>" be "add <addopts> && commit", and
>> 
>> Can you give an example?  It look like you're proposing that the user
>> would have to type "commit -a -u", which is pretty gross for a fairly
>> common operation that already has a good shorthand...
>
> we don't need "-u" any more, because it's the new default. So,
> obviously, "commit -a" would do what it always did.

Ok, so for "-u" that works out.

But for -A, the user would have to type "commit -a -A".

That sort of indirection is clever, but it seems confusing and
inconvenient for the user, and I think a very common question would be
"why do I need to use -a when it's obvious that -A should imply that?"

-miles

-- 
Vote, v. The instrument and symbol of a freeman's power to make a fool of
himself and a wreck of his country.
