From: Michael Campbell <michael.campbell@gmail.com>
Subject: Advice and repo setup
Date: Sat, 6 Apr 2013 13:51:20 -0400
Message-ID: <CAKtB=OAot3y8fMjAf+Vh-=wOeX5b=F_N6_BLjK0fhGxGCg3Txg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 20:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOXGw-0008Nm-24
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab3DFRvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 13:51:22 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:52615 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450Ab3DFRvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 13:51:21 -0400
Received: by mail-qc0-f181.google.com with SMTP id a22so491237qcs.40
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=GBCcASAF1naRpGMu1ExyCVucQWKWto4sDFYsubIl/Wg=;
        b=pOZX5+q5Bh0nIh5afjPcj0d7rQFhlQbQq0x7TNBO6MKx362BtD1r24LmfaGYdHTHy4
         eGZossHNi4ZAzGJlvojENRAZJQCjmC6Lc0Mca1/lWIW0Q6DdMyzjF2H8yVp/6BjuIWS0
         25AHoCPC92ZcJ5cRY11t3hePFXFXtoLzoZ638eezP34C2imPrY2zBVZ52uo7kxWAXVwL
         BTTV0ruFhRGwrTItrsmTTa1Ft4qXAgdLW8cVgecxGF3bmzA2VsfqT3whofgMPGQy7N8Z
         Ub6lCy3gsFWlGq5hJzQ6pJKPX64tnZ4clNrxFc1jlZa2pgQSZLZ6ljRnxjB/Eeu4vP4o
         UGqQ==
X-Received: by 10.224.181.2 with SMTP id bw2mr2184166qab.64.1365270681023;
 Sat, 06 Apr 2013 10:51:21 -0700 (PDT)
Received: by 10.229.69.133 with HTTP; Sat, 6 Apr 2013 10:51:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220262>

My company is moving from CVS to git in a few weeks (and we have a
training class scheduled with the github folks).

That said our CI/build guys have already got gitorious set up (we get
to it through ssh with ssh keys and one "git" user on the server) and
we are in the process of migrating all new CVS checkins to a git repo.

As a business decision we have decided to pull in some "staff
augmentation".  We don't want the remote developers to have direct
access.  Our plan is to have some sort of external repo on which they
can push things, and locally we can pull those changes to our
"official" repo and check it as we go.  So far so good.

Our product has several logically separate projects, which right now
we have in the one big mega repo (in CVS, and migrating per checkin to
Gitorious).

So... I was wondering what the best way to split up our new repo might
be - or is it best to NOT split it?   One of the concerns we have is
that in the one big repo we can't control access to the various
projects.  So far we haven't needed to but this might be because we
couldn't.

So one plan is to have multiple repos, and then a mirror of those for
the remote devs.  The other plan is to say "sod it" and have one local
and one remote and just suffer through possible non-requirements of
varying authorization profiles.

Is there documentation I can refer to for this, or is there an obvious
way to do these things?  Any help or pointers appreciated.
