From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 07 May 2014 15:37:50 -0500
Message-ID: <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:48:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8le-0002uv-Ik
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbaEGUsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:48:37 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:38336 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbaEGUsg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:48:36 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so1979377oag.12
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=f6uOccHS8YfQ42qSB/B6ltiSLn5nGbXyF5jWl9eywqQ=;
        b=GF7tPtGA4L3gV5OB+HQhGcBUS2eXXrv66yXGAt/ji9cDyi13RM2boNvX+s4pnJsrS2
         g+pFQ1tOmTIhU5oqwvpCezaUDWdomz1aImFvlzWcoUsuJ3AK742S5W0NvAIxapfe/y4b
         KNVL/Tdlij2EL9br1bStkqIqt8dLDKKSP0oreV5hwojVgzFMlxNJnrxw2me+JAovt8fo
         vzlWKRQp9lec3V7GHVKnNY5jiRWDnSXFxYGG0JpqaAtrT98Eunr6xniwBwbFH8vbCuIP
         4ybDwwGzf8M4Q8bm+Kz4WPVxphQKApw7pLZIpauwYgFtLG8G4oOd0uX5IhO14Ub1m1aI
         ZHng==
X-Received: by 10.60.45.35 with SMTP id j3mr6132609oem.68.1399495716076;
        Wed, 07 May 2014 13:48:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ci10sm70500132oec.0.2014.05.07.13.48.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 13:48:34 -0700 (PDT)
In-Reply-To: <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248368>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Really? Based on what reasoning? I have proven his reasoning to be
> > basically wrong.
> 
> Perhaps s/proven/convinced myself only/; you didn't prove it to me
> and I doubt you proved it to John.

And you are still conveniently avoiding the question:

Based on what reasoning?

> > Of course it wasn't a mistake.
> 
> I doubt about the "Of course" part.  The first reaction after seeing
> that the new "changegroup" is used only inside check_version(3,0)
> and nowhere else was to wonder if that import is necessary (or even
> safe) for the pre-v3.0 versions.

I don't care about your first reaction. If that was only present in
newer versions, how do you think it would pass the testing on older
versions?

https://travis-ci.org/felipec/git

Normally I would explain the details of why this is the case, and send
the crash regresion fix for v2.0 with a clear explanation, but since you
are adamant in threating git-remote-hg/bzr as just another crappy
contrib script that doesn't even have tests like diff-highlight or
hg-to-git. Why would I care?

The fact that I'm the maintainer and I say it'ss good should be good
enough, and if the current version in "master" renders unusable the
existing Mercurial clones, hey, it's only in contrib, right?

-- 
Felipe Contreras
