From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/5] fc/transport-helper-sync-error-fix rebased
Date: Sun, 20 Apr 2014 16:12:04 -0500
Message-ID: <535438246097c_4c30158d2ec11@nysa.notmuch>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
 <1397890843-27035-1-git-send-email-gitster@pobox.com>
 <535413cbc7eaa_1f08dd12eca5@nysa.notmuch>
 <7voazvlna8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:22:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzCL-00023K-4e
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaDTVW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:22:26 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:60192 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaDTVWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:22:25 -0400
Received: by mail-yh0-f52.google.com with SMTP id 29so1059554yhl.39
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 14:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=uOpAmOp7jYMKGRz3LAW2rbQPxV9F6DVEUdYSOKYZr0k=;
        b=TjsYKOov6QgSxKNfOrfrJI6Akb95RV2IH80BR8xP1WJTaMpISFlQa+nhbHgZDjiG05
         nasDii+bHtLwAUARfz5G46L9ZtpOfM4RlptM7GfBaQPzqR86CnWdbkfte+i7+hHIy5YU
         C5NQiduirVJhQxCj32In31rXqQn0oY8uwiOpimL/tILpSnfn5yqD5Kgu0f/ibkcq9R9o
         FbnbQXCHqMLiX/0Fl2Ek/USoG8XQ47rl44BVUStpXrbz6utzcH9h5aMh++XNklzI9yKL
         xMtbxCEGpX7cgZezVmMpmbeez5fUKPViCT40L1HbULXDHf17DkAcflsq4NIXcnBrmLDS
         /Fcg==
X-Received: by 10.236.66.3 with SMTP id g3mr48290134yhd.41.1398028944528;
        Sun, 20 Apr 2014 14:22:24 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t9sm65910636yhg.18.2014.04.20.14.22.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 14:22:23 -0700 (PDT)
In-Reply-To: <7voazvlna8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246586>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >> As I have said in the recent What's cooking reports, the original
> >> posted here were based on older codebase and needed to be rebased,
> >> but it had some conflicts and I wanted to see the result double
> >> checked by the original author before we can merge it to 'next',
> >> cooked there and hopefully merged to 'master' before tagging -rc1.
> >> 
> >> So here is the series that has been queued in 'pu' for the past
> >> several days.
> >> 
> >> Felipe, can you double check it?
> >
> > These patches don't help much,...
> 
> What do you mean by that, exactly?  As long as your "don't help
> much" is "would not hurt and will help some even for a small subset
> of audience", that would be OK, but I am puzzled.

I mean if purpose of these was for me to review the changes you did, it doesn't
help as much as an interdiff does.

> My reading of your responses to bug reports and the cover letter of
> the series has been that these were real fixes to a real problem
> without downsides, and that you consider that they are good changes
> to have in the upcoming release.
> 
> I am hoping that you did not mean that we shouldn't merge it to the
> 'next' and 'master' branches, but if that is what you meant, can we
> hear what the downsides of the series are?
> Are they more churn than they are worth without solving the real
> issue?  Do they regress for some repositories/workflows while
> improving for others?  I didn't get such an impression.

That's not what I meant. The patches are good.

> > ..., I did and interdiff with my own fixes and this is the result:
> > ...  I don't like it, but it's OK.
> 
> Correct.  Following the coding style of the project is not the
> matter for your liking or not liking.  It is part of being on the
> same codebase with other participant of this project.

There's nothing in Documentation/CodingGuidelines that says multiple piped
commands should be one on each line even if togther the line doesn't exceed 80
characters, nor does it says that file names should be between quotes, even if
the file name can't possibly have spaces.

These are just your arbitrary rules, not the guidelines of the project.

And BTW, the fact that something is a rule doesn't mean it's good; rules change.

-- 
Felipe Contreras
