From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Wed, 3 Aug 2011 20:12:25 -0600
Message-ID: <CABPp-BHUuCMNMdVM20M2tPVQvDRmsTGRwfLoYW3-cgKHWXJ8Zg@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<7v4o1y81sv.fsf@alter.siamese.dyndns.org>
	<7vaabq6j6g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 04:12:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QonQU-0007Rq-O3
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 04:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab1HDCMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 22:12:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42471 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604Ab1HDCM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 22:12:27 -0400
Received: by fxh19 with SMTP id 19so1239758fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 19:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qIi8rlPs4F9achv590zTwdtUCPhmeT/mrCWA9h8srNY=;
        b=PmelCTHFnCBM5njvHve+Fw4TcoIlj34gh4Aa1S0QAdSb6a9CQsqcPg4koqcDjC9HAs
         gI8DP83qncslGGdpeCm8n1oihJ37hH8dU8ae46rM//e3cSn+DJJEdcZWnu2bDo+lV/00
         n+fFvqiBgH4cR+YhgI+tXkNk5W5t1srx1Zlq8=
Received: by 10.223.4.202 with SMTP id 10mr333302fas.129.1312423945954; Wed,
 03 Aug 2011 19:12:25 -0700 (PDT)
Received: by 10.223.109.198 with HTTP; Wed, 3 Aug 2011 19:12:25 -0700 (PDT)
In-Reply-To: <7vaabq6j6g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178655>

On Wed, Aug 3, 2011 at 7:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> A very simple reproduction recipe.

Thanks, I'll take a look this weekend.  I'm a little surprised that
you mentioned merging this to next already; I was assuming you wanted
me to address the various things you pointed out in your reviews first
(as well as the comments from Johannes).  I've been swamped at work,
particularly after trying to catch up on the pile of work accumulated
during my vacation, but should have time again this weekend...finally.


Elijah
