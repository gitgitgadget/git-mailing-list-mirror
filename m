From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest namespace change
Date: Sat, 18 Aug 2012 23:11:33 +0200
Message-ID: <B88EFDF9-0AB6-49AC-87E5-7515B99AE601@gmail.com>
References: <20120719213311.GA20385@sigill.intra.peff.net> <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu> <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 23:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2qJ6-0002L4-87
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 23:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab2HRVLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 17:11:39 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59207 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab2HRVLh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 17:11:37 -0400
Received: by eeil10 with SMTP id l10so1438457eei.19
        for <git@vger.kernel.org>; Sat, 18 Aug 2012 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=CmrLHA3hV/uYVYQ+PyfWEh1FpTFShQlF7va0FjDKRAs=;
        b=q7s9yZ+XIMUQFI1ay6EwEHXM/I0WazQjfZwDeAzS48tu97+V8/tiDMK+Dm7CZXMU6a
         1kbXuHa3rJvLtJHeYQ6Ca9Dtt0TKT6FZURE4PEI14yhoQqUZGNcxNWi++poiEsfso66J
         zV+Knk5r0IDXQlBIUqgU0XP8IC0eNVqu4emNhFnbzhB0ORhWulh6pPGLJNAKu8nq2nlU
         CM8qinMgkxQHdN4DvpZsTQBq1LkK3RIYv5dyGJde6nC538u1JFo+YxeM6tNqHyPM5lxn
         QEsX6vftM8jNbw0XUKG/H4r3MbfkI2VqXqIRHvlUqeSrIkQxhGQg5UvV8NH4t2O10VJ3
         nmIg==
Received: by 10.14.172.129 with SMTP id t1mr2549842eel.34.1345324296248;
        Sat, 18 Aug 2012 14:11:36 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id u47sm29540647eeo.9.2012.08.18.14.11.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 18 Aug 2012 14:11:35 -0700 (PDT)
In-Reply-To: <7vboi8rl2q.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203701>

On 18 Aug 2012, at 22:39, Junio C Hamano wrote:

> Do we _know_ already what the "ultimate destination" looks like?  
> 
> If the answer is yes, then I agree, but otherwise, I doubt it is a
> good idea to introduce unnecessary complexity to the system that may
> have to be ripped out and redone.
> 
> I didn't get the impression that we know the "ultimate destination"
> from the previous discussion, especially if we discount the tangent
> around "having next and next/foo at the same time" which was on
> nobody's wish, but I may be misremembering things.

Excuse me if i miss something again, but i might be willing to discuss the "ultimate destination".  Could you possibly state in simple terms what the problem with determining the "ultimate destination" is?  I hope my opinion might be useful because i do not know anything about the actual implementation of Git, but for a while i thought i was understanding it's intended mathematical model, until i ran into unexpected for me default behavior of not pruning when fetching.

To just give a quick idea of my ideas, i thought that 'fetching' in Git was an inevitable evil that stands apart from other operations and is necessary only because the computer communication on Earth is not sufficiently developed to keep all Git repositories constantly in sync, and because one might prefer to work with a somewhat dated snapshot of a remote than with the constantly changing current version. I thought "snapshot" could be a good alternative name for "fetch".

-Alexey.