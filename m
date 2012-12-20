From: Matthew Blissett <matt@blissett.me.uk>
Subject: Re: [PATCH] Highlight the link target line in Gitweb using CSS
Date: Thu, 20 Dec 2012 22:35:03 +0000
Message-ID: <CAKW1YCZLUS1LH+cAad08WhG5RLwXARMupEStrH8cdyhQY1itzg@mail.gmail.com>
References: <1356027399-5356-1-git-send-email-matt@blissett.me.uk>
	<7vbodo4f6q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 23:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlomv-0006Qu-Qn
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 23:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab2LTWkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 17:40:08 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:49158 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab2LTWkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2012 17:40:06 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Dec 2012 17:40:06 EST
Received: by mail-qc0-f172.google.com with SMTP id b25so2184186qca.17
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blissett.me.uk; s=g;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=MTqSxg7lAMRm24WZp3kDGQeb2UJkoq6vcugCO/Wj72I=;
        b=icccgOb8LVlFMfI72O38htq4dKbLFBrTCfNOIZ9h6ooditF949c1c6hZluWdZQ9Gop
         VdnSFuYjoHfYHYrQIyhawQyFiAASNHs0MrUg1Y4IMBvZv+8nJq01GQYygtJGjXc/gWB+
         5OFK7Fuef0/B+MfFAuvLbTy5uQDUHGfSPVEZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=MTqSxg7lAMRm24WZp3kDGQeb2UJkoq6vcugCO/Wj72I=;
        b=LsoPdk1EBSaSHbobYOQr1/tHp6hvkw56rA1GZIMZ4EZkdMqq8OTPqcG/eGVfpPtAFY
         E/e6QPC6G0NDQLE1ca0wdZHKgpJeI9H+QT5eCIuFnb5ilUByQqotvw9fsBzHNSUtKNZL
         gqv8j9gDsvQ2nJdDYvSxtJvlZqd53tNRqBHYYPCmz2QY/qI5lF24CF4rablpRML0ldVW
         kbhmqP9fYeSLyul4TlgRbyoBBCy83g8gFOb+jIwUPXlYZCrPPoStW2NkM4SWpoLU0mSd
         ++gQ9yVJJNwgHqq8MFJW2hmy+fQfKUdu19Dy39GjDOQ+4lavm02xoP2UYztzTQ84GemH
         Nrqw==
Received: by 10.49.61.102 with SMTP id o6mr6572912qer.41.1356042903951; Thu,
 20 Dec 2012 14:35:03 -0800 (PST)
Received: by 10.49.73.162 with HTTP; Thu, 20 Dec 2012 14:35:03 -0800 (PST)
In-Reply-To: <7vbodo4f6q.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkN5XpdvfVKa903wLVklLm27m/izMcpKEtvpvBoldWJzQqHoPikECQkfTpKa5m2hkoZNbfr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211935>

On 20 December 2012 20:54, Junio C Hamano <gitster@pobox.com> wrote:
> [jc: adding area expert to Cc]

Thanks.

> Matthew Blissett <matt@blissett.me.uk> writes:
>
> > This is useful when a Gitweb link with a target (like #l100) refers=
 to
> > a line in the last screenful of text.  Highlight the background in
> > yellow, and display a =E2=9A=93 character on the left.  Show the sa=
me
> > highlight when hovering the mouse over a line number.
> >
> > Signed-off-by: Matthew Blissett <matt@blissett.me.uk>
> > ---
> > The background-colour change is the 'main' (tiny) change.
>
> In the "blob" view, I think it does make it more discoverable that
> these line numbers are links, so I personally think a.linenr:hover
> part is an improvement.  I am not sure about other three changes
> adding any value, though.
>
> > Consider the ::before part a suggestion.  I think it helps show the
> > target line, but it does overlap the first character of any line >9=
99.
>
> Actually, when viewing the blame view, this is even worse, as it
> seems to always overlap.  The background color ought to be enough
> cue without being overly distracting, I would have to say.

I didn't know about blame-view, sorry.  The line-number links in that
view aren't self-referential, so the =E2=9A=93 symbol is misleading.  I=
'm not
sure if that's a mistake, or if the links are supposed to point to the
commit that introduced the change.  In any case, often they point to
the parent commit instead.

Just this:
/* Pink highlight when hovering line numbers or linking to them */
=2Epre a.linenr:hover,
=2Epre a.linenr:target {
	color: #444444;
	background-color: #f8f;
}
is probably best.  A pink background, which shows up better than
yellow, and only in blob view.  The :target background also helps mark
the chosen line after scrolling.

If blame view is supposed to have the same behaviour (self-referential
links) then these two CSS selectors are appropriate:
    .blame tr:target .linenr a, .blame tr .linenr a:hover

--=20
Thanks,
Matt
