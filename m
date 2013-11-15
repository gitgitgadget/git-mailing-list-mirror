From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Add a bugzilla website
Date: Fri, 15 Nov 2013 09:27:02 -0800
Message-ID: <CAH5451=+N1vYoNeweQXe9vavjmRvkEzP=7U+mDf-0zH9OSpZPA@mail.gmail.com>
References: <20131115085326.GA2401@brouette> <551223703.314994127.1384508447263.JavaMail.root@zimbra35-e6.priv.proxad.net>
 <20131115135132.431d3e344dadee64e2be5127@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ycollette.nospam@free.fr,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Nov 15 18:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhNBN-0007Pc-1C
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 18:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064Ab3KOR1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 12:27:45 -0500
Received: from mail-vb0-f43.google.com ([209.85.212.43]:63031 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3KOR1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 12:27:44 -0500
Received: by mail-vb0-f43.google.com with SMTP id w20so2937035vbb.2
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 09:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4IBqIBP5w+EYVSaLT4GAAkCuglAhlBpIb7I8yOsUS6Q=;
        b=WTy9xSjDRJGCNUOxGMlWDNCQqe3lQXuvNwOWwYTDVdIn4tCRypPZgox9sQMRwy65Vi
         G7sm/f/xRL8RJrij/bDQ6AL3VJ7dQEgKNF67IKAcakOuT664v/aydMaXFitX704Fn8t8
         DQX11DQVMwfDaRpvcGhVpf2WKkf3JDpaYlPXz6+JbY45nCDUwK6VnKDanhNaOo0x75kv
         OhTPK/uBQRmrQLfbM1QJhoimt/S0IIJuAozdEiqxJlv+qzg8HU38fpP5SqbXA2DiA09c
         3FWh4v/jslYS2lKvIy1rC9QXJcy8LnBryWRXrSLMDnofRbobfssy81dukEoox9l4krvy
         YuGQ==
X-Received: by 10.58.29.37 with SMTP id g5mr376328veh.38.1384536463709; Fri,
 15 Nov 2013 09:27:43 -0800 (PST)
Received: by 10.220.58.197 with HTTP; Fri, 15 Nov 2013 09:27:02 -0800 (PST)
In-Reply-To: <20131115135132.431d3e344dadee64e2be5127@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237912>

On 15 November 2013 01:51, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> But there was an announcement that an experimental JIRA instance has
> been set up for Git [1].  I'm not sure what its current status is, but
> you could look at it.

So!

The biggest concern has always been that any bug tracking system needs
to complement the existing workflow of many developers. For bugs and
feature requests, they are raised, discussed, and fixed on the list.
Replacing this process is not in scope for a bug tracker.

In that framework the main value a bug tracker has is keeping track of
what bugs exist, what versions they affect, and when they are fixed.
Unfortunately, at the moment, collecting and curating this information
is entirely manual.

The JIRA attempt [1] looks to pull in every conversation and thread it
for us (adding replies as comments to existing tickets), but hasn't
tried to anything beyond that. Automation may be possible, to do
things like parse What's Cooking and the release notes, but that is a
harder problem :)

The tools are there, and you should be able to log in and add/update
issues. Feel free! (Definite value would be derived from a dedicated
curator who updated the bug tracker manually)

I had a look over the set up (I hadn't in a while) and realised we
were dropping some emails, so I'll try and fix that, but the bigger
problem is that simply creating tickets to track conversations is not
enough.

We need to then identify those conversations that we care about and
capture some metadata about them - did they resolve the reported
issue, and when did that happen? Junio is the source of truth for
this, and so ideally we would use his communications to understand it,
but that just shifts the problem to linking the issues he writes about
to the conversations that started them.

In any case, adding value to the existing process is hard (because it
works quite well!) and probably requires significantly more work to
even understand what that value might look like. This, I think, is the
key reason it is hard to truly get started with any bug tracking
solution; the solution is not obvious, and the current (very
customised) workflow is not supported directly by any tool.

Regards,

Andrew Ardill

[1] https://git-scm.atlassian.net
