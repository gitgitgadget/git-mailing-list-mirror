From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: remove warning that "git bisect skip" may slow bisection
Date: Sat, 13 Jun 2009 13:13:27 +0200
Message-ID: <200906131313.28411.chriscool@tuxfamily.org>
References: <20090613052258.4209.23374.chriscool@tuxfamily.org> <4A335FEC.6060309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@elte.hu>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 13:13:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFRAy-0004wr-8a
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 13:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763044AbZFMLNY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2009 07:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbZFMLNY
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 07:13:24 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:39290 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbZFMLNX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 07:13:23 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DA7BAE08098;
	Sat, 13 Jun 2009 13:13:17 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id EDE40E080EF;
	Sat, 13 Jun 2009 13:13:14 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A335FEC.6060309@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121496>

Le Saturday 13 June 2009, Stephen Boyd a =E9crit :
> Christian Couder wrote:
> > -But computing the commit to test may be slower afterwards and git =
may
> > -eventually not be able to tell the first bad commit among a bad co=
mmit
> > -and one or more skipped commits.
> > +But git may eventually not be able to tell the first bad commit am=
ong
> > +a bad commit and one or more skipped commits.
> >
> >  You can even skip a range of commits, instead of just one commit,
> >  using the "'<commit1>'..'<commit2>'" notation. For example:
>
> Can this be "git may eventually be unable to tell" instead?

Yes, I just sent a v2 with this change.

Thanks,
Christian.
