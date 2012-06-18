From: Phil Hord <phil.hord@gmail.com>
Subject: Blaming differences
Date: Mon, 18 Jun 2012 18:56:55 -0400
Message-ID: <CABURp0omoLoNaOhD3Vx734aVtm5sbk0E7_2uaZJWrWs=_g84iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:57:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgktP-0005NK-QE
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab2FRW5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:57:17 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:59399 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab2FRW5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:57:16 -0400
Received: by ghrr11 with SMTP id r11so4170785ghr.19
        for <git@vger.kernel.org>; Mon, 18 Jun 2012 15:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=EobkgzTYRSihDE9o0sizCfA8JrOxYL2mj2JxoOJiBRw=;
        b=XtWQH6hoOq2xN+0+nDaUlSiII2Ie534Q5RJF3F/bszsUoIScr/oi+cjl5+cQz6CsrA
         KgCm8+gLxSzheYrG0QRtWprLnVLJGiSpQiQTmkojw/GFdHbiZAxQ3LYhyZJsXYHtYNC1
         SUgFm8RAg0O7MWE4Mjf8RsGMdeZ9+cyvwCt/QXP5PZ38gW0S15urTcbwlV37wVTgECjS
         yB6BYeAsxXythMGVP8arej8rrkqJ7/hXSFHY00TdTWLqSDEx1ePPQ/dRw+50modpOgrw
         qaaSlsj67OnncQCYZVQVw/e5AXuJNeJoCIPHqaL1JgtAMMGNZ4v4g3+eE0S9SeTbbanL
         d6Lg==
Received: by 10.236.46.74 with SMTP id q50mr20571217yhb.30.1340060235644; Mon,
 18 Jun 2012 15:57:15 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Mon, 18 Jun 2012 15:56:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200179>

I want something like a product of diff and blame.  I want to see some
kind of "blame" output for each line of "diff -U0".

I tried something like this:
   git blame $changed_files

Is there such a command already?

I'd also like to do something of the inverse operation:  I want to
find commits within a range whose changes are NOT in some other
commit.   So, say I have these four commits
   A---B---C---D

Where D was created by 'git revert B'.
I'd like to find out somehow that this is equivalent to
   A--C

So that if I remove B and D completely, the with just A and C will get
me to the same end result.

Something like 'git list-contributors HEAD' which would show me A and
C, since these are the only commits that appear in any 'git blame
$any_file'.

Do these tools exist?  Is it too expensive?

Phil
