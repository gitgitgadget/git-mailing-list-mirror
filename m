From: Alex Riesen <fork0@users.sourceforge.net>
Subject: Re: [PATCH 4/4] git-fetch-pack: Implement client part of the multi_ack extension
Date: Wed, 26 Oct 2005 20:34:12 +0200
Message-ID: <20051026183412.GB8030@steel.home>
References: <Pine.LNX.4.63.0510251730200.12176@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0510230339090.21239@wbgn013.biozentrum.uni-wuerzburg.de> <20051025204754.GA8030@steel.home> <Pine.LNX.4.63.0510252300290.15756@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0510252346t3806892dx71f9c0dc1efe4073@mail.gmail.com> <Pine.LNX.4.63.0510261041100.7424@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 20:36:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUq6o-000891-Ew
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 20:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVJZSed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 26 Oct 2005 14:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVJZSed
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 14:34:33 -0400
Received: from devrace.com ([198.63.210.113]:56332 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S964850AbVJZSed (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 14:34:33 -0400
Received: from tigra.home (p54A0C833.dip.t-dialin.net [84.160.200.51])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id j9QIYEbr090848;
	Wed, 26 Oct 2005 13:34:16 -0500 (CDT)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EUq6H-0007bu-00; Wed, 26 Oct 2005 20:34:13 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EUq6G-0004qj-Ty; Wed, 26 Oct 2005 20:34:12 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510251730200.12176@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0510261041100.7424@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.7 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10685>

Johannes Schindelin, Wed, Oct 26, 2005 10:41:47 +0200:
> > > Could you please try the patch I sent with the subject "[PATCH]
> > > fetch/upload: Fix corner case with few revs"? Your output looks e=
xactly
> > > like what I fixed with that patch.
> > I couldn't at the moment. Do you still need a test?
> If you have time and can test it, yes, please.

Johannes Schindelin, Tue, Oct 25, 2005 17:34:07 +0200:
> When git-fetch-pack did not have enough revs to send, it did not real=
ize=20
> that the server actually speaks multi_ack. The server would now conti=
nue=20
> sending ack=C2=B4s, but the client would try to unpack objects. Oops.

This patch fixed it.
