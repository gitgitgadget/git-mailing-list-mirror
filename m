From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 5 Apr 2013 01:29:02 +0530
Message-ID: <CALkWK0nwdgjiNnQo+1OY90BYGbKdUeLhqqCvQEtnS3q3bQtHFA@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com> <7va9pehzql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:00:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqKT-0002wi-2j
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763572Ab3DDT7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:59:44 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38967 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763314Ab3DDT7o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:59:44 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so3511568ieb.36
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+vaGuJdXBWQGNWXyxd59FnAqGoqgYNtdiLzpCNRY8Sk=;
        b=dk39rDu5aJfLFv5nqFVGSAT8ruDn2jJ030qfp83UnJv1RkSZwoU5J57bg+g8vsQekW
         PDUVY7IbpgOpHjRrx5f1RguJSpg/rcMcfe6lgCcGkB0Ka1k5OONrCAPwnJuwiSxuDm3X
         QPqrwMjKNmttfFnO4pRpbz4WnYuggDK0y8x8iwjN7/C0rfqI/Bx/dFBTi+lOWpKRVNpR
         C/I6iwEOki+UlDd1xrP/AWc8ZqY4tJ6Eg4w1eQ3HINbIQpppq9ppnRY8RMwnmusWtzIT
         wr9PM5zch+phcuD73mo3sAP+FHhyS83e58eWFIWjNF/8p8T2ikI5GTikkD+1qizbAOTb
         EwjA==
X-Received: by 10.50.17.71 with SMTP id m7mr4633340igd.14.1365105583578; Thu,
 04 Apr 2013 12:59:43 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Thu, 4 Apr 2013 12:59:02 -0700 (PDT)
In-Reply-To: <7va9pehzql.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220084>

Junio C Hamano wrote:
> I think Heiko and Jens's (by the way, why aren't they on the Cc:
> list when this topic is clearly discussing submodules?  Don't we
> want to learn how the current submodule subsystem is used to solve
> what real-world problems?) .gitmodules updates is exactly going in
> that direction.

Because it's pointless.  We're not discussing a git-submodule
alternative.  We're discussing how to fix git-core so that
git-submodule becomes much simpler; to the extent that it will be
unnecessary soon.

git-submodule is years of hard work and it can do a limited version of
floating with great difficulty.  Mine is two days of work, and can
already do true floating submodules.  What is going on?
