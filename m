From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Subject: Re: GSoC 2016: applications open, libgit2 and git.git
Date: Fri, 19 Feb 2016 10:46:18 +0100
Message-ID: <1455875178.343346.31.camel@dwim.me>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	 <448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	 <vpqh9h7f9kz.fsf@anie.imag.fr>
	 <xmqq60xnjh1s.fsf@gitster.mtv.corp.google.com>
	 <vpqziuzdr5r.fsf@anie.imag.fr>
	 <20160217204528.GA22893@sigill.intra.peff.net>
	 <xmqq60xnhviw.fsf@gitster.mtv.corp.google.com>
	 <1455788324.3786.14.camel@dwim.me> <vpq1t896s5c.fsf_-_@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 19 10:53:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWhkQ-0005La-MN
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 10:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427399AbcBSJxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2016 04:53:08 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:48285 "EHLO
	new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1427380AbcBSJwm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2016 04:52:42 -0500
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Feb 2016 04:52:41 EST
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 64AFDB2B
	for <git@vger.kernel.org>; Fri, 19 Feb 2016 04:46:31 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Fri, 19 Feb 2016 04:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=dwim.me; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=49NyicawHXH998a0BrNPyu433JY=; b=RwITPK
	lbV15gfAIxYjOlwGSVrRvy7aS/WG+NKCkcffVubQ0j1uZW2mHXQWImYEoYvHAQ0L
	s1m5JY4dowd48PvqNugRIKcfqLXVcrLI5N8rFg3/qjN5t+/JNzCsG4BRE5HnCm9s
	49M6ItUJHT/vkHThwRdFb3ACJvHIMyIqr/6Qc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=49NyicawHXH998a
	0BrNPyu433JY=; b=Znw4Z7v4PiZAPQR1UoKH0n1F+ftHodzgB+FjZaUh7eey8iR
	TCh+wz3q4pL06lCzkB+2en2StdRzRe2VFN0aQJkEz+wh4c7Gm3+5otNkG6yY27KN
	FVlOX7/cj5c12d0cseFW8yR6P9F6UT3gHhmBxmF/x0IYytZJIej5Bnk2lio8=
X-Sasl-enc: kD09ysPjsRyNhuFkE86YQWp6z3Kz89lgJGpYzF5NnfwN 1455875190
Received: from centaur.local (p548434c6.dip0.t-ipconnect.de [84.132.52.198])
	by mail.messagingengine.com (Postfix) with ESMTPA id 83923C0001B;
	Fri, 19 Feb 2016 04:46:29 -0500 (EST)
In-Reply-To: <vpq1t896s5c.fsf_-_@anie.imag.fr>
X-Mailer: Evolution 3.18.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286681>

On Fri, 2016-02-19 at 09:06 +0100, Matthieu Moy wrote:
> Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:
>=20
> > We still have most of the same things open as for the 2014 list.
> > I'll
> > ask around to see if we have. Last year I wasn't involved in the
> > candidate selection but IIRC we didn't do a project as none of the
> > applications showed the candidates would be capable of doing the
> > project they were applying for.
>=20
> OK. It's essentially too late to change this for this year, but next
> time we should discuss earlier about how we want to organize this
> git.git/libgit2 thing. For example, I think it would make little
> sense
> to have a git.git microproject and then apply for a libgit2 project
> since we have very different ways of interacting. And honnestly,
> right
> now the application is really git.git-centric so I don't think it
> attracts students towards libgit2. So, if you want to attract more
> students, we should work on that.
>=20
> I tried to clarify the situation with libgit2:
>=20
> https://github.com/git/git.github.io/commit/94d1747eb9621b3bc892be2f2
> 32338b7933ac271
>=20
> Please say if you're happy/unhappy with what I wrote. PRs are still
> welcome after the deadline.

This is fine. Our projects file should also be noted for the
microprojects, but I'll write that up myself. I'm writing up the two
projects we've thought up as part of the ideas page and will send a PR
today.

=C2=A0 =C2=A0cmn
