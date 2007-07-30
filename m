From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 10:09:16 +0200
Message-ID: <577C7529-4C3C-40D4-B86A-8B3CE888C997@zib.de>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com> <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net> <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de> <20070730074937.GT20052@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:09:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQKB-0000RQ-7E
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 10:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761247AbXG3IJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 04:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763443AbXG3IJR
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 04:09:17 -0400
Received: from mailer.zib.de ([130.73.108.11]:52110 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759943AbXG3II4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 04:08:56 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6U88MFQ007516;
	Mon, 30 Jul 2007 10:08:22 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6U88L5D002044
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 30 Jul 2007 10:08:21 +0200 (MEST)
In-Reply-To: <20070730074937.GT20052@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54201>


On Jul 30, 2007, at 9:49 AM, Shawn O. Pearce wrote:

> git-force-commit:
>
>   git config --global alias.force-commit \
>   '! git update-ref HEAD $(echo MARK | git commit-tree HEAD -p HEAD)'

I needed to slightly modify it

     git config --global alias.force-commit \
     '! git update-ref HEAD $(echo MARK | git commit-tree $(git cat- 
file commit HEAD | grep ^tree | cut -b 6-) -p HEAD)'

> But you didn't hear it from me.  ;-)

I'll tell no-one ;)

	Steffen
