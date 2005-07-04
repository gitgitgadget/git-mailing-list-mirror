From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Mon, 04 Jul 2005 21:42:46 +0100
Message-ID: <1120509766.6879.5.camel@localhost.localdomain>
References: <1119994003.9631.6.camel@localhost.localdomain>
	 <m3ekagp9mk.fsf@telia.com> <1120385280.6845.12.camel@localhost.localdomain>
	 <m3oe9k6p40.fsf@telia.com> <1120425269.6845.28.camel@localhost.localdomain>
	 <m3y88m21ln.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 22:43:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpXmI-0002Ue-7P
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 22:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVGDUmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGDUmu
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 16:42:50 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:8132 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261657AbVGDUms (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 16:42:48 -0400
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050704204247.CKOB11649.mta09-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Mon, 4 Jul 2005 21:42:47 +0100
Received: from cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com ([81.104.193.212])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20050704204247.JOFV23101.aamta10-winn.ispmail.ntl.com@cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com>;
          Mon, 4 Jul 2005 21:42:47 +0100
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3y88m21ln.fsf@telia.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-07-04 at 14:32 +0200, Peter Osterlund wrote:
> I agree with the other comments, it's probably not wise to rely on
> wiggle, and wiggle sometimes makes a mess. However, it often does the
> right thing, and with a configurable merge program and an undo
> function, this should not be a problem. Just undo and try again if you
> don't like the result.

I uploaded a new snapshot (stgit-20050704.tar.gz) which has support for
merge tool configuration. It installs a default /etc/stgitrc file but
you can define your own options in ~/.stgitrc or .git/stgitrc (the
latter overrides the options in the earlier files). You can even define
something like - 'diff3 ... || xxdiff ...' so that if one tool fails it
will try the next one (the whole command is executed with 'sh -c').

I will try to write an 'undo' command in the next days.

--
Catalin
