From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: use GIT_DIR instead of /var/tmp
Date: Fri, 6 Jan 2006 10:32:13 +0100
Message-ID: <20060106093213.GA4268@steel.home>
References: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com> <Pine.LNX.4.64.0601050840010.3169@g5.osdl.org> <Pine.LNX.4.63.0601051048490.667@gheavc.wnzcbav.cig>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, junio@steel.home,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 10:33:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eunxz-0007Vc-Hc
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 10:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbWAFJcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 04:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbWAFJcm
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 04:32:42 -0500
Received: from devrace.com ([198.63.210.113]:25867 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1752293AbWAFJcm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2006 04:32:42 -0500
Received: from tigra.home (p54A0609A.dip.t-dialin.net [84.160.96.154])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k069WJa1026157;
	Fri, 6 Jan 2006 03:32:30 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EunxF-0001xG-00; Fri, 06 Jan 2006 10:32:13 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EunxF-00017R-Fi; Fri, 06 Jan 2006 10:32:13 +0100
To: Jon Nelson <jnelson-git@jamponi.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601051048490.667@gheavc.wnzcbav.cig>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14211>

Jon Nelson, Thu, Jan 05, 2006 17:49:36 +0100:
> Do you still need write access to $GIT_DIR if $GIT_INDEX_FILE is set to 
> some place outside of $GIT_DIR?

yes, $GIT_DIR/refs/heads/ref-pointed-by-HEAD is updated by git-reset.
