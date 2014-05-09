From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 23/25] contrib: remove 'hooks/multimail'
Date: Fri, 09 May 2014 10:18:51 -0500
Message-ID: <536cf1db3a623_ce316372ecdf@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-24-git-send-email-felipe.contreras@gmail.com>
 <536CED9B.3080706@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 17:19:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WimZg-0001n9-3d
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 17:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbaEIPS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 11:18:56 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:65179 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420AbaEIPSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 11:18:55 -0400
Received: by mail-yh0-f49.google.com with SMTP id c41so3839882yho.36
        for <git@vger.kernel.org>; Fri, 09 May 2014 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=s0T23ibFl4sValojWiWyy5N36wLlgSRFTC/uB3OhbwY=;
        b=ZWi5TUXfNZ85cect8LQTG33nv9hbVjWDll3vdgpuxW3f1sXIkyfKALd4fH5bkZOTaC
         hkUPZa5OoR2yn5qVM8ZqzINjKC12ZEfPX+MmvsIrDgm+3W8AMq02CtLEYD5/WI3/nlyM
         /bWkjzMPG2ZTXhJLkj2uFA9raqzaU/lFOpyMX5p8X1MGeGLtYqIiDkdBMe5Pt8ZW9THU
         RR7w1QnQyXhP6a66aq+HyyUugD/8OfWbUrjwUalocl6vXplrTWsnUpaJjg61f6oi0bPw
         Wd2Jc1tpwZS7jnc9fhihxBrG2KzFi4U5RyXUmzJu3NbzjDIrgHaqbMub8vwWiMNfhmYd
         G6WQ==
X-Received: by 10.236.209.68 with SMTP id r44mr6551732yho.152.1399648735003;
        Fri, 09 May 2014 08:18:55 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d43sm6563355yhb.10.2014.05.09.08.18.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 08:18:53 -0700 (PDT)
In-Reply-To: <536CED9B.3080706@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248569>

Michael Haggerty wrote:
> On 05/09/2014 02:58 AM, Felipe Contreras wrote:
> > No tests. No chance of ever graduating.
> > 
> > Already out-of-tree.
> > 
> > Cc: Michael Haggerty <mhagger@alum.mit.edu>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> 
> Thank you for your input.
> 
> git-multimail is maintained outside of the Git project and is only
> distributed along with Git as a convenience to Git users.

I do not see anywhere in contrib/README any hint that contrib is meant
for that.

> It does in fact have a test suite, along with some other bits and bobs
> that are not needed to use it, in the upstream repository at
> 
>     https://github.com/mhagger/git-multimail

Good to know. But IMO the tests should be in git.git as well, or nothing
at all.

> What's more, it has a maintainer who doesn't routinely insult other
> people on the mailing list,

Aaand skiping the rest. Good bye.

-- 
Felipe Contreras
