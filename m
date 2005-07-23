From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Sat, 23 Jul 2005 21:52:13 +0100
Message-ID: <1122151933.6863.85.camel@localhost.localdomain>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	 <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	 <20050722192424.GB8556@mars.ravnborg.org>
	 <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	 <1122068634.7042.35.camel@localhost.localdomain>
	 <7vu0imh23q.fsf@assigned-by-dhcp.cox.net>
	 <1122108098.6863.38.camel@localhost.localdomain>
	 <20050723093035.GB11814@pasky.ji.cz>
	 <1122114452.6863.72.camel@localhost.localdomain>
	 <42E27155.6070903@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 22:53:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwQzH-0004tQ-Ot
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 22:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVGWUwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 16:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGWUwS
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 16:52:18 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:16211 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261661AbVGWUwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 16:52:16 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050723205215.ZDRT25008.mta09-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Sat, 23 Jul 2005 21:52:15 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050723205215.NBYL19483.aamta09-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Sat, 23 Jul 2005 21:52:15 +0100
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <42E27155.6070903@yahoo.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-07-23 at 12:33 -0400, Bryan Larsen wrote:
> how about:
>   .git/refs/heads/master - documented in README, doesn't appear to be used.

That's true, README is quite outdated. I created the
http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT page (empty now) where I
will add StGIT information and a tutorial. I will probably keep the
README to a minimum and just point people to the wiki page.

> .git/firstmail.tmpl - template used for sending the preamble email

This file is not used by StGIT. I put it there as an example and you can
use it with the --first option of 'mail'. The reason for this is that
you need to modify this file every time you send a patch series, unlike
the patchmail.tmpl file.

-- 
Catalin
