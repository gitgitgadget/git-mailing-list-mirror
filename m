From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] symbolic-ref: trivial style fix
Date: Tue, 15 Oct 2013 22:33:43 -0500
Message-ID: <525e091764958_81a151de74aa@nysa.notmuch>
References: <1379780993-4190-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq4n8ich89.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 05:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWI4R-0005vq-AR
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 05:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab3JPDqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 23:46:34 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42988 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3JPDqd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 23:46:33 -0400
Received: by mail-ob0-f170.google.com with SMTP id gq1so139130obb.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=q2erfPFIeOZ8Mdg60brba9JDkyZXFvFl7HNUZOQqcn8=;
        b=mydj958LNvus3SRf/pVd4ppV4p6fZ5VD1foDPcylIvMqXvTcScoY6VnoZOxb86M6wl
         Q7uXAbjQRlCGqMIess3A/ali6PszwJQh7lUVn8MCG0oq6sc062hs2y9+VUFQQh2JvKUX
         Vhozm5YY2Ex9fWj84TMQaiPgBMCKHFrU8Rsksk4tEbQlfq9ZS2B4hj0M8j5xSy05if+v
         Ek/e7jOSbiomj5Q8mSFRd3UOgojvmZHn5zptViWyuwisc8jgPzycwj8ZpCVZqturYnIT
         8+uJDmXDbeRkszcynGsKKk0gFbQzn2xsOiKywD5QPVyRgprOQz5+E0gZ0p64wnnllGdR
         vdog==
X-Received: by 10.182.237.75 with SMTP id va11mr920476obc.5.1381895192790;
        Tue, 15 Oct 2013 20:46:32 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm57462853obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 20:46:31 -0700 (PDT)
In-Reply-To: <xmqq4n8ich89.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236229>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> 
> Let's do something like this instead.
> 
>  - We usually refrain from making such a tree-wide change in order
>    to avoid unnecessary conflicts with other "real work" patches,
>    but the end result does not have a potentially cumbersome
>    tree-wide impact.

You might want to change that phrasing to "we usually give low priority". Sure,
this is low priority, but this is something has to be done sooner or later, if
we don't the code-style will be forever inconsistent.

If there is a conflict it would be sensible to delay the change for another
release perhaps, it's perfectly sensible to ask the submitter to set another
version, and hopefully there would be no conflict.

Usually resolving the conflict is trivial, but there's a lot of options.

Refraining from making a code-style fix is not ideal. We want those. It's only
a matter of how to implement them.

>  - We also tend to frown upon an "I fixed it here only because I
>    happened to notice this one, there may be others but it is up to
>    the readers to see if there are other instances" half-assed code
>    churn.

If you have more general patch, sure, but would you really reject a patch that
fixes one thing, because it doesn't fix all similar things at the same time?

> The point of the proposed log message is to tell readers that this
> is a tree-wide clean-up that is worth applying.
> 
> -- >8 --
> From: Felipe Contreras <felipe.contreras@gmail.com>
> Subject: C: have space around && and || operators

Saying this patch is from me is not really accurate, it's based on a patch by
me, or it was reported by me, but it's not really from me. I don't have a
problem taking the credit though, as probably half the change is finding out
there's a problem, just saying.

-- 
Felipe Contreras
