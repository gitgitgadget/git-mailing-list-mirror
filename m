From: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Thu, 12 Apr 2007 10:18:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0704121016240.29621@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org><Pi
 ne.LNX.4.64.0704092115020.6730@woody.linux-foundation.org><461D6432.90205@v
 ilain.net>    <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org><461D6858.4090
 007@vilain.net>   <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org><Pine.LNX.4.63
 .0704111600390.28394@qynat.qvtvafvgr.pbz> 
 <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org><Pine.LNX.4.63
 .0704111628240.28394@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 19:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc3QQ-0005dW-KS
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 19:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030524AbXDLRte (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbXDLRte
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 13:49:34 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:45306 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1030524AbXDLRtd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 13:49:33 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Thu, 12 Apr 2007 10:49:32 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Thu, 12 Apr 2007 10:49:23 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44345>

On Wed, 11 Apr 2007, Linus Torvalds wrote:

> So I tend to think that alternates and shared object directories are
> really for "temporary" stuff, or for *managed* repositories that are at
> git *hosting* sites (eg repo.or.cz), and where there is some other safety
> involved, ie users don't actually access the object directories directly
> in any way.
>
> So I've at least personally come to the conclusion that for a *developer*
> (as opposed to a hosting site!), shared object directories just never make
> sense. The downsides are just too big. Even alternates is something where
> you just need to be fairly careful!

I was actually thinking that hosting sites (and things like gitorrent) would be 
the ones that would get the most benifit from shareing objects. the amount saved 
for any individual developer is probably fairly minor (and the individual 
developer could run a script to look across their objects and hard-link them 
togeather if they care about the space)

David Lang
