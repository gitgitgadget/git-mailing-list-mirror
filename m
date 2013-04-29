From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Tue, 30 Apr 2013 02:42:23 +0530
Message-ID: <CALkWK0nPrc41Z4-Jebwywx28x64QCm_010U_vpxa-K8XZOUpbA@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
 <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
 <7vppxj6thv.fsf@alter.siamese.dyndns.org> <CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
 <7vhaipl2ks.fsf@alter.siamese.dyndns.org> <CALkWK0npQwFnFNpEzT5mgh5HvGUKf=Jz7v4Mn62BDBzb+qjY_A@mail.gmail.com>
 <7vmwshi3dv.fsf@alter.siamese.dyndns.org> <CALkWK0nNb1CSR6EHxtnvBd3VXVPNb_JDqk2Kfa5VA1RMG1u0Ng@mail.gmail.com>
 <7vehdti00w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 23:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWvO4-00032o-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 23:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759626Ab3D2VNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 17:13:08 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:64151 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759618Ab3D2VNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 17:13:06 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so8120574iec.9
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LguezZCTfk02lH6fFz/aGmanTvj0JWOLg4Ll6afkjqg=;
        b=kcBQx+YlQOLHLFqmLUKId5i2IHwCV7wkMQJKZ+B+oAWHfXVTQQ+DxKvo2xl/Dwz2TM
         cPPbjNWEM1knhzcicvD4rrjrWLMX0FK1XF3VbC6AHuSG0hIJev4virCs0mhGzwlXHXag
         C3G7xp4Pc9dpjWpKcBROg388lcWEet/C0Uz0e4s+cSdUYKUKbt68Rm+DrdJFtL4gaFje
         J3GwJtJqIgsMxLL0LstBLiapQ5k+1tJGa48gRpMB8wc0Lk668a7EwZPX+tZlEF07U8ya
         36IMDnvVUTeHpCHCRl4CKdUEL3IVqm4BAgQIYsx2TJIjdpbNvXC1zh7f4cqjYmrvNeFT
         /45A==
X-Received: by 10.42.27.146 with SMTP id j18mr18944443icc.54.1367269984962;
 Mon, 29 Apr 2013 14:13:04 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 14:12:23 -0700 (PDT)
In-Reply-To: <7vehdti00w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222864>

Junio C Hamano wrote:
> Have you ever seen me saying "it sounds like a good idea" to a
> solution that is looking for a problem? ;-)

I'll try to avoid that approach in the future.

> "diff A...B" works already, and stopping to refer to "diff A..B"
> (the documentation patch you sent out) hopefully will make it less
> confusing.  I do not see a huge upside in replacing it with yet
> another notation people need to learn (and possibly make them
> unlearn a working notation). The downside of it feels far worse.

So, my question is about whether A..B is really that confusing.  We
might exploit the differences between .. and ... in all the commands,
and document it properly.  We just have to stop calling .. and ...
canonical "range" commands.  We can stick to overriding these two for
now.

What does consistency even mean?  What does it mean for rebase A..B to
have logical similarity to log A..B?  If this similarity cannot be
precisely defined, consistency is just an illusion.

> Not very interested [*0*], but I haven't thought things through.

Yeah, neither have I.  I'm asking for input.

> In order to express only what we can currently express (i.e. not
> extending for a DAG with a single bottom and multiple refs at tops),
> I think it is sufficient to allow "rebase [--onto=$there] origin.."
> [*1*]; we can infer what ref is being rebased from the range we get
> from the command line by asking rev_cmdline, and it may be more
> natural to people who grew up with "git log origin..".

That's fine.  The tricky part is: what is it rebased onto?  origin?

> That approach would express the DAG with the usual revision range
> specifier on the command line, limited to those range notations that
> have a single bottom and a single top.  That range defines the DAG
> that will be replayed, and its single top defines what ref is
> updated as the result.

Okay.

> When --onto is not specified, we could choose to use two- vs three-
> dot notations to select what "onto" to use by default [*2*].  For
> example, "rebase origin.." could be a way to replay your work on top
> of their work you fetched, while "rebase -i origin..." could be a
> way to identify your work since you forked from them, and tweak then
> without changing the base, i.e. the fork point (the latter of which
> would match what you would get from "diff A...B" naturally).
>
> If we later want to add "a DAG with a single bottom and multiple
> refs at tops", it could be spelled as "rebase --multi --onto=$there
> ^origin rr/rebase-doc rr/triangle" or something [*3*].

I'm an idiot.  What I was bouting as consistency was artificial
constraints _I_ imposed on the rev spec.  Why shouldn't the command
behave differently for:

1. One positive and one negative.
2. Multiple positives and one negative.
2.1 When there are two positives, and --multi isn't on.
2.2 When --multi is on.

What is it violating?

The UI you have proposed is very compelling, although I'm surprised
you did it top-down.

> [Footnote]
>
> *0* "git rebase master~" would rebase your current history on top of
> one commit before master, but you could choose to use some line
> noise character other than tilde.

Not urgent.

> *1* This is similar to the way we taught "origin.." and "-3 HEAD" to
> "format-patch" that originally only took "origin".

Okay.

> *2* Having said that, I do not particularly like the approach to
> exploit the difference between two- and three-dot forms and use it
> in choosing which commit to use as the default "onto".
>
> It might be more useful to have the distinction between "rebase -i"
> and "rebase" make that decision.
>
> Replaying on top of the merge base would not be useful unless we are
> doing "rebase -i" (it would be a no-op by definition). From that
> point of view, "rebase origin" (or "rebase origin.." or "rebase
> origin..."), because it is replaying your work on top of others, may
> use --onto=origin by default. On the other hand, "rebase -i origin"
> (or "rebase -i origin.." or "rebase -i origin..."), because you use
> the command in order to tweak your work, and you mention 'origin'
> merely to let Git know where your fork point is, may replay on the
> original fork point it discovers with merge-base.

I'll have to think about this.

> Or something like that.  The above makes me think that focusing on
> the revision range notation is not terribly productive when
> exploring how to make "rebase" easier to use to end users.

You managed a top-down version quite quickly, while I was stuck at
consistency :)

> *3* "--multi" is merely an example to make it easy to tell the
> command line from the traditional form that has an extra "switch to
> this branch before starting anything" argument.

Cute way of putting it.
