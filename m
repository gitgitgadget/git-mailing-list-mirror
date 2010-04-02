From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Git: relicensing test-lib.sh from GPLv2 to GPLv2+
Date: Fri, 2 Apr 2010 10:59:32 +0200
Message-ID: <20100402085932.GB26658@localhost>
References: <871vgmki4f.fsf@steelpick.localdomain>
 <7vaav8hpfo.fsf@alter.siamese.dyndns.org>
 <87tytdiqob.fsf@steelpick.localdomain>
 <alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
 <873a0xhwxs.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
 <87eikfhec1.fsf@yoom.home.cworth.org>
 <alpine.DEB.1.00.1002202321430.20986@pacific.mpi-cbg.de>
 <87pr2i8g8o.fsf@steelpick.2x.cz>
 <20100402074343.GV3533@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Sojka <sojkam1@fel.cvut.cz>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Brandon Casey <drafnel@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 02 11:01:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxclC-0005NX-VB
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 11:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab0DBJBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 05:01:47 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:52073 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab0DBJBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 05:01:45 -0400
Received: by bwz1 with SMTP id 1so1379610bwz.21
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=cQgdHdErOFxa6eWsX8ehAc3ZC6rn1+iumqLoNf3SuHE=;
        b=obpUMR2/jA9BXsgvjALFtOTD9qzbTqTtZUW6nkeb21FwqnLZyI8egySmNPso6YST1C
         5AE7+ohIDaKbZ3CHB48ZnA7d4Md9Zh5RcRKvk3r/KV+m0lVZE2IxnCiW+i3CPrv2MBN5
         vMjwguI+s0dAgq+ZSvB4Yi9NiIwv15nKKLhEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=RCi8PBXEqnUuyLH9wO5uFft4z8pc1lYavGdka+t4CKO/4Q3XkF9AGqS4c5uZ7eRmkf
         Bh7R0Ye60Hj5KJtWNVidzCsYBmKF43E4lsebKFa+HoaPT67esFabwP3pn/efYom3nSjz
         QpZ7+xonBXYocThXWlcDzhOiMUSkpFERWE9QY=
Received: by 10.204.152.135 with SMTP id g7mr1471514bkw.146.1270198902949;
        Fri, 02 Apr 2010 02:01:42 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 13sm4432716bwz.11.2010.04.02.02.01.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 02:01:41 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1Nxciy-00070y-I7; Fri, 02 Apr 2010 10:59:32 +0200
Content-Disposition: inline
In-Reply-To: <20100402074343.GV3533@machine.or.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143802>

On Fri, Apr 02, 2010 at 09:43:43AM +0200, Petr Baudis wrote:

>   Huh, didn't we just run through this about a month ago? Is this some
> kind of stale e-mail message?

Yes. I'm afraid that E-Mail never made it to the list or to Michael, because
neither were Cc'ed. Including myself, I got positive replies from the
following contributors.

 Johan Herland
 Brandon Casey
 Petr Baudis
 Miklos Vajna
 Shawn O. Pearce

It's probably best if you guys reply here again, for the record.

Clemens
