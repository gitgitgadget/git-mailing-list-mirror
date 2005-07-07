From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Thu, 07 Jul 2005 22:22:22 +0100
Message-ID: <1120771342.7032.5.camel@localhost.localdomain>
References: <1119994003.9631.6.camel@localhost.localdomain>
	 <m3ekagp9mk.fsf@telia.com> <1120385280.6845.12.camel@localhost.localdomain>
	 <m3oe9k6p40.fsf@telia.com> <1120425269.6845.28.camel@localhost.localdomain>
	 <m3y88m21ln.fsf@telia.com> <1120683255.6881.8.camel@localhost.localdomain>
	 <m38y0ictno.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 23:28:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqdtU-00078h-8P
	for gcvg-git@gmane.org; Thu, 07 Jul 2005 23:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVGGV0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 17:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVGGVYE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 17:24:04 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:51736 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261709AbVGGVWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 17:22:25 -0400
Received: from aamta11-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050707212224.QJQV481.mta07-winn.ispmail.ntl.com@aamta11-winn.ispmail.ntl.com>;
          Thu, 7 Jul 2005 22:22:24 +0100
Received: from cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com ([81.104.192.179])
          by aamta11-winn.ispmail.ntl.com with ESMTP
          id <20050707212224.EZGQ17887.aamta11-winn.ispmail.ntl.com@cpc1-cmbg5-3-0-cust179.cmbg.cable.ntl.com>;
          Thu, 7 Jul 2005 22:22:24 +0100
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m38y0ictno.fsf@telia.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-07-07 at 21:17 +0200, Peter Osterlund wrote:
> I've found an unrelated problem. If I export patches with "stg export
> dirname", there are no diffs included in the patches. The patch
> description is all that is generated. If I omit the dirname parameter,
> the export works correctly though.

OK, thanks. Fixed in the today's snapshot. I also added a 'resolved'
command to mark a solved conflict. 'stg status' also shows the conflicts
and 'refresh', 'push', 'pop' fail if there are unresolved conflicts. You
can override this by setting 'autoresolved: yes' in the stgitrc file and
a 'refresh' command marks all the conflicts as solved automatically (I
still need to find some time to write a tutorial for StGIT).

Catalin
