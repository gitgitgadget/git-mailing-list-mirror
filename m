From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Sun, 27 Apr 2014 12:35:13 +1000
Message-ID: <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com> <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com> <3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com> <20140426072520.GB7558@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 27 04:35:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeEwG-0004qk-Ph
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 04:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbaD0CfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 22:35:24 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:42069 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbaD0CfW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 22:35:22 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so4545283pbc.16
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 19:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=uKAUD10r/3lYFCooy7Whnyylg1iNpwjwMnDyMVPnzIo=;
        b=uo2guQBVgwdurs2VcuUVa0zw1v6q/jzpcPjy0KFsYNLjqBcH+WEXPdTeIY4/vIiMDF
         MBATFJrzSkGhP7zsHQeXpqG1NcC2+/yKKf5hSQUwEydCGmbyOv58FeL5cXfuVaxxoryY
         HL8qK408xu6DUsqr/KEFjADrXnBjj2+1VwSYBSEcxrXYZ+I0Gjf3gye5UP4P95Wyuld1
         RDTC7/Vc2LyAEB3kaQF5DZ15Lu+gxhOwUYSlGlPy4G4MP9FkjaeHnSIo8+dHfRo0O/uM
         ZK0qnBW2ptTUT+AeAoZdnoYkQ4KGNzJ0t+9PuPvdIdhJVW8vsTCMRReMt7//tkzfWHXq
         3L2g==
X-Received: by 10.68.244.229 with SMTP id xj5mr20850123pbc.108.1398566122357;
        Sat, 26 Apr 2014 19:35:22 -0700 (PDT)
Received: from [10.92.67.121] ([101.119.28.35])
        by mx.google.com with ESMTPSA id kj1sm25568901pbd.20.2014.04.26.19.35.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 19:35:21 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <20140426072520.GB7558@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247190>

Jeff King <peff@peff.net> wrote:
>I think the problem is that
>contrib/subtree does not really have an active dedicated area
>maintainer.

Yeah, I can see how that might become a bit of a problem. I was
actually thinking of doing a bit of work on subtree beyond this
specific patch, so hopefully that won't be a show-stopper. We'll
see what happens, I guess.

>Your changes look fine to me from a cursory examination. It would
>probably be more readable as four patches (the 3 "fix" points from your
>list, plus the "minor fixes" mentioned at the end). Then each patch
>stands on its own, can say what problem it's fixing, and how.
>
> (...)
>
>Do we even make [subproject and mainline] anymore? It looks like they are part
>of the tests, but the whole test script runs inside its own trash
>directory.

subproject and mainline are actually made in  contrib/subtree,
but I'll look at perhaps "fixing" that when I split the proposal
into a series as you suggest.

Thanks for the advice!

Regards,
James Denholm.
