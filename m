From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Sat, 02 Feb 2008 05:37:04 -0800 (PST)
Message-ID: <m3d4rf7a4r.fsf@localhost.localdomain>
References: <3asc6spe.fsf@blue.sea.net>
	<7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
	<20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 14:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLIYx-0006lT-57
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 14:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268AbYBBNhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 08:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753576AbYBBNhJ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 08:37:09 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:27454 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbYBBNhH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 08:37:07 -0500
Received: by py-out-1112.google.com with SMTP id u52so2178299pyb.10
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 05:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=Pti4NBI5PRiEuCTyiK385z4SK5HigtqFwUqwMTs6SB4=;
        b=eEYXXS3GNhHk6NW2wVOHn/0GYQDiVxJ1XZlGgVhlW/w95arIEeZK/l5LtL+Hs/YKJOEW0TjlOY6287cIJYLzhWvGzuTxrj5NTzwMC3g7nc/A7rOFl31p+Dt6bnhF1mvpnTPX49MONmJ5WuNg7VsMirOH1eYkLrmy168CNbFLews=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=Q58RaC0j41J/2agangxlceLgEiNCRAFYKGT68zr65qRPJQgwuAxen+wNRwYhIaA3dqqVO8yp5GbK7SjXgfFIRDZbmW7o7BVtjwDO9FMN4W45oX93oNxneIRRxRqG2oWPNIMyka3Oysj87NK1VmY2FBlcoPD+hnDyIgBFWHcX38g=
Received: by 10.65.114.11 with SMTP id r11mr8097013qbm.72.1201959425861;
        Sat, 02 Feb 2008 05:37:05 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id h4sm12621635nfh.8.2008.02.02.05.37.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 05:37:04 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m12DavTj005523;
	Sat, 2 Feb 2008 14:36:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m12DarRF005520;
	Sat, 2 Feb 2008 14:36:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <8x235xa8.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72276>

Jari Aalto <jari.aalto@cante.net> writes:

> * Sat 2008-02-02 Mike Hommey <mh@glandium.org> gmane.comp.version-control.git
> * Message-Id: 20080202084406.GA15305@glandium.org
>>> 
>>>> -$ git reset --soft HEAD^      <1>
>>>> +$ git reset --soft HEAD~1     <1>
>>>> -<1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
>>>> +<1> The last three commits (HEAD, HEAD~1, and HEAD~2) were bad
>>>> -$ git reset --soft HEAD^ ;# go back to WIP state  <2>
>>>> +$ git reset --soft HEAD~1 ;# go back to WIP state <2>
> 
>>> People need to refer to the HEAD^ (one commit ago) much more
>>> often than HEAD~N for larger values of N. 
> 
> I use HEAD~1 always, because I think the consistency in learning the
> most important factor.

I think that focusing on the fact that "HEAD^1" is peel-like operator,
selecting first parent of HEAD, That "HEAD^" is a shortcut for that,
and that "HEAD~3" is a shortcut for "HEAD^^^" similarly to how "3 * 2"
is a shortcut for "2 + 2 + 2" is better solution. "HEAD~1" and
"HEAD~2" are not shorter than original notation.
 
> It does not matter what advanced users use. The documentation should
> primarily focus the newcomers.

The documentation should cater to both advanced users and newcomers,
unless it is specifically targeted towards newcomers like different
intro documentation, or first part of Git User's Manual.

> The first question a newbie asks, if manual pages mixes syntaxes:
> 
>     What the heck "^" ?. I just saw HEAD~N, is the other one somehow
>     special?
> 
> All the other examples refer to
> 
>     HEAD~N
> 
> Those used to git may prefer ^, but it does not follow that others
> necessarily do so and that that should be the "proper learning
> path".

IMHO the sequence: 
  "HEAD^1"     -> "HEAD^", 
  "HEAD^1^1^1" -> "HEAD^^^" -> "HEAD~3"
is the proper sequence to teach.

Especially that "rev^sth" is used also for other things, like
"HEAD^{tree}", or "v1.3.0^{commit}" peeling operators, or even
"master^0" used to force detach HEAD to 'master'.

> People usually migrate to git from other VCSs, which have very
> consistent UI - There are no alternatives
> 
>     -r1:10      Subversion
>     -r1..19     Bzr
>     ...etc
> 
> It's unfortunate is the focus is given to comments like "easier type",
> when the context is the manual pages.

This is stupid example. Numbering revisions is possible only in
centralized SCMs, or semi-centralized SCMs (with one repository given
special, central position). You need an authority to assign sequential
numbers to revisions.

Besides git uses the same notation, <rev1>..<rev2>, only it doesn't
need '-r' option to select revision or revision range.

>>> Especially about HEAD~1, nobody sane would type that.
> 
> You consider all such users insane? It actually helps to select onlyt
> one sytax, and HEAD~N is much more readable without further explanations,
> (becasue people are already used to knowing, from other VCSs, what a
> HEAD or TIP is). It's not all that different from prefering the
> "--quiet" over "-q" e.g. e.g. in shell scripts.

It is also much less powerfull, as it can only follow first-parent
line. In the presence of merges you usually use ^n more.


That said, I personally don't have strong preference whether to use
"HEAD", "HEAD^", "HEAD^^", "HEAD~3" in examples, or "HEAD", "HEAD~1",
"HEAD~2", "HEAD~3". It is a bit of "bikeshed" discussion.

-- 
Jakub Narebski

  In related news: there is really no question that bike sheds should
  be painted red. Really. (Johannes Schindelin)
