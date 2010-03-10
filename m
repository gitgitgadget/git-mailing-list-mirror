From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/1] gitignore: do not ignore include/linux/
Date: Wed, 10 Mar 2010 02:25:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1003100223090.30021@chino.kir.corp.google.com>
References: <4B90CBE5.9090102@viscovery.net> <1267780845-10547-1-git-send-email-jslaby@suse.cz> <m3pr3jkq26.fsf@localhost.localdomain> <4B9120F2.2020000@gmail.com> <alpine.DEB.2.00.1003100205170.17698@chino.kir.corp.google.com>
 <2375c9f91003100211vbe66a49g1bec37b2dcf609c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="531400454-795328965-1268216754=:30021"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jirislaby@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 11:26:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpJ7J-0006M8-DY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 11:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab0CJK0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 05:26:03 -0500
Received: from smtp-out.google.com ([216.239.44.51]:21906 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab0CJK0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 05:26:00 -0500
Received: from spaceape11.eur.corp.google.com (spaceape11.eur.corp.google.com [172.28.16.145])
	by smtp-out.google.com with ESMTP id o2AAPxGZ021041;
	Wed, 10 Mar 2010 02:25:59 -0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1268216759; bh=lB1y0RXIiTeEZLyr0qPGeIKQqG8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	b=u5F5Pu1144XJ3yX3hTjW/G2tryhbIxQTU58hO3rVSN8xYtToFR1Qwk7FxGhmVjL4e
	 3zNteQsIW6xPW6KPm7fRg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id:
	references:user-agent:mime-version:content-type:x-system-of-record;
	b=g8+0/jBpm9uLv12ab3TZBohxMnPE/R/kqM//Ygxaf0PlcDSCrXJa10nt+2WrmoxaR
	4Gi2g0aGJ88T8XP4QjTnA==
Received: from pwj10 (pwj10.prod.google.com [10.241.219.74])
	by spaceape11.eur.corp.google.com with ESMTP id o2AAPu40016571;
	Wed, 10 Mar 2010 02:25:57 -0800
Received: by pwj10 with SMTP id 10so4452761pwj.24
        for <multiple recipients>; Wed, 10 Mar 2010 02:25:56 -0800 (PST)
Received: by 10.142.247.21 with SMTP id u21mr368961wfh.85.1268216756111;
        Wed, 10 Mar 2010 02:25:56 -0800 (PST)
Received: from chino.kir.corp.google.com (chino.kir.corp.google.com [172.31.6.135])
        by mx.google.com with ESMTPS id 21sm7096803pzk.8.2010.03.10.02.25.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 02:25:54 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
In-Reply-To: <2375c9f91003100211vbe66a49g1bec37b2dcf609c2@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531400454-795328965-1268216754=:30021
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 10 Mar 2010, Américo Wang wrote:

> >> >> +!/.gitignore
> >> >> +!/.mailmap
> >> >
> >> > Actually you want to *not ignore* .gitignore and .mailmap (and
> >> > .gitattributes which is missing here) anywhere, not only as top-level
> >> > file.  So .gitignore and .mailmap should not be prepended with slash.
> >>
> >> <and moved out of the 'Top-level generic files' section then>
> >>
> >
> > Please either revert 3b2a8c8f3c65 or merge the fixed up patch for
> > 2.6.34-rc2, otherwise include/linux will continue to be ignored by git
> > just like it is for 2.6.34-rc1.
> 
> Why not apply the patch from Jiri? Since this problem is introduced
> by new version of git, not that commit.
> 

Like I said, please either revert the commit that added "linux" to 
.gitignore or merge Jiri's patch.  I'm not interested in engaging in a 
discussion about what can or cannot be merged during rc cycles, I just 
hope this is resolved for rc2.
--531400454-795328965-1268216754=:30021--
