From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Tue, 15 Apr 2008 11:43:24 -0700 (PDT)
Message-ID: <m3ej97rmc0.fsf@localhost.localdomain>
References: <20080415172333.GA29489@linux-sh.org>
	<alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 23:02:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlsH2-0004IO-VD
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 23:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbYDOVAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 17:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbYDOVAQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 17:00:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:63950 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbYDOVAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 17:00:13 -0400
Received: by nf-out-0910.google.com with SMTP id g13so629382nfb.21
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 14:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=NVdPq7MhAqov0CQBPp87YpXDtktEkFWujYseny7AKBk=;
        b=Q/+Qj0rJpPNQK1sVA01nQwcNs3yThPFECiT65nTnNlhYcmn+gWTTYKx9EpJNRaQ/BV3g6sXSnVb63RvcDsZ8AUNkR96oDqdcyxFvoa/FNkLv1d4VyJAbJCGjBMk72p8CabaZnnIEe+Bvs3xK8lniV3tjSBK21kboOzfootuwDXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=t0wwl7Qop0Lc08FZSR4ILudyERVRfhnlAyC5JlcLQBOwezLrc5+OhXp4ber5Iu7jfr80W0yCFhiafwWvsfN5C/J7tBQgbVTlWfAnKDBQa0LBRZf+Hxn5XSqRLJEcLuru6bYJlE8y8E2bKI1JKcNtshCsL3Xs/MtwBOlcQQoVVtM=
Received: by 10.78.132.2 with SMTP id f2mr59942hud.19.1208285006132;
        Tue, 15 Apr 2008 11:43:26 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.244.53])
        by mx.google.com with ESMTPS id v33sm3057702hub.60.2008.04.15.11.43.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 11:43:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3FIhJOJ021484;
	Tue, 15 Apr 2008 20:43:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3FIgt9f021478;
	Tue, 15 Apr 2008 20:42:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79628>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Paul, your git tree is odd. Not quite corrupt, but it doesn't really 
> follow the rules either.
> 
> In particular, it has empty lines at the top of those commits, and I 
> wonder how you created them. 

> The reason I noticed is that it screws up the git merge summary, which 
> will take the first line of each commit it merges (_without_ the "skip 
> empty lines" logic) to generate the summary of the merge.
> 
> I think we should fix that git merge summary code to allow for this bad 
> behaviour, but I also want to know why such corrupt commits exist in the 
> first place. What toolchain do you use to create that commit? We should 
> fix that too!

I seem to remember (but I might be mistaken) that this issue was
corrected by some patch on git mailing list already...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
