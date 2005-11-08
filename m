From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make tests ignorable with "make -i"
Date: Tue, 8 Nov 2005 22:16:18 +0100
Message-ID: <20051108211618.GA3224@steel.home>
References: <81b0412b0511080151v69bc4578we093eaa751ee4bac@mail.gmail.com> <7vmzkfey4o.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 22:19:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZapb-0007Ct-V6
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 22:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVKHVQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVKHVQd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 16:16:33 -0500
Received: from devrace.com ([198.63.210.113]:8709 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030240AbVKHVQd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 16:16:33 -0500
Received: from tigra.home (p54A0D61D.dip.t-dialin.net [84.160.214.29])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jA8LGKQ2080384;
	Tue, 8 Nov 2005 15:16:22 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EZapG-0000n7-00; Tue, 08 Nov 2005 22:16:18 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EZapG-0001HL-HE; Tue, 08 Nov 2005 22:16:18 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzkfey4o.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.7 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11357>

Junio C Hamano, Tue, Nov 08, 2005 20:29:59 +0100:
> > ...  (Or to ignore plainly uninteresting situations because of the
> > testing being done on say...  cygwin ;)
> 
> Could you tell us which ones break on Cygwin?
> 

of course. I remember t4000-diff-format having problems, using chmod +x
and comparing the results afterwards (it's not really cygwin problem,
but FAT). I let the whole suite running tomorrow and just post the
failed here (instead of dreaming how nice would it be to live in a
perfect world).
