From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Tue, 15 Nov 2011 13:48:00 +0900
Message-ID: <buoehxat2in.fsf@dhlpc061.dev.necel.com>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
 <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
 <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
 <20111114103451.GA10847@sigill.intra.peff.net>
 <7vfwhqjw4u.fsf@alter.siamese.dyndns.org>
 <20111114202522.GA26269@sigill.intra.peff.net>
 <7vmxbyicgg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Simon Brenner <olsner@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 05:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQAwN-0006Dz-Re
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 05:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab1KOEsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 23:48:06 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:46429 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab1KOEsF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 23:48:05 -0500
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUO00LNAQO3VS00@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Tue, 15 Nov 2011 13:48:03 +0900 (JST)
Received: from relmlac3.idc.renesas.com ([10.200.69.23])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUO003DGQO3R990@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Tue, 15 Nov 2011 13:48:03 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
	id 3E58D18071; Tue, 15 Nov 2011 13:48:03 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
	by relmlac3.idc.renesas.com (Postfix) with ESMTP id 2F2EA18077; Tue,
 15 Nov 2011 13:48:03 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac3.idc.renesas.com with ESMTP id PAA27318; Tue,
 15 Nov 2011 13:48:03 +0900
X-IronPort-AV: E=Sophos;i="4.69,513,1315148400";   d="scan'208";a="54784828"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii1.idc.renesas.com with ESMTP; Tue, 15 Nov 2011 13:48:02 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.50])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pAF4m169021457;
 Tue, 15 Nov 2011 13:48:01 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id EB0AA52E283; Tue,
 15 Nov 2011 13:48:00 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7vmxbyicgg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185422>

Junio C Hamano <gitster@pobox.com> writes:
> I did not mean "it is wrong because it does not match what Miles said"
> by that. In fact, I think it is a better approach to put things in
> clients first and consolidating possible duplicates at the central one
> purely as optimization, and I do not necessarily see "write to central
> from the beginning" as a particularly good "optimization".

FWIW, this seems reasonable to me...

-Miles

-- 
Circus, n. A place where horses, ponies and elephants are permitted to see
men, women and children acting the fool.
