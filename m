From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] git-config: respect other options after -l, most notably --file
Date: Wed, 10 Oct 2007 00:49:43 +0200
Message-ID: <20071009224943.GH31659@planck.djpig.de>
References: <20071009125024.1259.qmail@d8e601127fe8d0.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 00:50:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfNtt-0007cM-LI
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 00:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbXJIWt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 18:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753883AbXJIWt4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 18:49:56 -0400
Received: from planck.djpig.de ([85.10.192.180]:2505 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbXJIWt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 18:49:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id EA44788231;
	Wed, 10 Oct 2007 00:49:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c1jKv04ZvLsD; Wed, 10 Oct 2007 00:49:44 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 06A0288232; Wed, 10 Oct 2007 00:49:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071009125024.1259.qmail@d8e601127fe8d0.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60455>

On Tue, Oct 09, 2007 at 12:50:24PM +0000, Gerrit Pape wrote:
> When git-commit is seeing the -l|--list option, it stops reading the
> following command line options.  So although they should be the same,
> the following commands act differently:
> 
>  git config --file ../repo2/.git/config -l
>  git config -l --file ../repo2/.git/config
> 
> This patch delays the 'list all variables' to after the command line
> options have been processed.

Note that I have posted a conflicting patch for the same problem some
days ago. I think my patch is more consistent with the behaviour for
other options.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
