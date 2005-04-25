From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 17:47:13 +0200
Message-ID: <E1DQ5nn-0003au-QN@be1.7eggert.dyndns.org>
References: <3WtO4-5GW-5@gated-at.bofh.it> <3WtXG-5Nh-9@gated-at.bofh.it> <3WtXG-5Nh-7@gated-at.bofh.it> <3WwLT-848-13@gated-at.bofh.it> <3WxeV-5S-9@gated-at.bofh.it> <3WxHT-pv-1@gated-at.bofh.it> <3Wyb3-Sj-33@gated-at.bofh.it> <3WyDZ-1a6-7@gated-at.bofh.it> <3WYRN-5lJ-9@gated-at.bofh.it> <3X0gU-6u6-5@gated-at.bofh.it> <3X1G1-7ug-9@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Apr 25 17:48:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ5my-0000n1-6S
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 17:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVDYPud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 11:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVDYPsu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 11:48:50 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:44486 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262634AbVDYPsT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2005 11:48:19 -0400
Received: from be3.lrz.7eggert.dyndns.org (dsl-213-023-007-193.arcor-ip.net [213.23.7.193])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP
	id 41943103090; Mon, 25 Apr 2005 17:48:15 +0200 (CEST)
Received: from be1.lrz ([192.168.1.201] helo=be1.7eggert.dyndns.org)
	by be3.lrz.7eggert.dyndns.org with esmtp (Exim 4.43)
	id 1DQ5sw-0000dR-VU; Mon, 25 Apr 2005 17:52:35 +0200
Received: from localhost ([127.0.0.1] helo=be1)
	by be1.7eggert.dyndns.org with smtp (Exim 4.22)
	id 1DQ5nn-0003au-QN; Mon, 25 Apr 2005 17:47:15 +0200
To: Matt Domsch <Matt_Domsch@dell.com>,
	"David A. Wheeler" <dwheeler@dwheeler.com>,
	Paul Jakma <paul@clubi.ie>, Linus Torvalds <torvalds@osdl.org>,
	Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
User-Agent: KNode/0.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Domsch <Matt_Domsch@dell.com> wrote:

> --------------
> sign

> gpg --armor --clearsign --detach-sign --default-key "${DEFAULT_KEY} -v -v -o -
> ${1} | \ ${CUTSIG} > ${1}.sign

Use quotes!

> exit 0

The exit code should reflect the status from gpg.
If gpg failed, you might also want to remove the .sign file.

-- 
Top 100 things you don't want the sysadmin to say:
37. What is all this I here about static charges destroying computers?

