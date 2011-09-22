From: Daniel Johnson <computerdruid@gmail.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Wed, 21 Sep 2011 21:14:16 -0400
Message-ID: <119711285.RuumktFLOq@hyperion>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com> <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 03:14:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6Xry-0006JL-8X
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 03:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab1IVBOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 21:14:20 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55674 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1IVBOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 21:14:19 -0400
Received: by vcbfk10 with SMTP id fk10so101887vcb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=EzrqgC3AYV9ugmcc30+rimIseaYh0Yrtf2KqwydTYso=;
        b=Wnhyt4u/w+CNWDIJ3a+GYhuM+VDoHFqTRjvt7sYshGM9AwaeiErvIERIuCKBFDdRpH
         n6Pm11bThem/fjWosUs9KRBsy9YYFSwMXhHrTIvuN1SXQpEFIX+Qci/vM+IT2UxOOvUX
         Bqi1lFdl+eF7iDBWMJsJhFwO/yDYsh5CUpEbQ=
Received: by 10.220.117.70 with SMTP id p6mr373740vcq.22.1316654058422;
        Wed, 21 Sep 2011 18:14:18 -0700 (PDT)
Received: from hyperion.localnet (hyperion.student.rit.edu. [129.21.115.228])
        by mx.google.com with ESMTPS id l16sm5261789vdf.7.2011.09.21.18.14.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Sep 2011 18:14:17 -0700 (PDT)
User-Agent: KMail/4.7.0  (Linux/2.6.38.2; KDE/4.7.1; x86_64; ; )
In-Reply-To: <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181871>

On Wednesday, September 21, 2011 04:52:56 PM Anatol Pomozov wrote:
> @@ -63,7 +63,8 @@ ifndef::git-pull[]
>  	flag lets all tags and their associated objects be
>  	downloaded. The default behavior for a remote may be
>  	specified with the remote.<name>.tagopt setting. See
> -	linkgit:git-config[1].
> +	linkgit:git-config[1]. Note that if this option is specified
> +	then only tags are fetched, refs under refs/heads/* stay unchanged.

I like this clarification. It would be better placed before the note about the 
tagopt setting, as it clarifies the statement before that ("This flag lets all 
tags and their associated objects be downloaded.")

In fact, the optimal solution might be to rework that sentence with the 
clarification from yours, so something like "This flag lets all tags and their 
associated objects be downloaded instead of"...
