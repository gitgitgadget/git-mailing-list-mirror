From: Haakon Riiser <haakon.riiser@fys.uio.no>
Subject: Re: Cleaning the .git directory with gc
Date: Thu, 24 Apr 2008 23:14:58 +0200
Message-ID: <20080424211458.GA8817@fox>
References: <20080423231359.GA30913@fox> <f9d2a5e10804231709v1d7e426fwf68b3d316a15081a@mail.gmail.com> <20080424005013.GP29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 23:15:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp8nH-0004nK-4G
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 23:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbYDXVPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 17:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbYDXVPB
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 17:15:01 -0400
Received: from pat.uio.no ([129.240.10.15]:47910 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbYDXVPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 17:15:00 -0400
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1Jp8mR-0001fE-K7
	for git@vger.kernel.org; Thu, 24 Apr 2008 23:14:59 +0200
Received: from smtp.uio.no ([129.240.10.9] helo=mail-mx4.uio.no)
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1Jp8mR-0001jF-Cu
	for git@vger.kernel.org; Thu, 24 Apr 2008 23:14:59 +0200
Received: from c85-196-100-202.static.sdsl.no ([85.196.100.202] helo=bigboss.venod.com)
	by mail-mx4.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1Jp8mR-0001j3-8w
	for git@vger.kernel.org; Thu, 24 Apr 2008 23:14:59 +0200
Received: from fox.venod.com ([10.0.0.4])
	by bigboss.venod.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1Jp8mQ-0003fo-Rp
	for git@vger.kernel.org; Thu, 24 Apr 2008 23:14:58 +0200
Received: from hakonrk by fox.venod.com with local (Exim 4.67)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1Jp8mQ-0002PL-LQ
	for git@vger.kernel.org; Thu, 24 Apr 2008 23:14:58 +0200
Content-Disposition: inline
In-Reply-To: <20080424005013.GP29771@spearce.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: B06E199A1E04E6B4F0B21F6D91C095EDE81B84A8
X-UiO-SR-test: A4FCEAF129601A35441F2FB1439E9DABE7932A87
X-UiO-SPAM-Test: remote_host: 129.240.10.9 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 114 total 8074212 max/h 8345 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80316>

[Shawn O. Pearce]

> [...] 
> If you _really_ need to whack all of that away, make a clone
> and then discard the old one, e.g.:
> 
> 	git clone file://`pwd`/old_proj new_proj
> 
> Note you need to use the file:// URI syntax to prevent Git from
> just hardlinking everything.  It takes a little longer, but the
> resulting new_proj will be cruft free.

Thanks for answering my question so quickly.  I really wasn't that
worried about it, but seemed strange that the --amend option only
seemed to affect the logs.  Anyway, it's nice to know I can start
with a clean slate if I want to by cloning from a file:// path.

-- 
 Haakon
