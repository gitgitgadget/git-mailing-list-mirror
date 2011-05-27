From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Fri, 27 May 2011 10:17:48 +0200
Message-ID: <20110527081747.GA7049@camk.edu.pl>
References: <4DC0E99E.6090402@viscovery.net>
 <20110504135827.GC18585@camk.edu.pl>
 <4DC1653A.7000000@viscovery.net>
 <7v4o5afht7.fsf@alter.siamese.dyndns.org>
 <7vwri5c27e.fsf@alter.siamese.dyndns.org>
 <20110505142910.GA31229@camk.edu.pl>
 <4DC2B814.5070507@viscovery.net>
 <20110505150036.GB31229@camk.edu.pl>
 <7vd3jxb16s.fsf@alter.siamese.dyndns.org>
 <4DC7A4D7.2050401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 27 10:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPsF9-0004u2-6l
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 10:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227Ab1E0IR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 04:17:56 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:49829 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274Ab1E0IRz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 04:17:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id B6DF05F0048;
	Fri, 27 May 2011 10:17:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J7-aIS75VyzJ; Fri, 27 May 2011 10:17:48 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 45F2B5F0046;
	Fri, 27 May 2011 10:17:48 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 36AB180A77; Fri, 27 May 2011 10:17:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC7A4D7.2050401@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174602>

On Mon, May 09, 2011 at 10:24:55AM +0200, Johannes Sixt wrote:
> Am 5/5/2011 17:46, schrieb Junio C Hamano:
> > Kacper Kornet <kornet@camk.edu.pl> writes:

> >> Should the patch be based on main or on the previous patch that was
> >> merged to next?

> > After having this much discussion, it is preferrable to have a patch
> > relative to what you have in 'next' (2910bf5) as a fix-up, explaining "The
> > initial version does not cover these cases / has these problems" to
> > summarize the discussion so far, followed by explanation of the
> > incremental change "Fix this and that by doing ...".

> > We could revert what is in 'next' and start from scratch, but then it is
> > likely that the thought process will be lost when you write the log
> > message.

> I'd implement it like this, discarding Kacper's patch, but I'm not sure
> whether the commit message summarizes the discussion sufficiently. Let me
> know whether you want a version based on top of Kacper's patch, or how
> else to proceed.

> Of your two patches regarding configure --sysconfdir, only the second
> (e8de44bc05) is needed on top of this patch.

I'm afraid e8de44bc05 was lost somewhere, as 1.7.5.3 does not contain
it. 

-- 
  Kacper Kornet
