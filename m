From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 07:29:40 -0500
Message-ID: <5370beb4b2483_168f13a72fc57@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <53709788.2050201@alum.mit.edu>
 <5370a47bee98c_139611a92fc29@nysa.notmuch>
 <5370B920.2060506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 12 14:40:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjpX5-0004qE-7a
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 14:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394AbaELMkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 08:40:36 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34263 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbaELMkf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 08:40:35 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so8001844obc.34
        for <git@vger.kernel.org>; Mon, 12 May 2014 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=bI3VhVXxad1ULv/9mHpO1JTK7gib8sZJl0HO/ef6MqY=;
        b=TW6Ba7JlyFdzBCL7jMEQ0CHKN6OwffsFLL5RUbywFwbOk8JWKaqlx06Vy4dFbnscmA
         SPR8ZO2b9DBZ+QnTf2/N0KMKdMq9Q13sOQKQNytWXDxdNK1H7K3E0x0Q3UUO8o1LCa3R
         Udlgq7dAUuvo9L7Go3oI7nY3A2s0PO9bqemdSVyyp+e3PxJjrJFVbbSyzxZnTYXfSYJD
         93WBMHKmRY6lcn89K4PLpILq3Y/ne8Lu7TovxjH3pXwS0UxIjyKE0KhfcKmMUghGyav5
         VKEmIDIRVLn9clRIPefnO0SYRGe2kOo5bdaiQRwhRcg0zwb+4etxSIgnuOugN9DxVvZL
         3G0Q==
X-Received: by 10.182.104.71 with SMTP id gc7mr32831243obb.34.1399898435432;
        Mon, 12 May 2014 05:40:35 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m9sm39879146oer.15.2014.05.12.05.40.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 05:40:34 -0700 (PDT)
In-Reply-To: <5370B920.2060506@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248703>

Michael Haggerty wrote:
> On 05/12/2014 12:37 PM, Felipe Contreras wrote:
> > Michael Haggerty wrote:
> >> On 05/12/2014 01:34 AM, Felipe Contreras wrote:
> >>> Recently Junio said he was willing to hear the opinion of other p=
eople
> >>> regarding the move from contrib to the core[1]. This move is alre=
ady
> >>> under way, but suddenly Junio changed his mind.
> >>
> >> I agree with Junio.  There are good technical arguments for and ag=
ainst
> >> moving git-remote-hg out of contrib.
> >=20
> > Saying you agree with Junio is content-free. You have to say *why* =
you
> > agree.
>=20
> Actually, I don't have to,

Then there's no point in reading what else you have to say. Whatever
reasons you might have to agree with Junio are known only to you, thus
your "agreement" is opaque and meaningless.

> > The quality of the subjproject has not been called into question, s=
top
> > taiting the discussion with red herrings.
>=20
> On the contrary.  I just called the quality of the subproject into
> question, and I stated exactly which aspects of its quality I find to=
 be
> inadequate in the text that you omitted from your response:

I'll wait until somebody else calls into question the quality.
Preferably somebody who backs up his claims with evidence.

> OK, maybe you are technically correct there.  There is indeed a
> difference between > and >=3D.  Let me amend my claim:
>=20
> 2. Moving git-remote-hg into the core would require you to continue y=
our
>    presence on the Git mailing list.

That is another red herring. Moving them back to the contrib/ area whic=
h
is what Junio proposed would also require my presence on the list. Is
that what you want?

And there's the transport helper, and bash completion, and the zsh
completion.

> >>> [...] Does it make sense to you that
> >>> you get thrown in jail for a crime you haven't committed merely b=
ecause
> >>> someone thinks it's likely you will?
> >>
> >> Being the leader of your own valuable open-source project is nothi=
ng
> >> like jail.  It is an opportunity for you to shine in an environmen=
t that
> >> is more suited to your personality.
> >=20
> > Don't be ridiculous. There is no out-of-tree tool that could possib=
ly
> > compete in popularity against core tools.
>=20
> I never made that claim.  I claimed that it was "nothing like jail", =
and
> I stand by that claim.

In the context of the Git project what is the *worst* thing the
maintainer can do to a piece of code but delete it? So I think you are
right, the jail analogy is not correct; it's *execution*.

> > You know that those tools do better in the core, and you know
> > git-remote-hg/bzr would do better in the core. Don't act as if you
> > didn't.

> People who need to do a conversion from A to B only have to Google fo=
r
> "A B" and they will find the best conversion tools pretty easily.

Let's test that hypothesis:

Google: how to conver mercurial to git

 * Convert Mercurial project to Git - Stack Overflow (NOPE)
 * Converting a Mercurial repository to Git (YEAP: one among many)

Oh, but would you look at that:

  This script will actually be shipping with git at some point, which
  gives it some credibility in my book.

 * frej/fast-export =C2=B7 GitHub (NOPE)
 * Hg-Git Mercurial Plugin (NOPE)
 * Converting Hg repositories to Git (NOPE)
 * Converting from Mercurial to Git - Hivelogic (NOPE)
 * Converting Repositories From Git to Mercurial (NOPE)
 * hg-fast-export: convert Mercurial repositories (NOPE)
 * Converting Mercurial (Hg) to Git Repository on Mac (NOPE)
 * Bitbucket: Converting Hg repositories to Git (NOPE)

So pretty much hypoethesis failed. That fact that you would even think
people would quickly find about git-remote-hg shows exactly how detache=
d
you are from the problem.

> If the tools are packaged for their OS then they are just an "apt-get
> install" away from happiness.

Oh, they are packaged already (as part of Git). Moving them out-of-tree
will make it much more difficult for users to find them, and install
them. It will take time for them to be packaged, if it happens at all.

> > Let's see how sincere you are in your sentiment. I'll reply to you
> > personally about the points that I consider to be red herrings and =
ad
> > hominem attacks so we don't taint the dicussion. If you don't reply=
 I'll
> > know you were not being sincere.
>=20
> Jumping at your every demand is not a prerequisite for being sincere.

I spent a lot of time writing that mail. Not sincere it is then.

--=20
=46elipe Contreras