From: konglu@minatec.inpg.fr
Subject: Re: [PATCH] git-status: Show empty directories
Date: Sun, 10 Jun 2012 11:46:15 +0200
Message-ID: <20120610114615.Horde.Sp1YK3wdC4BP1GznJuNzcNA@webmail.minatec.grenoble-inp.fr>
References: <1339270806-65013-1-git-send-email-muhtasib@gmail.com>
 <20120609221315.Horde.fN5FP3wdC4BP065b3FviijA@webmail.minatec.grenoble-inp.fr>
 <CAA3EhHJ9WnisF21iFfsjQKYFSY0t0jFvNV3aBjx0eGFPm8aoGg@mail.gmail.com>
 <877gvgrxw7.fsf@thomas.inf.ethz.ch>
 <20120609234717.Horde.I9rYUXwdC4BP08RlFRO2w_A@webmail.minatec.grenoble-inp.fr>
 <87haujr15p.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Leila <muhtasib@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:46:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdej0-0003d9-Sm
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 11:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747Ab2FJJqT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 05:46:19 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:53865 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205Ab2FJJqS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 05:46:18 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 6C5DF1A025B;
	Sun, 10 Jun 2012 11:46:15 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Sun, 10 Jun
 2012 11:46:15 +0200
In-Reply-To: <87haujr15p.fsf@thomas.inf.ethz.ch>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199581>


Thomas Rast <trast@student.ethz.ch> a =C3=A9crit=C2=A0:

>  - We avoid using braces unnecessarily.  I.e.
>
> 	if (bla) {
> 		x =3D 1;
> 	}
>
>    is frowned upon.  A gray area is when the statement extends
>    over a few lines, and/or you have a lengthy comment atop of
>    it.  Also, like in the Linux kernel, if there is a long list
>    of "else if" statements, it can make sense to add braces to
>    single line blocks.
>
> I'm not the one who wrote them, but I'm taking the last sentence to m=
ean
> that you should not put the braces unless the omission will break the
> vertical alignment of the 'else if' chain.

I agree with you and that's what I thought. Still

Junio C Hamano <gitster@pobox.com> a =C3=A9crit :

> Two points on style (also appear elsewhere in this patch):
>
> 	if (!"applying") {
>  		...
> 	} else {
> 		state->rebase_in_progress =3D 1;
> 	}
>
>  - "else" comes on the same line as closing "}" of its "if" block;
>
>  - if one of if/else if/else chain has multiple statement block, use =
{}
>    even for a single statement block in the chain.
