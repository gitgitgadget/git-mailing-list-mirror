From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Sat, 24 Jul 2010 13:02:39 +0200
Message-ID: <20100724110239.GA13067@vidovic>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OccVM-0006nN-Mz
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab0GXLCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 07:02:45 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47554 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab0GXLCo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:02:44 -0400
Received: by wwj40 with SMTP id 40so5466569wwj.1
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=33A4zeQn4XRHvmQH4ZOVSeOdi03QvtOVYG5FEf+GNJU=;
        b=VcHY3feyLSjbdUykjyzy2mNygisismTGCRR1dvHFFPptZKpWs/kCdXpdarJBaXg//s
         ekNaQpeSAWtHRLkrEbB6odrLz96ITYMJH4vXR8Om6XrgU7yUL72KxSBzjV1VIWD+zPv2
         q9tPkq+IcQQ5+1QJH5Ni4ymY4lUpSMRawN4bM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GbGM1l5i+jNrD7pRjGicVErJX2x94Ask62io0PwvcaZrs9Czr8wuyrCvF+ibxHrqxQ
         +46NYIUIptWOGWoW0MSLbj+7od6EAxHNxlMiBibfYl+k1uh7ygq27cC8221Yg5JS+LpJ
         YviVIR/twidVpjQiGkyaF/C+WN+lOc9Cas1SU=
Received: by 10.216.60.84 with SMTP id t62mr4712180wec.73.1279969363168;
        Sat, 24 Jul 2010 04:02:43 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id v11sm680372weq.40.2010.07.24.04.02.41
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:02:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151609>

The 22/07/10, Junio C Hamano wrote:

> Somebody off-list suggested removing gitk and git-gui directories from my
> repository and I've been playing with the idea and kind of like the end
> result.

What is the issue with the current status?

> The plan (I am not decided to buy into it yet, hence I am sending this
> rfc) is to:
> 
>     - remove gitk-git and git-gui directories;
>     - add modules/gitk and modules/git-gui submodules;
>     - teach the top-level Makefile about the new location of these two
>       packages.

Going this way, why would we want gitk and git-gui as submodules at all?
They are porcelain tools as many other not in git.git.

-- 
Nicolas Sebrecht
