From: Phil Hord <hordp@cisco.com>
Subject: Re: git push vs. slow connection times - local commit resolution
 is too late
Date: Sun, 17 Jul 2011 15:46:28 -0400
Message-ID: <4E233C14.6080309@cisco.com>
References: <4E1EEDAA.1000204@redhat.com> <4E2115D5.4010002@cisco.com> <m2oc0uz8uh.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Blake <eblake@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Jul 17 21:46:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiXIR-0008Gl-SU
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 21:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245Ab1GQTqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 15:46:30 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:11850 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1GQTq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 15:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=432; q=dns/txt;
  s=iport; t=1310931989; x=1312141589;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=yL+qAGOZjkFd7haetPZc7kXokGLn+xmjlMAz8jCs7bM=;
  b=lxFbf39D5mQy8Srni/L+LbATNTpdXw1FkBxn8y0+Gs+3xyFDndO7Mjy2
   EagQ1chGbWlEEjpqJttS0PBcRz9Bs3BEakl/JZvXmNiarLxtRMROb/8jP
   qVkbZOKrL5WOZ8WP537hGxFWArtOirJ0/yOZEFssvz3aZupvJV1ygkMP6
   Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EACA7I06tJV2c/2dsb2JhbABRp3J3rSydEYY8BJJmhQGLcA
X-IronPort-AV: E=Sophos;i="4.67,218,1309737600"; 
   d="scan'208";a="3755849"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-1.cisco.com with ESMTP; 17 Jul 2011 19:46:29 +0000
Received: from [10.82.241.167] (rtp-vpn2-423.cisco.com [10.82.241.167])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id p6HJkSZq014372;
	Sun, 17 Jul 2011 19:46:28 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110627 Thunderbird/5.0
In-Reply-To: <m2oc0uz8uh.fsf@igel.home>
X-TagToolbar-Keys: D20110717154628296
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177317>

Andreas Schwab helpfully chimed in
 > Phil Hord <hordp@cisco.com> writes:
 >
 > > I agree with your suggestion.  But as a quick fix, can you do this?
 > >   git push remote $(cat .git/HEAD):master
 >
 > You mean $(git rev-parse HEAD), don't you?

Yes, I do. :-) But I don't use it enough to remember it, and the man 
pages are not cross-referenced well enough for me.  So I shrugged.

Thanks for helping me out.

Phil
