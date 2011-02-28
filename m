From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 17:42:17 +0900
Message-ID: <buomxlg35zq.fsf@dhlpc061.dev.necel.com>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
 <4D68D630.9000608@drmicha.warpmail.net>
 <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
 <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>
 <7v39n8ll0s.fsf@alter.siamese.dyndns.org>
 <4D6B5D09.8010806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 09:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtyhS-00038X-8t
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 09:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759Ab1B1InV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 03:43:21 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:60539 "EHLO
	relmlor1.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1B1InU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 03:43:20 -0500
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor1.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHB003JTK6J2X80@relmlor1.idc.renesas.com> for
 git@vger.kernel.org; Mon, 28 Feb 2011 17:42:19 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHB00HKSK6JDZ20@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Mon, 28 Feb 2011 17:42:19 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id 2487F800A2; Mon, 28 Feb 2011 17:42:19 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id 1B2B880030; Mon,
 28 Feb 2011 17:42:19 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac1.idc.renesas.com with ESMTP id TAC08226; Mon,
 28 Feb 2011 17:42:19 +0900
X-IronPort-AV: E=Sophos;i="4.62,238,1297004400";   d="scan'208";a="13802271"
Received: from unknown (HELO relay11.aps.necel.com) ([10.29.19.46])
 by relmlii1.idc.renesas.com with ESMTP; Mon, 28 Feb 2011 17:42:18 +0900
Received: from relay11.aps.necel.com ([10.29.19.46] [10.29.19.46])
 by relay11.aps.necel.com with ESMTP; Mon, 28 Feb 2011 17:42:19 +0900
Received: from dhlpc061 ([10.114.97.66] [10.114.97.66])
 by relay11.aps.necel.com with ESMTP; Mon, 28 Feb 2011 17:42:18 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 71CA152E1DD; Mon,
 28 Feb 2011 17:42:18 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4D6B5D09.8010806@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168076>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> - "commit -a,--add <addopts>" be "add <addopts> && commit", and

Can you give an example?  It look like you're proposing that the user
would have to type "commit -a -u", which is pretty gross for a fairly
common operation that already has a good shorthand...

-Miles

-- 
Omochiroi!
