From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Tue, 20 May 2014 15:39:08 -0500
Message-ID: <537bbd6c1daf_a6f166b308b0@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
 <20140517062413.GA13003@sigill.intra.peff.net>
 <xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
 <53795ef8e4023_10da88d30825@nysa.notmuch>
 <xmqqegzp1tl7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 22:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmqzU-0003uJ-3F
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 22:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbaETUuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 16:50:21 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:35575 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbaETUuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 16:50:21 -0400
Received: by mail-oa0-f44.google.com with SMTP id o6so1188378oag.17
        for <git@vger.kernel.org>; Tue, 20 May 2014 13:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=BLeSVFArM5OP6KXY1MIP3LP6L1aMEeMDdS0leAm6qVI=;
        b=CaFvuNruwnOVbSlX0SYjR44ZAv12OoPwx30NTmnc6tezmO3z0Jb6L1MB8T9+3hdQiU
         48DbR9x0uylBQ2s8LPNsKYlszI3Clt2yTqa57uD3EQhlv5KJ8pJpBhSYw/dZRmgiDLJp
         xtXyLYsjrF/BK/ehlaxDWyDf8PAjtD88cpZ8h/9q1bFgSF5FMAkHzJBCv5wcjtX2bb/E
         k4FaENiHoTYNM1+DwWdTRBVjy8u06r7xx37wDmuO0p8OsWdFvaPh5GrW71pEeYzFkFkw
         4Doh4OfN1XUnBqGiR1qUWKJdmlox1RGhcZW8cxCzMtarT5uJRnbxxX18TcVv3F3g3Ov5
         OsPw==
X-Received: by 10.182.105.1 with SMTP id gi1mr46932491obb.9.1400619020414;
        Tue, 20 May 2014 13:50:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm39739900obb.8.2014.05.20.13.50.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 May 2014 13:50:19 -0700 (PDT)
In-Reply-To: <xmqqegzp1tl7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249741>

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
