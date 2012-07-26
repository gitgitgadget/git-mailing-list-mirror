From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 01/16] Implement a remote helper for svn in C.
Date: Thu, 26 Jul 2012 03:14:43 -0500
Message-ID: <20120726081443.GA4720@burratino>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1343287957-22040-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120726074607.GA4455@burratino>
 <1707449.hNcpMgVJxF@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 10:15:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuJDo-0000jn-0r
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 10:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200Ab2GZIOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 04:14:54 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:61655 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab2GZIOw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 04:14:52 -0400
Received: by gglu4 with SMTP id u4so1654246ggl.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JA4AmtarLCYl168necMNhfhMe3r8Vv/ZhD0XsxLj64U=;
        b=Rvlm/Ul1GG9Lsapyy3HJeq6N9Ewv2n+llpc9TTlCWLHhyPRu6c82CNcxCWwnGFSuQd
         5zTPKSP6J9NksqiHoaZcuPLQCqedMflVssqLuS2SlxOvK24zQ5SA9Hqx58JSaiK0M6Q4
         3a2sNfykqxWdxeM/+MJ93KtD5KL/yDvbPUx5QnChnj0M9oBwTszSaUKFJDNItY2v8EYX
         FhZP2nuyaUFXnVCJaCx1BLoG0wSz/mNQz3QSPbkuo75fcX76CBvTXrdEoIObZ2EddCG8
         IM6u5Ls2cUr1Xt5+6pQtrPzscj6bMWNbskHrC2js7Az0w7GswRonBerH0VrEvjuN2z67
         fs/A==
Received: by 10.42.80.6 with SMTP id t6mr27731603ick.15.1343290491340;
        Thu, 26 Jul 2012 01:14:51 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id if4sm2897153igc.10.2012.07.26.01.14.50
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 01:14:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1707449.hNcpMgVJxF@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202249>

Florian Achleitner wrote:

> Yes, I incorporated your review in the new version, as far as applicable. But 
> I didn't send you an answer on the detailed points. 
> I will send an answer to the previous review ..

Thanks.  Now that I check, I see that you did make lots of important
changes and probably lost the one I noticed just now in the noise.

Another way to keep reviewers happy is to describe what changed since
the last revision under the triple-dash for each patch when sending
out a new set of patches.  That way, they can see that there was
progress and there is less frustration when one specific change didn't
make it.

See http://thread.gmane.org/gmane.comp.version-control.git/176203
for example.
