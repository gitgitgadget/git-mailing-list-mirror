From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Thu, 14 Oct 2010 15:54:13 -0500
Message-ID: <20101014205413.GD28958@burratino>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
 <20101014200027.GA18813@burratino>
 <AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 22:57:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Urz-0003MQ-Ma
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 22:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007Ab0JNU5k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 16:57:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52640 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab0JNU5j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 16:57:39 -0400
Received: by vws2 with SMTP id 2so43507vws.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=T0wMz5ny2XqyolA2a0OC+GRVxwR4FEQphyMUgViUXZU=;
        b=CLK+8/p92GAtZ5LQTv+6mvAK7ygQESTXIdahprDn3VxrJV5nA/Hv/N5FglS2EHLVZZ
         5eSLsnC5tYKfGOPQqqYuDuu0qxmCxoLxBS2KUgG7r+eevS0tE/rPsl47yc041AOf0EMs
         +qT0G1pKG3V0w+CHjL8VVfkD6Wm+iMKZ3Ad/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u4uE+rc+LMmyS6EuaFqg16o+xus9enBeIx/KMainWeOamlRzMS8QcdlyJ6NLd5RTpu
         92wkrlCD2/iblkd0m67nVBOJgJsmHcLfnIP//X/rFJgMyrUSXNk02hdMNyiX8lYoSg81
         PmgBK9DWg8tnUq7rigamcJ3vzlpPCJUYA9lTU=
Received: by 10.220.188.132 with SMTP id da4mr3279916vcb.167.1287089858708;
        Thu, 14 Oct 2010 13:57:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i2sm3533182vcs.33.2010.10.14.13.57.37
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 13:57:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159075>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I could do that, but I've been hoping that it just gets picked up for
> the `next -> master` process of git.git itself and *that* becomes the
> stable target.
>=20
> But I have no idea what's going on at the other end, i.e. there's no
> comments about it in the "What's cooking in git.git" posts or
> elsewhere. So it's hard to know whether something like this is needed=
=2E

Probably it is a difference in culture between e.g. the Linux kernel
and other projects.  In the world I'll stereotype as the Linux kernel
world, forks are considered good!  Developments everyone agrees is
good in the long run (like the Linux realtime tree) are not
necessarily merged, for years even, the justification being that
until the _immediate_ benefits for Linus outweigh the risks for Linus,
it just doesn't make sense to merge.

This avoids bloat and bugs from code that is not being used by anyone,
while allowing development to continue to happen.

Now git.git is not the Linux kernel.  In particular, Junio provides
the extra service of a working "proposed updates" branch, including
changes that are not necessarily to be part of the next release.  But
the underlying principle is the same: until there is an _immediate_
benefit to including a feature in releases that does not outweigh
the downsides, it just does not happen.

What that means: interested parties need to start testing the l10n
code.  There should be a reliable upstream for users of this
feature and ideally that should not be Junio unless he wants to (and
=C3=86var, I think you have been doing a good job of that, just saying =
it's
valuable).  The code's not going to get into shape otherwise.

> It's been about as ready as it's ever going to get for about a month
> now.

I hope not!  e.g. the LC_CTYPE problems have not been resolved (and yes=
,
that would be a regression for people using the it_IT.UTF-8 locale).

> I'm starting to get the feeling that there isn't much interest in i18=
n
> support at all.

I'm interested in it, at least.
