From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/t5800-remote-testpy: skip all tests if not built
Date: Wed, 19 Jun 2013 02:05:06 +0530
Message-ID: <CALkWK0=6ot9ZXEyMmO1ZtEXPi5H1JXXvG5j6yvBeE56H9zQBwg@mail.gmail.com>
References: <1371586006-16289-1-git-send-email-artagnon@gmail.com> <7vip1b40zb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 22:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up2d6-0000iW-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 22:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886Ab3FRUft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 16:35:49 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:62409 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932644Ab3FRUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 16:35:48 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so11322290ieb.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 13:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lqVipR730l1AwKfYP7nLo2CNpsIXAYV79o+ZN8CJJEA=;
        b=CEX6B1JQQfqI3h4pYwqYcp2ICSjeXCMb0x3drkqQGnrpwnLzNPF5yvsMLhU9QzaLuM
         L46YH7wUNecLTycnFpSTyIdghsKIC6xKtkLxbXIXJURXx53jsxWdpz4AkZqve5u662j2
         up8+ihNH5tp7R8rbDXZee2ySapq379RetfV/dqH5qw9pfWZPq0sqJ4yhdBHU7tNy2RsJ
         7Gq8gtqdkxhLOyI9dVswqOMsPAJGjWKX9WUIcdyz7ASNsgprougaD3bZgNvzo2AURyJU
         iecVEBJAYpRLJolJwDMgLyg4V6Usj8alsDixklJcSQFsqW/f4ZhmJ8YzB2DlbUOzBRH4
         oJqA==
X-Received: by 10.42.73.138 with SMTP id s10mr2016047icj.10.1371587747895;
 Tue, 18 Jun 2013 13:35:47 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 13:35:06 -0700 (PDT)
In-Reply-To: <7vip1b40zb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228311>

Junio C Hamano wrote:
> Sounds like making "make test" build it is a more correct approach,
> at least to me.  What am I missing?

How exactly?  I'm not exactly competent in make, but this is what I
understood from what you said (and it's obviously wrong):

diff --git a/Makefile b/Makefile
index 03524d0..da91937 100644
--- a/Makefile
+++ b/Makefile
@@ -580,6 +580,7 @@ TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-wildmatch

 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS += git-remote-testpy

 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin/$C.o but is linked in as part of some other command.
