From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: branch versioning
Date: Mon, 4 Oct 2010 14:16:58 +0000
Message-ID: <AANLkTikSpWhrtyAv73b=SQmUM0oTpVKWLgr16oUfrjXH@mail.gmail.com>
References: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
	<AANLkTi=73Siu9O1WT8MdjfAEO5j5y=CkOAiof0z83L=c@mail.gmail.com>
	<AANLkTinR31x9NrsHoDt3UQ8w=hioPGtkQDkQ-5bSNW69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 16:17:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2lqi-0004DC-MC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 16:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315Ab0JDOQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 10:16:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45337 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab0JDOQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 10:16:59 -0400
Received: by iwn5 with SMTP id 5so6971131iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fjlwkBPzAOV/8Ib4HTwXQ1WW7QLFk8Nl9o4g88ifVk4=;
        b=p3RxVhImVh/HgcTNIHIyq21It2Pt5Jd7SAO0reliSTzqdgc4jU01s6owK4kFLs26aY
         a9rI75X2ft7P3zX0RstXyo8L2jRhLW337S3EtkiKplimcpOuiBIL+yROrpXIluVJQFvr
         Eqia+jtH4J4E5BC3rVbZuAKRyYdQO7ABTUX2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c+2MtCVHdYWshm4nJyvTvSYaIvqwIUOVjN1hod5POZ0XyYZ8GWlvXg7+A2R9hgb/4T
         e8SoIPr4IT7zGvkoIcE2teojQf1hdrewA7ZPbbv55BauFsupMsHSipBYa2qLs9+Qn25T
         0RrPx3TLu2I3yg8ZfBvJc3nk+5G4r/fZNa6eo=
Received: by 10.231.148.85 with SMTP id o21mr10305574ibv.26.1286201818310;
 Mon, 04 Oct 2010 07:16:58 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 07:16:58 -0700 (PDT)
In-Reply-To: <AANLkTinR31x9NrsHoDt3UQ8w=hioPGtkQDkQ-5bSNW69@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158054>

On Mon, Oct 4, 2010 at 13:50, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> OK. Thanks for the information. I'll try my best to stay away from
> your repo :-D. Seriously, how can you select a branch out of those 123
> branches? Does git-branch support regex matching or.. (looked up
> git-branch.txt, no it does not)

I usually only have 1-4 branches active at any one point, so it
doesn't get too bad.

I also have a special tag in my E-Mail folder for patches that Junio
hasn't picked up yet or those that I need to work on. It's currently
at around 200 patches :)

I mostly select branches with Emacs's magit which has a fuzzy regex
based selector. "git branch -a | grep ..." also works.

It also helps to use long descriptive branch names, e.g.:

  run-partial-expensive-git-notes-test-everywhere
  run-partial-expensive-git-notes-test-everywhere-v2
