From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri, 16 May 2014 05:21:36 -0500
Message-ID: <5375e6b0f45c_1a1b8d33080@nysa.notmuch>
References: <53726a577d6aa_4aa4b312f862@nysa.notmuch>
 <xmqqegzxmlsr.fsf@gitster.dls.corp.google.com>
 <CACPiFCKpx9e-swWW4KEfY9YkG7s0uPTs_aftV-NbXGkvMqtf-A@mail.gmail.com>
 <53729ccf26bb0_34aa9e53047f@nysa.notmuch>
 <CAGK7Mr63X3+XXuRUEcBwwnwrOrbip8VUebtL-tM3R8PYBPEXuQ@mail.gmail.com>
 <5373c56c5c531_56d6e3b30449@nysa.notmuch>
 <xmqq38gcjcuw.fsf@gitster.dls.corp.google.com>
 <5373fc12bc5e4_7411589304eb@nysa.notmuch>
 <xmqq38gad51x.fsf@gitster.dls.corp.google.com>
 <5375c7934ccc6_7e7b772f8d5@nysa.notmuch>
 <20140516085929.GA546@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: William Giokas <1007380@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 12:32:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlFRV-00015N-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 12:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458AbaEPKck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 06:32:40 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:57590 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741AbaEPKcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 06:32:39 -0400
Received: by mail-oa0-f41.google.com with SMTP id m1so2766464oag.14
        for <git@vger.kernel.org>; Fri, 16 May 2014 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=YvUW68urMc0ZkIkH8bqsKS6FiWt+u91bgg+VpWOGHL8=;
        b=mQWOs5piMRJQmp6zBUwIzVPrtbBFMr2MoQ7/leC9+N7JRp5ukwwkKXfyjCUoquAuJ+
         e3jgcq9w/fxSyOpZ0dLM/1SKvGaIZFqoFUyv19d0tEhpNa6GLCpqKN3BGsT3/8Z0UZH7
         0JsHZ81BZMQ5Sjt3PAw9YwBIUmiOn3Fhg9SAkGHcqByie+q6r6C17Tf/dxFEMcIeorPo
         E1dleR2Ir2TW9Qff2eMcBCtGdDUQOCLgNE7etgRExoxfCT52KYg0Vnw9wjB5hGpZC8eV
         xjOmgnfaTcWauWelQAsp+055O6TBHU+k8fAgPA+sXM81p9hmS7zTbWrphd7ItkvJKOps
         o6yA==
X-Received: by 10.182.45.161 with SMTP id o1mr16095862obm.29.1400236358675;
        Fri, 16 May 2014 03:32:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm14186722obb.5.2014.05.16.03.32.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 03:32:37 -0700 (PDT)
In-Reply-To: <20140516085929.GA546@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249293>

William Giokas wrote:
> On Fri, May 16, 2014 at 03:08:51AM -0500, Felipe Contreras wrote:
> > This is a red herring. Ignore the fact that it will never happen (which
> > it won't), the next point remains a FACT, and you conveniently ignore
> > it.
> 
> It may not block git being released, but as we can see from the recent
> patches that were needed to enable hg 3.0 support it can break and would
> have to follow *both* mercurial and git upstreams, not just git's.

Indeed, it *can* happen, nobody has argued otherwise. The thing is how
*likely* is it that it will happen again.

As I said, in my experience developing this there has never been a
single instance where such a change was required for *newer* versions of
Mercurial.

>From what I can tell this is an exceptional situation.

And it makes sense that when it happened, it happened exactly in the
part where I wrote custom push() method. Mercurial has unstable API, but
in unstable API's are part that are more stable than others. Generally
the higher level the API is, the more stable it tends to be.

The Linux kernels makes an even weaker promise of API stability than
Mercurial does, but even then, the higher the API you use, the less
likelihood you have of breakage. I've seen this in practice many times.

And it does makes sense that for practical purses Mercurial would try to
avoid changes in the higher level API, which require changes in many
places, and not so much in lower level APIs, which might require a few
changes here and there.

The problem is that in order to replace the higher level API push(), I
had to use the lower level API, and that's where the breakage happened,
it was not unlikely. It is unlikely that another change in this
particular API will happen soon, but not extremely so.

As I already explained, this can be mitigated by contacting the
Mercurial developers and figure out if their high-level API can
accommodate the kind of functionality git-remote-hg needs. Maybe by
adding a new option, or maybe by adding another high-level helper
function.

Either way, I doubt Junio is qualified at all to discern between the
likelihood of future Mercurial API changes that would break
git-remote-hg. He has seen one, and he is wrongly assuming there are
more to come.

> After thinking about this for a while, I would have to agree with
> Junio That it's better if a bridge between to actively developed
> applications not be coupled to one.

How exactly would it be better?

If you concede that the Git release wouldn't be affected, then assuming
a hypothetical future where git-remote-hg is bundled, and we have a
Mercurial API breakage, we would have:

 Git < v2.5 fail, Git >= 2.5 get the fix

If we unbundle, we have:

 git-remote-hg < v0.5 fail, git-remote-hg >= v0.5 get the fix

What is the big difference?

I presume you would say that git-remote-hg v0.5 could be released
earlier than Git v2.5, so the users would get the fix faster. However,
that is not the case if the breakage is detected *before* the Mercurial
release happened, in which case both Git v2.4 and git-remote-hg v0.4
would already contain the fix, and it doesn't matter much which was
released first.

The problem is that I wasn't doing the continuous integration with the
development version of Mercurial, which I am now, so these kind of
exceptional issues would be detected earlier.

Moreover, it is likely that the distribution package for git-remote-hg
would not be maintained as rigorously as the Git package. It might not
even be part of the official packages (e.g. ppa or AUR). Therefore, even
if the git-remote-hg v0.4 happens earlier, it might reach the users
later.

Furthermore, we are talking about a single script that can be installed
by hand easily. The users can simply override their distribution's
script and install by hand the latest version, as many have been doing
already when they report errors and want the latest fix.

Even more. git-remote-hg will not have maintenance releases, if an
exceptional issue like this happens, it can be back-ported to Git v2.3.x,
Git v2.2.x, and so on.

It seems like a very feeble argument in favor of unbundling *at best*.

> This does not mean that I think git-remote-hg is not of a quality to be
> in the git.git tree, but it is simply a fact of development and
> stability. If git's remote-helper stuff changes but mercurial doesn't,
> we're fine because, having seen the speed of your fixes, we would have a
> fix before the next release without a doubt. However, if mercurial
> changes, like it just did, then git itself would need to make a release
> to have it actually work with the newest release.

That is not true. In this particular case, because I didn't build
against the development version of Mercurial, yes, but not for the
future.

If I had the tests I have in place now, we would have detected the
change earlier, and Git v1.9.2 would *already* contain the fix, and when
Mercurial v3.0 got released we wouldn't need to make a Git release in
response (same goes for unbundled git-remote-hg).

> Having the tool out of tree allows the maintainer to fix things on both
> ends and release independently so that both situations above can be
> solved without any real hassle on git or mercurial's side.

As I said; that won't happen. This was an exceptional situation for
different reasons.

If git-remote-hg was unbundled, and the correct tests in place, I would
have v0.2 already with the fix for hg 3.0, and when hg 3.0 got released
I wouldn't be forced to make another v0.2 release. Additionally, I would
not need to make the v0.2 release because of a fix for hg 3.0-dev as
merged.

In other words; the releases wouldn't be as tightly coupled as you make
them seem.

> This goes for bzr, too, but it looks to be changing less quickly.

More like not at all.

> tl;dr: This may not block a release, but it will make releases a lot
> more dependent on outside forces.

tl;dr: That won't happen. Even if it did, it would happen in the
unbundled release a well.

Also note that Junio never brought these points, and they were never
discussed.

I think if I had the tests for the Mercurial development version, the
fix for hg 3.0 would be already released in Git 1.9.2, and I find it
very likely that the graduation to the core would not have been tainted
by this extremely exceptional situation, and the graduation would
continue just fine for Git v2.1.

Sadly we would never know, because people are not good with thought
experiments, and they can't see what such a situation would look like,
and how a similar exceptional situation would look just like that. Not
to mention the fact that suck situation wouldn't happen at all.

Cheers.

-- 
Felipe Contreras
