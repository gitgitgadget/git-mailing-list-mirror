From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Fix _XOPEN_SOURCE problem on DragonFly
Date: Thu, 1 Apr 2010 22:37:48 +0800
Message-ID: <h2ibe6fef0d1004010737n813b81dds438563ea81bf694f@mail.gmail.com>
References: <20100304020522.GA76036@les.ath.cx>
	 <20100401073742.GA52362@les.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: YONETANI Tomokazu <qhwt+git@les.ath.cx>
X-From: git-owner@vger.kernel.org Thu Apr 01 16:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxLWu-00063Z-8T
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 16:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab0DAOhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 10:37:51 -0400
Received: from mail-pz0-f201.google.com ([209.85.222.201]:57942 "EHLO
	mail-pz0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab0DAOhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 10:37:50 -0400
Received: by pzk39 with SMTP id 39so181890pzk.15
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=u/a8aOqVQUF+EKrWEBFbLhti6QrsFDLO5/E2dDv60oQ=;
        b=ElDjBOYUe7M6t+HIi5aEa70Ec8WOK8kR6yGKNpG8j79TgSXGq4p3a0TM2YZlWS03g2
         fwmb2D2HY1GSeqndjOjb0avbmrX9lVAZFNc3qLf2LDCUezB99DFggXY4lOjPRk4ywuGA
         dJFROYZ4yOP+B1gsTVA3gNU9R/ec+tBI5hdBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=S2ce/skM1n8keWa588VGbj5NzUbqyNXCMyH9OhxaDJMnEBW3JJOPdgT25AW5sk+rjE
         D/1rK0htKnlm5R+BWERGEx2t0XU2r6llN1tLRsDJ3jACi9BZwJ1gBBWlO7hJodZ8Z2eh
         X2MU0wfanEagbiRvYxtqWxD3CpasuFl9lHv9M=
Received: by 10.231.12.69 with HTTP; Thu, 1 Apr 2010 07:37:48 -0700 (PDT)
In-Reply-To: <20100401073742.GA52362@les.ath.cx>
Received: by 10.142.67.33 with SMTP id p33mr256331wfa.231.1270132668559; Thu, 
	01 Apr 2010 07:37:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143730>

Hi,

On Thu, Apr 1, 2010 at 3:37 PM, YONETANI Tomokazu <qhwt+git@les.ath.cx> wrote:
> Hello.
> Is there anything else I need to do to get this in?

you should read Documentation/SubmittingPatches:

  http://github.com/git/git/blob/HEAD/Documentation/SubmittingPatches

Briefly,

1. Generate your patch with git-format-patch.

2. s-o-b.

-- 
Cheers,
Ray Chuan
