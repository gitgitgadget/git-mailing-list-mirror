From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: [ANNOUNCE] Git v2.0.0
Date: Wed, 28 May 2014 18:17:25 -0500
Message-ID: <53866e8562b7a_12a7a052f87a@nysa.notmuch>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-fc@googlegroups.com,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 01:29:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpnHI-0002cj-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 01:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbaE1X24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 19:28:56 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:42592 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753953AbaE1X24 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 19:28:56 -0400
Received: by mail-oa0-f44.google.com with SMTP id o6so12044907oag.31
        for <git@vger.kernel.org>; Wed, 28 May 2014 16:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=9CeqiHT2LmCRtnmauQ7EQJPpOo110gDYe+Kg0agX9y4=;
        b=AdQb1B+f4zd0+iJOgSjJeskWDp5QwgQ8ELpVA5Rznplq4c7ETzMh0UITd+rC8E1/r3
         I1t+9gZwK5OeesTPw77cLejxhuWR3qyMug/M50YbIMrYjjOtwXWoczZOSIpF/yCkEzen
         MOLMOn/ZjKl3SSsQXnF/QVbY682MCEJWlH3Dd03sxYSum7CDeOShG2Y6zRPI4zT50SLf
         LAylh9+FlC+3VkE/SwICx69lR+G8z/kk85iHGE9RkkJsk/Lkrf+mPj9N2GBnW7P/Dka0
         ZE7F0V9CMkuGIWS5O4Xy9VPliBsZaxp19CUq6aT1YIIVyjnXgPrnMfwe6XrkN9eEhbkf
         CQfA==
X-Received: by 10.60.115.202 with SMTP id jq10mr3952093oeb.0.1401319735403;
        Wed, 28 May 2014 16:28:55 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id rt4sm37023946obb.12.2014.05.28.16.28.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 May 2014 16:28:54 -0700 (PDT)
In-Reply-To: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250344>

This is the last mail I sent to you, because you ignore them anyway, and
remove them from the mailing list.

I'm am cc'ing the git-fc mailing list so there's a public track record
of this, so you can't claim it didn't happen.

Junio C Hamano wrote:
>  * The "remote-hg/bzr" remote-helper interfaces (used to be in
>    contrib/) are no more.  They are now maintained separately as
>    third-party plug-ins in their own repositories.

This is a lie. You are saying they don't exist any more, but they do
exist, they "graduated" according to your same words.

Also, in mail [1] Jeff said:

  But that being said, this is Felipe's code. While we have a legal
  right to distribute it in v2.0, if he would really prefer it out for
  v2.0, I would respect that.

To which you agreed, however, after you fucked up v2.0 and removed an
important patch, I said I changed my wish that I didn't want to disturb
v2.0 in mail [2], a mail you conveniently removed from the tracked
record.

In mail [3] you acknowledged my wish, and you said you were going to put
stubs for v2.0, and you didn't. You also conveniently removed this mail
from the archives.

Your rhetoric to make it appear as if the code is gone, your repeated
failures to accomplish my wish, even you said you would, and your
deliberate removal of the relevant discussion gives me no choice.

I threat all this as deliberate acts of aggression, and I will respond
as I said I would, and bring as much public attention to what you are
doing as possible.

[1] 20140516084126.GB21468@sigill.intra.peff.net
[2] 537bbd6c1daf_a6f166b308b0@nysa.notmuch
[3] xmqqlhtwrufq.fsf@gitster.dls.corp.google.com

For reference, here's the full content of mail [2]:

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
To: Junio C Hamano <gitster@pobox.com>,  Felipe Contreras <felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Date: Tue, 20 May 2014 15:39:08 -0500
--- text/plain ---
Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >
> >>   2. add warning that is given every time the scripts are run and
> >>      give the same instruction as in README.
> >> 
> >>   3. (optional) cripple the script to make them always fail after
> >>      showing the same warning as above.
> >
> > This is what I want, and I already sent the patches for; the scripts
> > will be stubs. At this point you would have effectively removed the
> > code, which what I want.
> >  
> >>   4. Keep README and retire everything else.
> >
> > After you've removed the code, I don't care what you do, but I'd say you
> > should remove the stubs after a long period of time.
> 
> Let's try this in a different way, as I sense there is a
> misunderstanding somewhere about your "wish".
> 
> >> "that" does not refer to "remove them at v2.0 (unconditional)".  It
> >> refers to "If Felipe really wants for the removal for v2.0, I would
> >> respect that".  And I saw you said you did not want to disrupt v2.0.
> >> 
> >> If the options I listed all meant removal at v2.0, then I would
> >> understand your complaints, but that is not the case, so I am not
> >> sure what to make of that.
> >
> > It is a weird choice of semantics then. You said you would "respect" my
> > wish, but your proposals did not "follow" my wish.
> 
> I understand you do not want to disrupt v2.0.  My assumption of that
> "not disrupting v2.0" has been "there still are git-remote-{hg,bzr}
> that work just like what they had in v1.9.x, perhaps with some
> enhancements and regressions you added in the meantime", and I
> understood Peff's comment "If Felipe wants the removal" to mean that
> kind of "disruption", i.e. "there is no git-remote-{hg,bzr} that
> work.", which would be either step 3 or 4.
> 
> But your "After you've removed the code" comment above makes me
> wonder that perhaps your definition of "not disrupting" was
> different from ours (which is not good or bad, just different) and
> you consider that step 3. is "removal but not distupting v2.0"?
> 
> If that is what you want in v2.0, then please say so, and I already
> said I am fine with that.

No, I already said I do not want the code removed from v2.0, that's why
I sent patches that simply added a warning, and I specifically said
those were for 2.0.

However, after seeing this commit:

10e1fee (Revert "Merge branch 'fc/transport-helper-sync-error-fix'")

Which is:

 1) Inaccurate
 2) A lie (*you* broke 2.0, not me)
 3) A disservice to users

I therefore change my wish for you to remove all the remote helpers code
and a replace them with stubs (the patches I originally sent for
post-2.0).

It was a mistake from me to believe you would do the sensible thing for
2.0.

So to make it clear, I now request that you do:

 1) Remove all the code.

    Since my patches were removed from the list, here's an updated patch
    that applies on top of 'master'

    https://github.com/felipec/git/commits/up/remote/remove

 2) Reapply d508e4a (Merge branch 'fc/transport-helper-sync-error-fix')

    Since the code in question is no longer part of v2.0, a "possible
    regression" that you aren't even sure of cannot be the rationale to
    revert this code.

    Your commit 10e1fee (Revert "Merge branch
    'fc/transport-helper-sync-error-fix'") actively hurts the
    out-of-tree tools, so I'll consider a failure to re-revert a hostile
    action.

 3) Update the release notes to mention these tools have been removed

  Additionally, you might want to:

 4) Re-add the following release note:

    * "git push" via transport-helper interface (e.g. remote-hg) has
      been updated to allow forced ref updates in a way similar to the
      natively supported transports

    I don't know why you removed it in the first place. Clearly you pay
    no attention at all to these interfaces.

I expect you to do at the very least 1) and 2).

-- 
Felipe Contreras
