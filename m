From: Javier Domingo <javierdo1@gmail.com>
Subject: Centralized git
Date: Tue, 31 Jul 2012 14:03:24 +0200
Message-ID: <CALZVapkUu+hckMRAaNULSW5s9Q7P+78eVt1Q+ZrKFdPYb5uFVQ@mail.gmail.com>
References: <CALZVapnwGK=cKdHbZRsN0Ust7TAvFqa3AmYD7pzgoxdDxQh+uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 14:03:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwBB1-000603-NR
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 14:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab2GaMDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 08:03:46 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38822 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2GaMDq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 08:03:46 -0400
Received: by weyx8 with SMTP id x8so4274706wey.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=y38SpUOHzzn+i4Qwd14w1cGgzUGdOLzTclQAgNYEmWk=;
        b=Qai3kkx8/3TMrV2I6SjOyqgZ6vEGcuUAKYhWVKHyLBBocFkwtP+LzFuwTjEQmCwIJW
         2NZtIvUvcSeZ/2iwFmtHbosA+JDvB0IFRSm05dqAi9kFTNBgasC1dYkSYJK0uP3fwzMY
         TYAenockVogbk9keDXwGu4IiqyYnjZlxJDx/q2WEnyoMsZGjHpP1+eoXc3V8KL/MKFbU
         3ZdAff+ylllQcA69w05ZVI3i6m1535ZHo0+atPcM152Rc+i5jUzmS7MwOYEef9gZO4us
         wKPiS7gOxmNT2nG4DZmkVT8MakqVeFZWpCyAzVXeQuCOg/8EDMPW0m0KUwfOo2Wr5bXs
         1Xbg==
Received: by 10.180.80.134 with SMTP id r6mr6355773wix.1.1343736224940; Tue,
 31 Jul 2012 05:03:44 -0700 (PDT)
Received: by 10.216.55.211 with HTTP; Tue, 31 Jul 2012 05:03:24 -0700 (PDT)
In-Reply-To: <CALZVapnwGK=cKdHbZRsN0Ust7TAvFqa3AmYD7pzgoxdDxQh+uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202647>

I know that currently that statement (Git centralized) is an oxymoron, but
let me explain why would it be interesting.

I am currently planifying a 3D project, and I will be having large binary
files. If I add a distributed VCS, the amount of disk space required will
increase significantly.

Due to that, I started looking for an alternative VCS, such as svn, cvs.
But none of them satisfied me, mainly because they didn't have the branch
concept Git does.

I read the bzr docs, and I found that was nearly what I wanted, except for
the branch concept git has. I am maybe explaining myself in the wrong way,
but I hope someone understands.

What I would like, would be the posibility of having something like the
history horizon in bzr, or the partial repos that git-annex provides. The
idea is to have a repo with all the branches (just the head of them).

Another thing I would like to see would be being able to commit like git
actually works. Though all the history wouldn't be available, making
commits offline would be a great thing, althought later, when pushing, they
would be just in the remote, getting erased from local.

I tryed to achieve this through porcelain commands, but didn't work the few
examples I tryed.

I know this breaks with Git's main philosophy, but that is something that
would be very great. For what I know, one of the bad things to deal with is
that the compression algorithm is thought for text files.

I am looking for your answers,

Javier Domingo
