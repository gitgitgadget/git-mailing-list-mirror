From: Miles Bader <miles@gnu.org>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Thu, 01 Mar 2012 14:16:42 +0900
Message-ID: <buo399s3nph.fsf@dhlpc061.dev.necel.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <rmifwdti2ap.fsf@fnord.ir.bbn.com>
 <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Greg Troxel <gdt@ir.bbn.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:16:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2yNp-00063D-C7
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab2CAFQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 00:16:49 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:56985 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab2CAFQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 00:16:48 -0500
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0M0600EZRXBY6760@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Thu, 01 Mar 2012 14:16:46 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0M0600JXBXBYW0E0@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Thu, 01 Mar 2012 14:16:46 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id C0988480A3; Thu, 01 Mar 2012 14:16:46 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id BB73B48082; Thu,
 01 Mar 2012 14:16:46 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id QAA09889; Thu,
 01 Mar 2012 14:16:46 +0900
X-IronPort-AV: E=Sophos;i="4.73,507,1325430000";   d="scan'208";a="70449184"
Received: from unknown (HELO relay51.aps.necel.com) ([10.29.19.60])
 by relmlii1.idc.renesas.com with ESMTP; Thu, 01 Mar 2012 14:16:46 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.98.89])
	by relay51.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id q215GiXr017930;
 Thu, 01 Mar 2012 14:16:44 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id AE25D52E21E; Thu,
 01 Mar 2012 14:16:43 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
Importance: high
In-reply-to: <CAH5451kWaRGutP1esuvjSK-arrEc=5m-SDwVHACx6QF9JFj-MQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191895>

Andrew Ardill <andrew.ardill@gmail.com> writes:
> Additionally, if we are not prepared to use non-Free tools, we should
> probably stop using github.

I think the issue isn't "using" non-free tools so much as it's getting
_locked into_ non-free tools.

So if JIRA makes all its data trivially exportable in a format which
is easy to use, and there's some way of isolating references to it so
that it's possible to switch to something else without undue hardship,
maybe it's not such a big deal.

[Github is a prime example of a non-free tool which is largely avoids
the lockin issue, and I imagine that's why so many free projects
happily use it.  That's generally true of any git repo site, given the
super-easy cloneability of git repos, but Github also provides good
export of the meta-data it keeps (issues, etc).]

-Miles

-- 
/\ /\
(^.^)
(")")
*This is the cute kitty virus, please copy this into your sig so it can spread.
