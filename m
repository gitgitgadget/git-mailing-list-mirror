From: "David S. Miller" <davem@davemloft.net>
Subject: Re: non-trivial merge failures
Date: Sun, 20 Nov 2005 20:15:16 -0800 (PST)
Message-ID: <20051120.201516.51180644.davem@davemloft.net>
References: <20051120.134945.104623647.davem@davemloft.net>
	<200511202351.42320.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 05:16:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee35N-0001VO-7k
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 05:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVKUEPO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 23:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVKUEPO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 23:15:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50401
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750818AbVKUEPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 23:15:12 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1Ee35I-0005yi-TV; Sun, 20 Nov 2005 20:15:16 -0800
To: ismail@uludag.org.tr
In-Reply-To: <200511202351.42320.ismail@uludag.org.tr>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12419>

From: Ismail Donmez <ismail@uludag.org.tr>
Date: Sun, 20 Nov 2005 23:51:42 +0200

> Sunday 20 November 2005 23:49 tarihinde $,1 (Bunlar$,1 Q(B yazm$,1 Q (Bt$,1 Q(Bn$,1 Q(Bz:
> > ImportError: No module named subprocess
> 
> You need Python 2.4.x, subprocess is a new module in Python 2.4

It's amazing that "make test" passes in the presence of Python 2.3 :-)

Maybe at least a trivial version check can be added to GIT somewhere?
