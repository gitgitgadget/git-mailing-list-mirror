From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 14:47:32 -0400
Message-ID: <201405281847.s4SIlW5K027160@hobgoblin.ariadne.com>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com> <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com> <201405281815.s4SIF5hF025886@hobgoblin.ariadne.com> <alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz>
Cc: pclouds@gmail.com, git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Wed May 28 20:53:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpiyt-0001RP-SE
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbaE1Sxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:53:40 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:56450
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827AbaE1Sxj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 14:53:39 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 May 2014 14:53:39 EDT
Received: from omta06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id 7VQq1o00316LCl05EWnZUi; Wed, 28 May 2014 18:47:33 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta06.westchester.pa.mail.comcast.net with comcast
	id 7WnZ1o00C1KKtkw3SWnZqa; Wed, 28 May 2014 18:47:33 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id s4SIlW6u027161;
	Wed, 28 May 2014 14:47:32 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id s4SIlW5K027160;
	Wed, 28 May 2014 14:47:32 -0400
In-reply-to: <alpine.DEB.2.02.1405281121200.32611@nftneq.ynat.uz>
	(david@lang.hm)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1401302853;
	bh=0sbIFtmdp7WBKuS0gKaAHfVD8GCRWYOdm5jkPP82vLg=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=V2gzcuGMM+Q+bS2fMcel1zfjD5rdwCHJ93svGEtxUbGlj+aoHi8aTJlwCit6qV19k
	 vJzFVy5eRAobtrpJhFFVC0qtuwB31FnNQftndejIZnZ4M8aMz1eG+aKOBwif95i1Fj
	 CRDTFaLtOteJiDbIuMOYuvsP4vz9DlBBlXPrWK9846MTAuMzJRzfqVFrqJD7TDDD/O
	 ff4Bk7Axwa0Qd7MeTISxE6NzttmI9TDWLQczcOZYMNtMFNSkmMxYtXHHtV2ekl6yza
	 ePi3Lej0iOKoJ9sEM7f+AiRz8HpzeGlSO8OkOnN7g4pobJ0GqZ8p6IIp1+wBZ4NCAt
	 fDdUPiutnQybA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250313>

> From: David Lang <david@lang.hm>

> Git was designed to track source code, there are warts that show up
> in the implementation when you use individual files >4GB

I'd expect that if you want to deal with files over 100k, you should
assume that it doesn't all fit in memory.

Dale
