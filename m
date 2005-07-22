From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 22:00:46 +0100
Message-ID: <1122066046.7042.1.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722192424.GB8556@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:03:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw4dj-0004z4-F7
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVGVVAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbVGVVAw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:00:52 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:7791 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262170AbVGVVAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 17:00:50 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050722210049.JQVO25008.mta09-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>;
          Fri, 22 Jul 2005 22:00:49 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta12-winn.ispmail.ntl.com with ESMTP
          id <20050722210048.GYPU9998.aamta12-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Fri, 22 Jul 2005 22:00:48 +0100
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050722192424.GB8556@mars.ravnborg.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-07-22 at 19:24 +0000, Sam Ravnborg wrote:
> > I would use a neutral commit template, only that it should have a
> > neutral prefix as well for the lines to be removed (neither STG nor CG
> > but GIT maybe). The $GIT_DIR/commit-template is fine as a file name.
> 
> How about $GIT_DIR/commit-template-`basename $EDITOR`
> Then we could have different templates for vim, emacs, kade etc.

I'm not sure this is worth the hassle since a person usually sticks with
one editor, I don't see why one would use different $EDITOR variables
with the same project.

-- 
Catalin
