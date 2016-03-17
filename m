From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Subject: Re: Gsoc 16
Date: Thu, 17 Mar 2016 14:00:33 +0100
Message-ID: <1458219633.2031.7.camel@dwim.me>
References: <loom.20160315T215800-306@post.gmane.org>
	 <CAFZEwPMKi5QVxNXV_nchK29OMmXpRbwvfuvfKQk52YjsKk-Q_w@mail.gmail.com>
	 <CAGZ79ka9kKm69wdM+KhiTi8im72mMBmxY6VDuNJf6wh1baFWJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Saurabh Jain <saurabhsuniljain@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:00:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXXd-0004mV-7g
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936049AbcCQNAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 09:00:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46255 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935577AbcCQNAg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 09:00:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailnew.nyi.internal (Postfix) with ESMTP id 6A674F8A
	for <git@vger.kernel.org>; Thu, 17 Mar 2016 09:00:35 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 Mar 2016 09:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=dwim.me; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=AoIiY/Hny3BLqS4VE0AFqo5UeLI=; b=YweAQ4
	QmCyoXw1hRHHIGe62/Wer2ultZWu26Cj61gFHpmLqy3q82bWEsw9LwVq8MNnFlRL
	ehQkLWO4b432UX4p0SjOTUvDZmTPxs8LWQ4tkhm6y1KBaTc0/bgp4j/79A3G2EoQ
	TJSakf1An1MCnNoS6kDEQg0PVXmPp/GZX/nDc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=AoIiY/Hny3BLqS4
	VE0AFqo5UeLI=; b=AD6e4puLRsZTzu9rQxbg5BlKlulE7qgEifOl7tm73ZxpBx7
	dRiLvEgreuh6XKAMs0WVGk98VQyZK85/QQWIBfMq44rqS7f4jP4nCe5dNoBlXpUW
	geMOO6A5WrFMHWxmWn7AOI/gk08F/VFNouUKhP8h+Ix0mJpJ+k/EKTGFJtSc=
X-Sasl-enc: IHMivHt9kuZO5DcUL1TuD3/ATD94PWM05QHmZ3izNb6I 1458219634
Received: from centaur.local (p548434c6.dip0.t-ipconnect.de [84.132.52.198])
	by mail.messagingengine.com (Postfix) with ESMTPA id 58B6DC00012;
	Thu, 17 Mar 2016 09:00:34 -0400 (EDT)
In-Reply-To: <CAGZ79ka9kKm69wdM+KhiTi8im72mMBmxY6VDuNJf6wh1baFWJw@mail.gmail.com>
X-Mailer: Evolution 3.18.5.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289107>

On Tue, 2016-03-15 at 14:33 -0700, Stefan Beller wrote:
> On Tue, Mar 15, 2016 at 2:23 PM, Pranit Bauva <pranit.bauva@gmail.com
> > wrote:
> >=20
> > Hey,
> >=20
> > Open Source projects run because of people who contribute in their
> > free time (mainly). It might not be possible for someone to be
> > active
> > all times Sometimes it may take around 2-3 days. Give it a little
> > more
> > time.
> Adding to that: Not everybody reads the whole list.
> The first mail you sent, was deep down in the thread for rewriting
> rebase --interactive in C instead of shell. The libgit2 maintainer
> (Carlos)
> is highly unlikely to read that as it doesn't affect libgit2.
>=20
> Posting as a separate thread here increases the chance for him to
> spot this
> message.
>=20
> Usually you'd cc the people you're addressing as that has highest
> chance that
> the relevant people see your message. (I cc'd Carlos in this message,
> no need
> to resend a third time from you.)

Thanks for the CC. Indeed I generally only look at the git list
sporadically and superficially since most discussions are about the
tool part of git, which doesn't affect the underlying system.

Saurabh, libgit2 development happens on the GitHub repository, so if
you want to contribute, open a pull request there and we'll review the
contributions when we can.

Cheers,
=C2=A0 =C2=A0cmn
