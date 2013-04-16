From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Tue, 16 Apr 2013 13:47:02 +0530
Message-ID: <CALkWK0kEQ+mCxkaqUusyaEpx350qNrJ8UPoeo7+hEVGEUbtaxQ@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
 <CALkWK0n0y6OPJvYjNeEbUx_CC58vHRRLCsmJtws+RKyv3wRTwQ@mail.gmail.com> <516C4BEB.7030507@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 10:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US15L-0003f7-K5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3DPIRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 04:17:45 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33919 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934641Ab3DPIRn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:17:43 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so200729ieb.31
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3ku4+lw1i3Lt995XVAPalCqTkS22rb/oQpR4P0mR0Hs=;
        b=fSMSvCflFgTELcKi2GDC97llQGyyQlZx7Cnvqzi/kyT4w3qGcKSSGKGsTZeClxnK3D
         LfaIn+T6WQb8nh1Lwctc008kPOgUqmWmmegdDCYj231PIavY3SUQi7YbeE4rmPS0jNOr
         QwwIuuO1IwVrfCMatyJ/NX1Wd/KLKt9o4RJ8eejCipjlvZ2QpSqqGFbtnfj2fGS1tUv1
         wh133QkMcPoo6n0wtA6zQ+wsrFbkIWhwPc9rvBNEt0YhCmhLuL2ZBVSyND9Oj+OHxJDY
         tyKkaTP3bVnAPDg19FUOX0KTCoV+yeg/mjt2MTuRp4J+Z4g3wtPg/dL0c51M2YjCXPSJ
         MIFg==
X-Received: by 10.50.50.71 with SMTP id a7mr7135256igo.14.1366100263118; Tue,
 16 Apr 2013 01:17:43 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 01:17:02 -0700 (PDT)
In-Reply-To: <516C4BEB.7030507@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221377>

Marc Branchaud wrote:
> If "git add" is all about specifying what lives under paths in the worktree,
> what's wrong with letting "git add" go beyond specifying just files?
>
> Syntax aside for the moment, I think a command like
>         git add git-repo-reference foo
> is perfectly natural:  It specifies what is inside worktree path foo.

I never said "just files".  Files, directories, symlinks and
submodules are all "things in the worktree", and all fine.  Remote
URLs, on the other hand, have nothing to do with the worktree.
