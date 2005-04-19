From: David Meybohm <dmeybohmlkml@bellsouth.net>
Subject: Re: SHA1 hash safety
Date: Tue, 19 Apr 2005 18:30:27 -0400
Message-ID: <20050419223027.GA26100@localhost>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz> <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz> <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu> <4261852B.6090507@khandalf.com> <20050418074323.GA29765@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: omb@bluewin.ch, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:27:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1Al-0005kW-AP
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVDSWaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVDSWa3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:30:29 -0400
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:34998 "EHLO
	imf25aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261702AbVDSWaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 18:30:25 -0400
Received: from ibm71aec.bellsouth.net ([65.10.203.194])
          by imf25aec.mail.bellsouth.net
          (InterMail vM.5.01.06.11 201-253-122-130-111-20040605) with ESMTP
          id <20050419223024.GBNO22125.imf25aec.mail.bellsouth.net@ibm71aec.bellsouth.net>;
          Tue, 19 Apr 2005 18:30:24 -0400
Received: from localhost ([65.10.203.194]) by ibm71aec.bellsouth.net
          (InterMail vG.1.02.00.01 201-2136-104-101-20040929) with ESMTP
          id <20050419223024.TWXP1909.ibm71aec.bellsouth.net@localhost>;
          Tue, 19 Apr 2005 18:30:24 -0400
To: Andy Isaacson <adi@hexapodia.org>
Content-Disposition: inline
In-Reply-To: <20050418074323.GA29765@hexapodia.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 18, 2005 at 12:43:23AM -0700, Andy Isaacson wrote:
> 
> I'm not going to do the sums, but I would hazard a guess that it's more
> likely your PC suffered a cosmic-ray-induced memory fault - EACH OF THE
> FOUR TIMES YOU TESTED IT - causing it to report the same MD5, than that
> you actually discovered a collision with a measly million (or even
> hundred million) plaintexts.

But doesn't this require assuming the distribution of MD5 is uniform,
and don't the papers finding collisions in less show it's not? So, your
birthday-argument for calculating the probability wouldn't apply, because
it rests on the assumption MD5 is uniform, and it isn't.

For example, say most people are married in June, get pregnant, and
there are more births around March, 9 months later, than in other
months. Then if you are born in March you have a higher chance of seeing
a collision of your birthday with someone else's. The same is true for
someone else born in March too, and this makes the chances of seeing a
collision for the whole function higher.

