From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Sun, 27 Apr 2008 22:22:47 +0200
Message-ID: <4814E097.7030407@gnu.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org> <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org> <20080427043014.GI29771@spearce.org> <20080427044049.GJ29771@spearce.org> <7vabjflvlh.fsf@gitster.siamese.dyndns.org> <20080427173446.GM29771@spearce.org> <7vy76zf449.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:23:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqDPO-0006XK-Pq
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 22:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbYD0UWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 16:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbYD0UWv
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 16:22:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:19568 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbYD0UWu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 16:22:50 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4637688fgb.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2008 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=rQ/oC/UPID3T8zbYYIleOz777eu1pkDdmcH+n7Pspss=;
        b=iZeoTBPqmxDWAwpcRSXwK5PD47O78ILs5DJl9vHh6+mdvudgVcOMSYepIO0MAgfzLRHfHFqENJEZhK7mxIueHqW1D9sXxNm94YqiYDD/HjuzA+3DIArvn1rOVlY3CDofzQOaDJC4GMR/NsRkS+w/Blx8vl5P9yqh31vltblA0dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=HQPl90Vdpm4Zqs/X2+l5Wk6FnKkd6C6SrYL7F2I0BOhzDztHZB8bkVc/A0rXlJuwaeE2dk5s2zYSBJVLhPyqlEoHDFE8z3uqnYi/gUYlctociOZMmXryRiYoVEW5YwYeD1gwbJFjyzNguQ6f1Kpda0swFY9Q9KayRVT9Ovs2sWo=
Received: by 10.86.3.4 with SMTP id 4mr6285422fgc.28.1209327768760;
        Sun, 27 Apr 2008 13:22:48 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id 4sm3923228fge.3.2008.04.27.13.22.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Apr 2008 13:22:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7vy76zf449.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80482>

> What's the constructive suggestion for improvement we can draw from this
> after all?  Should we deprecate the defaulting of "origin" so that
> everybody now should always say "git pull $where"?

branch.*.remote would still provide a default, wouldn't it?  And if 
master is by default set up to track origin/master, the behavior 
wouldn't change.

> In other words, make
> people more aware that what _they_ do is the special case to have only one
> remote to interact with?

I think "git pull" is different, because it is more often fetching from 
one defined place (while Shawn said that he has a need for one-to-many 
"git push"es and so do I).  For "git pull", the branch config provides a 
valuable default more often than for "git push".

Paolo
