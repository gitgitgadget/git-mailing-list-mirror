From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Fri, 19 Aug 2005 23:15:35 +0100
Message-ID: <1124489735.6957.4.camel@localhost.localdomain>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
	 <20050819182732.GA5512@fanta>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 00:20:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6F9J-0000Ay-Ug
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 00:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVHSWPj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 18:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVHSWPj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 18:15:39 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:46221 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932318AbVHSWPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 18:15:38 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050819221537.VBRD21883.mta07-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Fri, 19 Aug 2005 23:15:37 +0100
Received: from cpc1-cmbg5-3-0-cust219.cmbg.cable.ntl.com ([81.104.192.219])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050819221537.GTXD23288.aamta09-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust219.cmbg.cable.ntl.com>;
          Fri, 19 Aug 2005 23:15:37 +0100
To: Jan Veldeman <jan.veldeman@gmail.com>
In-Reply-To: <20050819182732.GA5512@fanta>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-08-19 at 20:27 +0200, Jan Veldeman wrote:
> hmm, not exactly, for example, when reordering the patches (including the
> top one), I would like to see this in gitk.
> Or when a patch has been dropped (amongst a lot of patches), it should be
> easily spotted.

I tried your patch but the gitk image confused me. I will look again at
it tomorrow (it's quite late in the UK now).

One immediate thing I noticed was that the commits directly accessible
via .git/HEAD are shown as empty by gitk and you would need to follow
the parents to see what they contain. For every freeze, the patches
expand to the right in gitk and the graph could get very complex after
several freeze commands.

-- 
Catalin
