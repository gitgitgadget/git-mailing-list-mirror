From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #08; Tue, 28)
Date: Wed, 29 May 2013 16:57:44 +0530
Message-ID: <CALkWK0m+t9DPrUbGBnaJ7jTqTVHohGgiiR-bjcTTRNmbT-Oq8A@mail.gmail.com>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 13:28:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheYQ-0004pP-Fz
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509Ab3E2L2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:28:25 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55411 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965472Ab3E2L2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:28:24 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so6595332iec.2
        for <git@vger.kernel.org>; Wed, 29 May 2013 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lFz1Gmf/lyKefcnarRpXRRaKMeDiUE3pG7ksOTYMDa8=;
        b=ZO2HN+Wb+x2jntnHa6BOldsOqtg0E5FiQkdw0Vbd4K8P2dsc97eSSryU19OIuvXQrf
         5CLF4BaGq6INQg5GF3W933LIBILNtTAKrq13MOjD7MCB390OMV8GqKIlFDeqvvleFX18
         qyOsFY6j2JQfcVUijfScevY9b70ueIJsYYOzjYSQ1yipyOl14OV+lz88ujcuc/py0fk6
         hwwsm8F+29opIkwgA+d1sZmzaBgTD0MbTHSHCjvVWcoI+6ZzDVoUxZrKH6tYA5XUESEv
         TMu76x+hUyaj8ofd5/BSOCKxEJfM6bD+u3ZrbpTGBRbiLU5IFKe5W8qIlTT3F3E09OBZ
         HQSA==
X-Received: by 10.50.32.8 with SMTP id e8mr996905igi.89.1369826904444; Wed, 29
 May 2013 04:28:24 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 04:27:44 -0700 (PDT)
In-Reply-To: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225790>

Junio C Hamano wrote:
> * rr/rebase-autostash (2013-05-12) 7 commits
>  - rebase: implement --[no-]autostash and rebase.autostash
>  - rebase --merge: return control to caller, for housekeeping
>  - rebase -i: return control to caller, for housekeeping
>  - am: return control to caller, for housekeeping
>  - rebase: prepare to do generic housekeeping
>  - rebase -i: don't error out if $state_dir already exists
>  - am: tighten a conditional that checks for $dotest
>
>  This is from v3, but after a "Fixed" message in $gmane/224111 we
>  haven't seen a reroll yet.  Also there was an attempt for a
>  follow-up, but it was never completed.

I've sent a tiny fixup for the last part.  Let me know if you're
expecting something else.

> * rr/die-on-missing-upstream (2013-05-22) 2 commits
>  - sha1_name: fix error message for @{<N>}, @{<date>}
>  - sha1_name: fix error message for @{u}
>
>  When a reflog notation is used for implicit "current branch", we
>  did not say which branch and worse said "branch ''".
>
>  Waiting for series of rerolls to settle.

I'm happy with the version in pu, and I don't intend to send any
re-rolls.  Is there something you're not happy with?

Quick update from my side:

* publish-rev: the @{push} thing is still in the early poc stages.

* for-each-ref-pretty: not ready; working with Duy.

* push-current-head: ready but for the commit message: in your
opinion, it doesn't "fix" anything other than the output.  I'll
rewrite and submit soon.

* pickaxe-doc: you had some more comments in latest iteration, but the
returns from a re-roll are diminishing.  Frankly, the work is too
boring: the first few iterations were interesting, because I was
learning; now, it's mostly differences in taste.  Nevertheless, I'll
re-roll when I want to sleep next.

That's about it, I think.  I've abandoned everything else.
