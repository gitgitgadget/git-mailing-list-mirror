From: Miles Bader <miles@gnu.org>
Subject: Re: git push default behaviour?
Date: Mon, 19 Mar 2012 15:02:42 +0900
Message-ID: <buoy5qxi0vx.fsf@dhlpc061.dev.necel.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 07:03:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9VgV-0007P5-LW
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 07:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161900Ab2CSGDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 02:03:03 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:38811 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161498Ab2CSGCr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 02:02:47 -0400
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0M1400BCRBGL6S70@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Mon, 19 Mar 2012 15:02:45 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0M1400MXVBGLF870@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Mon, 19 Mar 2012 15:02:45 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 7AFC9480A3; Mon, 19 Mar 2012 15:02:45 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 7A58D480A5; Mon,
 19 Mar 2012 15:02:45 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id RAK17949; Mon,
 19 Mar 2012 15:02:45 +0900
X-IronPort-AV: E=Sophos;i="4.73,610,1325430000";   d="scan'208";a="73088735"
Received: from unknown (HELO relay51.aps.necel.com) ([10.29.19.60])
 by relmlii1.idc.renesas.com with ESMTP; Mon, 19 Mar 2012 15:02:45 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.96.202])
	by relay51.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id q2J62iAo022246;
 Mon, 19 Mar 2012 15:02:44 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id AF66352E2EE; Mon,
 19 Mar 2012 15:02:43 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193415>

Jeremy Morton <jeremy@configit.com> writes:
> Obviously - but my point is that it needn't be so dangerous by
> default.  It tries to push all matching branches - is that really a
> more common requirement than pushing the current branch?

It isn't "so dangerous" by default -- you have to specify --force to
enter "danger" territory, and --force is very clearly a dangerous
option that needs to be approached carefully (someone who uses --force
blindly is going to quickly screw themselves regardless of the
defaults).

-miles

-- 
Zeal, n. A certain nervous disorder afflicting the young and inexperienced.
