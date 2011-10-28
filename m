From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Fri, 28 Oct 2011 10:40:28 +0900
Message-ID: <buo39edao6r.fsf@dhlpc061.dev.necel.com>
References: <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
 <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
 <20111027185220.GA26621@sigill.intra.peff.net>
 <7v39eez1ph.fsf@alter.siamese.dyndns.org>
 <20111027234429.GA28187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 28 03:41:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJbRl-00042U-Ag
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 03:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab1J1BlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 21:41:20 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:40871 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab1J1BlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 21:41:20 -0400
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LTR00KT45ZKF660@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Fri, 28 Oct 2011 10:40:32 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LTR00BTX5ZJ3T90@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Fri, 28 Oct 2011 10:40:32 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id C21824807B; Fri, 28 Oct 2011 10:40:31 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id B97D948070; Fri,
 28 Oct 2011 10:40:31 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id LAE06814; Fri,
 28 Oct 2011 10:40:31 +0900
X-IronPort-AV: E=Sophos;i="4.69,415,1315148400";   d="scan'208";a="52176597"
Received: from unknown (HELO relay61.aps.necel.com) ([10.29.19.64])
 by relmlii1.idc.renesas.com with ESMTP; Fri, 28 Oct 2011 10:40:31 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.97.17])
	by relay61.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id p9S1eU2U010485;
 Fri, 28 Oct 2011 10:40:30 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 205A252E1FF; Fri,
 28 Oct 2011 10:40:29 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20111027234429.GA28187@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184335>

Jeff King <peff@peff.net> writes:
> We do have people with utf-16 in their repositories on github. I
> have no idea why they do such a thing, or what kinds of tricks they
> do to make it usable (because without it, they just get "binary
> files differ").

Hmm, you could ask them ...  [or, I suppose more diplomatically, post
a blog entry asking "Hey all you people who use github for utf-16
encoded files, ..."]

-Miles

-- 
Year, n. A period of three hundred and sixty-five disappointments.
