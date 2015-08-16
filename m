From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 0/1] handling mistranslation reports
Date: Sun, 16 Aug 2015 13:46:07 +0800
Message-ID: <CANYiYbEKoF6GhezPmR1fGxRqTvZAE4L2xguvvwFEWqWBkOp9tw@mail.gmail.com>
References: <1438640973-1452-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Aug 16 07:46:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQqmA-0006WD-F2
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 07:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbbHPFqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 01:46:10 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33513 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbHPFqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 01:46:09 -0400
Received: by lbbsx3 with SMTP id sx3so65011456lbb.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8m+yexNQV0MA5HiuWaVghUUMzEF8nytGG5zvt12CWxc=;
        b=saLloa7OYmQ8SboSPHgAXQrs7hQWZyw9sodDY3JHUstPk6BigzeNLmw97cToPJsipq
         FIIhVz+RbUVgHK7nFuAOtal4Z76FKstMbiS8sNlE2bCJi/m8XU72RMZ5kDB8+PuEDDks
         NE6Wt8jxuny4n83q4db/52kKvln+2nyPzsMuoU+uyqwiGyo7mgNdYjv/Wd2AlfMoLL55
         x6sjK+0S5QiBDc6khAbKriJOhJ7kcDMSYush9CGMljhTB27rwa8nIn+V6S7PJK6T7Lie
         d/Pv3XXAS8q96Ijn3cUIfLASv/0Ca2XhaEqCE0TWF02+I131qHE6dTKBq0pqtIDNVMkQ
         kMcQ==
X-Received: by 10.112.234.197 with SMTP id ug5mr36657491lbc.79.1439703967812;
 Sat, 15 Aug 2015 22:46:07 -0700 (PDT)
Received: by 10.152.105.9 with HTTP; Sat, 15 Aug 2015 22:46:07 -0700 (PDT)
In-Reply-To: <1438640973-1452-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276012>

2015-08-04 6:29 GMT+08:00 Philip Oakley <philipoakley@iee.org>:
> Hi Jiang,
>
> This is my updated patch based on your feedback at $gmane/275141
> and $gmane/275142.
>
> I've used most of your wording, though have retained a comment on
> considering if the translation could be held here.
>
> My original commentary is below, along with the inter-diff between versions.
>
> -
> Recently, on the 'Git for human beings' list, a user reported a
> mistranslation and asked if/what could be done, with a suggested
> alternate text [1].
>
> I pointed the user at the po/README for general guidance.
> Unfortunately the user was noting a Spanish (es) translation error which
> is not held in your tree, but the README does include how to start a new
> translation. This led to a misunderstanding with regard to which aspect
> of the README was being referred to (private discussion with Junio).
>
> This patch separates out the three different aspects that caused confusion
> and explicitly brings out what to do for translations not currently held here.
>
> I hope my suggested patch will fit with your approach and ask for comments
> (or Ack / Nack).
>
> regards
>
> Philip
>
> [1] https://groups.google.com/forum/#!topic/git-users/rK5oU6k8Tzw
>
> Interdiff:

The subject is "[PATCH v2 0/1]" and I wonder where is the real patch
file ("v2 1/1")
aside of this  cover letter.  But today I have time to read it
carefully, and I know
this is a fixup commit.

I squash this reroll to last commit for this series, and simplify both
the commit
and the commit log.  See patch v3 in the next email.

-- 
Jiang Xin
