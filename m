From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix translation of strings in foreach lists.
Date: Tue, 24 Jul 2007 11:01:36 -0400
Message-ID: <20070724150136.GM32566@spearce.org>
References: <1282.25717.qm@web38901.mail.mud.yahoo.com> <20070724112701.ndpm5fxaocks804s@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 17:02:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLtl-00075W-09
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 17:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbXGXPBx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 11:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbXGXPBx
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 11:01:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42107 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXGXPBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 11:01:52 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IDLtE-0006ru-R5; Tue, 24 Jul 2007 11:01:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D620C20FBAE; Tue, 24 Jul 2007 11:01:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070724112701.ndpm5fxaocks804s@webmail.tu-harburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53606>

Christian Stimming <stimming@tuhh.de> wrote:
> Fix translation of strings in foreach lists.
> 
> Signed-off-by: Christian Stimming <stimming@tuhh.de>
> ---
> Quoting Brett Schwarz <brett_schwarz@yahoo.com>:
> >I not sure if it's worth changing, but you don't necessarily need   
> >those [append]'s in there.
> 
> Thanks for the info. It is basically up to Shawn to decide which style  
> he likes more.

"[mc Foo]\n\n$err"

is much shorter.  So I'd prefer that over [append [mc Foo] "\n\n$err"].
Its not like you've saved a dq-eval either, as you still have to do one
for the \n\n.  But either way is valid Tcl, and works, and the append
version is not so bad that I'd reject a patch that used it.
 
-- 
Shawn.
