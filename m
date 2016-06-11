From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCHv4] Documentation: triangular workflow
Date: Sat, 11 Jun 2016 11:58:12 -0400
Message-ID: <CALkWK0nJDwH27V9B+X2K=c_X2k82ZXnab1r1zR6_axipxT5gkg@mail.gmail.com>
References: <1465288693-6295-1-git-send-email-jordan.de-gea@grenoble-inp.org>
 <1465475708-1912-1-git-send-email-jordan.de-gea@grenoble-inp.org> <xmqqmvmui9d2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>,
	erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	tom.russello@grenoble-inp.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 17:58:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBlJK-0003vN-3S
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 17:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111AbcFKP6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 11:58:54 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36792 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcFKP6x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 11:58:53 -0400
Received: by mail-vk0-f53.google.com with SMTP id u64so22058849vkf.3
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=No3dCLD1xZynKc81gCldKt3iupgLIQd60r/FN76lO2Y=;
        b=rNYgM11GnkjNwfRj8/1nqG+sciNmmoJ0pCJURIWO9IDdrEcaPW1RBZBSteM/INx72U
         PpBs9nDa+ZZBvuEMKlbfTE6RYIhtz99eNH5pbVZiYRthmJDUFMT+NUmNKK6O1NP/PuLv
         6eebdlxlTrsXLqQWHXPL/zBJVyvONaLu1MwOollyENz54n72jnt1Ls/Oc8KpoVgpC3cd
         oh29lxwleH9each4BThcaUyeTDtxnG9NbTHxpC+/H9uqRg2p71CQAV0nL53BbtDmCBrX
         THUhFHiTKMdhn30aoRJivhnlCd6nQg6q4Rao9oXr2bS39r250jg7YBWMiFOLzIR+8CJN
         phKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=No3dCLD1xZynKc81gCldKt3iupgLIQd60r/FN76lO2Y=;
        b=JrhNY/3jBydMU80HS+Mw1RD7bKafzvW2L1K7mQeOz9AAnHTZgIf7OMiQ0Z5lQfj3kF
         Y9qj8Eg0YeMx9ZtEV9B2FcMqK2q4Vd6oZlAiTjnw1i1eHM/lf1xJhICK+9iedtJD/t+B
         DfuwSTF55EAuGDUR3DvUqvt+8gffA16Kt+apJILnD/BZPEM8ASWf1ye6qcqSovrAREli
         rNjD59UUnC6l9kVhEnSFff+ztDuxQKHeCxaNfoOItpK30AIkNA7PqOKHqrz+9oA9+2WS
         cH0spF1AUuDFZu3Tcewb9jvGwHSzzrJ0UoFCRv7mOELQxBYYx9+aYUpSZF54KxNzVPyb
         svtg==
X-Gm-Message-State: ALyK8tKkwSYBz+8x/qcGa1tbUvReUXGFoowKv8EC5z0Es/0mSG3Plca00dzD+AW4PkeR5osANYNfURfUyaciDw==
X-Received: by 10.31.79.198 with SMTP id d189mr3096474vkb.47.1465660732133;
 Sat, 11 Jun 2016 08:58:52 -0700 (PDT)
Received: by 10.103.9.66 with HTTP; Sat, 11 Jun 2016 08:58:12 -0700 (PDT)
In-Reply-To: <xmqqmvmui9d2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297098>

Junio C Hamano wrote:
> Jordan DE GEA wrote:
>
> > +* Allows contributors to work with Git even though they do not have
> > +write access to **UPSTREAM**.
> >
> > +* Allows maintainers to receive code from contributors they may not
> > +trust.

Triangular workflow is the ability to accept changes from contributors
without mailing patches back-and-forth. Whether they send a pull
request or commit directly to the master repository when review is
done, is inconsequential. Essentially, they maintain forks of
upstream, which they work on at their own pace.

> > +* Code review is more efficient
>
> I have no idea what data you have to back this claim up.  More
> efficient compared to what?

They're orthogonal. LLVM has one giant SVN server that everyone
commits directly to. However, they review process is a lot more
efficient than GitHub projects, because they use Phabricator. What
does code review tool have to do with triangular workflow?

> > +Preparation
> > +~~~~~~~~~~~
> > +
> > +Cloning from **PUBLISH**, which is a fork of **UPSTREAM** or an empty
> > +repository.
> > +
> > +======================
> > +`git clone <PUBLISH_url>`
> > +======================
> > +
> > +Setting the behavior of push for the triangular workflow:
> > +
> > +===========================
> > +`git config push.default current`
> > +===========================
> > +
> > +Adding **UPSTREAM** remote:
> > +
> > +===================================
> > +`git remote add upstream <UPSTREAM_url>`
> > +===================================
> > +
> > +With the `remote add` above, using `git pull upstream` pulls there,
> > +instead of saying its URL. In addition, `git pull` can pull from
> > +**UPSTREAM** without argument.
> > +
> > +For each branch requiring a triangular workflow, set
> > +`branch.<branch>.remote` and `branch.<branch>.pushRemote`.
> > +
> > +Example with master as <branch>:
> > +===================================
> > +* `git config branch.master.remote upstream`
> > +* `git config branch.master.pushRemote origin`
> > +===================================

It's much too simple now. Just `git clone <upstream>`, `git remote add
mine <fork-url>`, and `git config remote.pushdefault mine`. Only the
last line requires an explanation.

> Instead you would set default.pushRemote to publish
> just once, and no matter how many branches you create later, you do
> not have to do anything special.

I think you meant remote.pushdefault here?
