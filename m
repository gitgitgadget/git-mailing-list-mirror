From: "David S. Miller" <davem@davemloft.net>
Subject: Re: t6021-merge-criss-cross.sh fails on some systems
Date: Sat, 10 Dec 2005 23:58:18 -0800 (PST)
Message-ID: <20051210.235818.90276521.davem@davemloft.net>
References: <20051210.144235.125914760.davem@davemloft.net>
	<20051211003353.GA27207@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 08:58:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElM5z-0003Gc-TS
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 08:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbVLKH6D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 02:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLKH6D
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 02:58:03 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17893
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751330AbVLKH6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 02:58:02 -0500
Received: from localhost.localdomain
	([127.0.0.1] helo=localhost ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1ElM6B-0005kd-Cu; Sat, 10 Dec 2005 23:58:23 -0800
To: freku045@student.liu.se
In-Reply-To: <20051211003353.GA27207@c165.ib.student.liu.se>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13486>

From: Fredrik Kuivinen <freku045@student.liu.se>
Date: Sun, 11 Dec 2005 01:33:53 +0100

> It looks like 'merge' can't be found. The recursive merge strategy
> uses 'merge' to do file-level merging. Do you have merge(1)
> installed?

Yet another weird dependency. :-/  Thanks for the info.

I bet a tiny shell script could run at GIT build time
to check for the presence of these necessary items. :-)
Yes, the debian/rpm/etc. packaging dependencies will catch
this, but a lot of us are doing:

git pull && make && make test && make install

:-)
