From: John Szakmeister <john@szakmeister.net>
Subject: Re: Commit hashes differ from local and remote
Date: Thu, 14 Apr 2011 21:46:52 -0400
Message-ID: <BANLkTi=oXF95aE90Wn=E=yX8P6r79vOOcQ@mail.gmail.com>
References: <BANLkTimhx1tN7EzU94bpKK64P1F8P7MG0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Arthur Debert <arthur@stimuli.com.br>
X-From: git-owner@vger.kernel.org Fri Apr 15 03:47:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAY7u-0007MK-3m
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 03:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049Ab1DOBqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 21:46:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63775 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab1DOBqx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 21:46:53 -0400
Received: by wwa36 with SMTP id 36so2666593wwa.1
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 18:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Vy9CDFmRKmFKwhkqg+wU5La3AxoGInhUiDbMHHM2bAw=;
        b=AeJMVVXRq8FWSo9VDazTEWizyGlevgvurZUoztQIM/kWTol7u6kZQJ3DNoMxxaEbN2
         xcsYePyWP/jsRxkP56L0Umpk+9VdHUrORW1dRntaL8boF5YUtiqRY3xyHQR8MrxKVflf
         mJt3iOCuO1ul3YrX1Te+ndjgd3ZGoBii0q9Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=eJUz6Y1YnAqAd1r6sRtUInCpYIu9s2FfoQpedN0BJm/i6ZBa5O5EjLe/ksoqyQuBjI
         NDIqCOd0ybyBw5fGbg/K8XS7FCo/FPdPSON3aFnvkvfWvfD+L7OCUqvXCyGTHBGaiQi9
         CqhktajwI3oLcE+AXEdWOE5MHKnmPDnKNPbnQ=
Received: by 10.216.246.12 with SMTP id p12mr1361154wer.91.1302832012163; Thu,
 14 Apr 2011 18:46:52 -0700 (PDT)
Received: by 10.216.187.141 with HTTP; Thu, 14 Apr 2011 18:46:52 -0700 (PDT)
In-Reply-To: <BANLkTimhx1tN7EzU94bpKK64P1F8P7MG0g@mail.gmail.com>
X-Google-Sender-Auth: cg3wd8GRcjNecZsPbpNLn-xeFBY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171574>

On Wed, Apr 13, 2011 at 3:38 PM, Arthur Debert <arthur@stimuli.com.br> wrote:
> Hi Folks.
>
> I'm seeing some behavior that my git-fu isn't quite capable of explaining.
>
> On a local branch the last commit has a hash different than the remote
> branch it is tracking from. Nothing has been committed locally and
> doing:
> $ git diff branch-name origin/branch-name
> Comes up empty
> git pull also says my branch is already up to date.
>
> It seems that git pull has generated a bogus commit (a merge commit),
> but I can't quite figure out why.
> This is specially important since we need our app servers to have the
> same commit hash once git pull is done.
>
> Anything obvious I'm missing out? Any extra info that can help
> pinpoint what the issue is?

Maybe you did a git merge instead of a git pull?  Does 'gitk --all'
show you anything interesting?  I find it useful in understanding
issues like this.  It does sound like a merge happened, without having
any more information to go on.

-John
