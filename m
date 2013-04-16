From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Tue, 16 Apr 2013 10:25:50 +0530
Message-ID: <CALkWK0=PemnwYkLg5X3YXA5kKE+K5rbbWvS+DR9xpTqAuq+QCg@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
 <vpqwqs3lqlf.fsf@grenoble-inp.fr> <CALkWK0nrVZo3MSgqpPmX2+T3JJ8uP=hzH3PMv+qd4ZaqNVwEsw@mail.gmail.com>
 <20130416031414.GK3262@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:56:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxwk-0004xm-GP
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab3DPE4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:56:33 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:52451 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3DPE4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:56:32 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so43007bkc.30
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 21:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZMaYJiI67yhBLyZOQCW2pX3hvFbnd5h+4k36D/JkMxA=;
        b=uK7k9QkPyR5eyBO3PQuA/Ab7nXdgIGlsDnelcCePtgV+iT4ZQPWMbpd5XvKZqCH4YG
         jw1xxFdOrocb1ERdMIfjUx0fbBgmIfjg3rlGbVwY3BQydY63vOY5pDUBJxxDrqkha/UB
         cAhoc/6YrBqTvjoDQpbtc8f7HBYfti+iJJMG79GELxXKUxnUkiYhfxv2C0gGHY0tzGAt
         Wkn+6uiesuTQkdwp5Arp9pW9BdL6Mfa8NvGO85CalisGeXmjFOXiPtHBd5xXy7SjpElV
         bqVyK/WPf+6cGuN4aZRfXchYPWoRA6qA4MzDYnbSTEF+GG5IkWuI/LY1cW3gFekL7svg
         euyg==
X-Received: by 10.205.47.202 with SMTP id ut10mr158674bkb.2.1366088191345;
 Mon, 15 Apr 2013 21:56:31 -0700 (PDT)
Received: by 10.204.37.69 with HTTP; Mon, 15 Apr 2013 21:55:50 -0700 (PDT)
In-Reply-To: <20130416031414.GK3262@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221365>

Jonathan Nieder wrote:
> I wouldn't be surprised if there's still a documentation bug, though:
> a lack of clarity, a missing hint somewhere else, something else
> misleading.  That seems especially likely when you say "I trusted the
> documentation on this one".  Care to point to the appropriate section,
> so it can be fixed?

As I pointed out in a previous email, I'm referring to the --abort
section of git-merge(1):

"If there were uncommitted worktree changes present when the merge
started, git merge --abort will in some cases be unable to reconstruct
these changes. It is therefore recommended to always commit or stash
your changes before running git merge."

Matthieu (and probably others) run git merge with a dirty worktree
most of the time, while I never do (because I read this section).
