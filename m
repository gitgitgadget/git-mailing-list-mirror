From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Mon, 3 Jun 2013 01:58:09 +0530
Message-ID: <CALkWK0=3SNJ0TFNaM18=DdMN5OQX4L=7-DO1x1U-ASqgFuDmhg@mail.gmail.com>
References: <1369391635-13056-1-git-send-email-artagnon@gmail.com>
 <1369391635-13056-3-git-send-email-artagnon@gmail.com> <7v38tcb7yx.fsf@alter.siamese.dyndns.org>
 <CALkWK0m+kUa0QUotHXSYK40vFviFFv2yETnf6sEZMh05gOgLKg@mail.gmail.com> <7v7gicnv6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 22:28:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjEta-0007i3-CR
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 22:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab3FBU2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 16:28:51 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:55766 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab3FBU2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 16:28:49 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so8636423iej.15
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yvQGJ+Fs5US36nmtP6D6qWC8jqPPb+X1tAvOnrlTcaw=;
        b=0uSqYugFZrumIkW7ufaBBiao9zsWx/Mrk0TwY8Cu5L5aY21uDUKl19y4mYf9P15Rr9
         veVadZsz4NqvN04Pi+Ga9+h8dxqOQB8sUA+Ow3qSDkJrTC0NIyQd8h0x05mT05RYv2eq
         MpdY3fJl7sahsgaQWwPguQ1hXqO5FYACZKZ1QrhCOk4kkEL2Tp75rHrUNqe+lnT7LW9K
         8TYCYdxFaEHWgooio2jM0B3yOk4SZftlkhXbLMtsJ5SEEWeo3QRcR3t3yabdNP8evq5s
         bJ9mnkzPDOc96e/O0flxyKPRp5XMbwqKGrYhV3R+hcTZPxCi4H8LQfobBnuDOirXkTr4
         ihTg==
X-Received: by 10.50.107.6 with SMTP id gy6mr6339414igb.57.1370204929560; Sun,
 02 Jun 2013 13:28:49 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Sun, 2 Jun 2013 13:28:09 -0700 (PDT)
In-Reply-To: <7v7gicnv6o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226182>

Junio C Hamano wrote:
>> Why do a poor-man's version of --pickaxe-all here, when the last
>> paragraph already does justice to this?
>
> The point of the first paragraph is to serve to help both:

My question pertains to whether or not the explanation of
--pickaxe-all can wait till the last paragraph.  You want to
explain all the options in the first paragraph, but not
--pickaxe-regex?

>> While what you're saying is technically true, I think it is important
>> to explain the interaction between diffcore-pickaxe and
>> diffcore-rename as I have done.  Someone who wants to understand what
>> `git log -S` does will come to this page and read this section:
>> without reading diffcore-rename, she will have an incomplete picture;
>> what's the harm in explaining diffcore-rename in the context of
>> diffcore-pickaxe?
>
> This document is the most accurate _technical_ documentation of how
> the pipeline works (and it is not in section 1 of the manual set).
> If you want to improve end-user documentation by adding explanation
> for interactions between pipeline stages and also pathspec, I am all
> for it, but I think that belongs to the larger "git help diff", not
> "git help diffcore".

It's impossible to explain in the diff-options, because I do not have
even have access to the word "filepair", and no diffcore-rename
machinery to point to.  I could attempt a vague approximation, but I
do not think it's worth it.  I'll remove it if you insist.
