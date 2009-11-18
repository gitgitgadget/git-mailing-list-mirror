From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Wed, 18 Nov 2009 02:05:47 +0200
Message-ID: <94a0d4530911171605y3d366786jbc977a2e583bb57f@mail.gmail.com>
References: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
	 <20091114060600.6117@nanako3.lavabit.com>
	 <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
	 <20091117210625.6117@nanako3.lavabit.com>
	 <20091117172815.GH31767@fieldses.org>
	 <7vocn1dn5d.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911171400ub3b093ai668fd2404b12272f@mail.gmail.com>
	 <7v4ooseqvb.fsf@alter.siamese.dyndns.org>
	 <94a0d4530911171506o2b08954bw4acba8ea9193e65d@mail.gmail.com>
	 <7vzl6kd9t3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAY3V-0001Ex-Gn
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbZKRAFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 19:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbZKRAFm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:05:42 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:61559 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbZKRAFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2009 19:05:41 -0500
Received: by iwn8 with SMTP id 8so481485iwn.33
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 16:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QtTVkUKzIS7X+gQgm9HBGYwxsIs3zlK0XPeekY6cDNQ=;
        b=BCC8I6LNUm37Lr6h7xHsb8XphzL/0Fy+wBlGEhS5RcS7pUoXcw8yTd0JBfF8q0OLvu
         fdnNIQoxIIx0q96SR4BUVhzuR/I60v7jMYOLbA/kKmiseorShWfCNecc2j/Jw0LimY1n
         Z5kXFTkQ1TrQKRnH+YkAF2ztRK54cdqWVAXT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dJvU2BONEUJfKd/mlmMdhLvhRIQOcyT0Yq3Mm82TDkqnICebL5M+Xpm/wU2Cl7vktM
         EhSPH075ebL6TPhl21zhI0hU3/8/Y7ITeAoz4rXB69w6XPwOuH7kycCfCdG0uWa5koYz
         CsOExNGLxyjsfjTGfio8IZ4dqoehfVB9yG2+M=
Received: by 10.231.157.83 with SMTP id a19mr678114ibx.41.1258502747778; Tue, 
	17 Nov 2009 16:05:47 -0800 (PST)
In-Reply-To: <7vzl6kd9t3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133115>

On Wed, Nov 18, 2009 at 1:13 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Exactly. =C2=A0That is where we disagree. =C2=A0The funny "@stage" do=
es not convey
> the fact that it is affecting how "git diff" operates, like any other
> option like "-R" does in "git diff -R" command line does. =C2=A0Now t=
he user
> needs to know git commands take -option like other normal tools do, b=
ut in
> addition they need to remember that an oddball "diff" subcommand take=
s
> "@funny" in addition to the usual "-option".

Right now there are 4 modes of operations, the user would need to
remember all of them... instead, the @stage pointer would reduce the
modes to 1, so the user would have to look on the man-page only once,
quickly.

Also, to me it feels more natural to do "git diff b a" rather than
"git diff -R a b", therefore "git diff @stage HEAD" beats "git diff -R
--cached HEAD".

Moreover, I wonder if these modes are really properly implemented. For
example, what's with these funky commands:
git diff HEAD master next <- shouldn't only 2 be allowed?
git diff HEAD..master HEAD..next

Anyway, you are making the assumption that users actually use, and
understand the different modes of operation, but I'm claiming most of
them don't, and one of the reasons could be that they are not
intuitive.

> How would that be an improvement?

It might make people actually start using the stage, which again, it
seems apparent to me they don't. This can be easily interpreted from
reading the git user survey (only 23% of the people use "git add -i /
-p", and 15% "git add -u / -A" often), but if you don't believe so, we
can wait for the next one and ask the question explicitly.

--=20
=46elipe Contreras
