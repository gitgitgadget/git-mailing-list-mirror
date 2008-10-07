From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [msysGit] [FYI][PATCH] Customizing the WinGit installer
Date: Tue, 7 Oct 2008 07:08:24 +0400
Message-ID: <20081007030824.GW21650@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0810061621110.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081006141840.GO10360@machine.or.cz> <alpine.DEB.1.00.0810061718240.22125@pacific.mpi-cbg.de.mpi-cbg.de> <m3zllhpvby.fsf@localhost.localdomain> <alpine.DEB.1.00.0810061810360.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061031380.3208@nehalem.linux-foundation.org> <alpine.DEB.1.00.0810061959280.22125@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.LFD.2.00.0810061246460.3208@nehalem.linux-foundation.org> <20081007015336.GU21650@dpotapov.dyndns.org> <alpine.LFD.2.00.0810061909260.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 05:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn2xD-0004tZ-WE
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 05:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338AbYJGDId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 23:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756296AbYJGDId
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 23:08:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:33547 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbYJGDIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 23:08:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2169614fgg.17
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y8e0GtxElTVD3Rds9ExxVxgQYLPmHIKsTo23n8REDFg=;
        b=md3WHeWfRQRBrwKS5HAwaU6P2sL1m8AfIJZijv8Cra1IOcoQJ2PCNGnxxzfVmIGpv1
         GoM6PbfyCfswdgk8YiQtYWGeiI3xhotSY6emhbKp6YZfWUuiWmhpd8mTwB+9ZHJ2pXDt
         j5Oc49KNCFgLB8XJMtAsnQrjfEd4FhQOI3I08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=p124mRB4REj9QnqisNoxle2HaoF/3UGCmyFej5R6NjYPxHoKDtsI+iHpJo2BMnkilh
         CUD0gPObuaJABV3sxWclaWaa5wmihcVktV8JjHd2x3eVYQaIW3mjna6TJaNL94bUGPpC
         qTP7qflcQB0ggrO6nu9nAiviRivFywmnN+kSY=
Received: by 10.86.82.6 with SMTP id f6mr1237256fgb.28.1223348909132;
        Mon, 06 Oct 2008 20:08:29 -0700 (PDT)
Received: from localhost (ppp91-77-160-5.pppoe.mtu-net.ru [91.77.160.5])
        by mx.google.com with ESMTPS id d6sm12538090fga.2.2008.10.06.20.08.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 20:08:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810061909260.3208@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97659>

On Mon, Oct 06, 2008 at 07:10:37PM -0700, Linus Torvalds wrote:
> 
> That changes things. Once some user actually complains, and sends in a 
> fix to make the whole dialog optional, I don't see why anybody would ever 
> argue against such a patch being accepted.

First, he did not complain. He did not even mention that in the commit
message. He mentioning some other things like removing release notes,
but not the license. Second, I would expect that any change that goes
against the previous achieved agreement may deserve some discussion,
and not blindly accepted just because the user sent a patch. Okay, I
don't really care whether the installer shows the license or not...
Perhaps, something like Help|License would be a better place for it.

Dmitry
