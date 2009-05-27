From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 22:11:59 +0200
Message-ID: <200905272211.59542.chriscool@tuxfamily.org>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed May 27 22:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9PU2-00034v-EJ
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbZE0UML convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 May 2009 16:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbZE0UMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:12:09 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:53936 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbZE0UMI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 16:12:08 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5C97C940134;
	Wed, 27 May 2009 22:12:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5048C9401D5;
	Wed, 27 May 2009 22:11:59 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A1CACB2.7000702@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120100>

Le Wednesday 27 May 2009, Sam Vilain a =C3=A9crit :
> H. Peter Anvin wrote:
> > I would like to request the following feature:
> >
> > "git bisect reverse"
> >
> > ... does exactly the same thing as "git bisect start", except that =
it
> > flips the meaning of "good" and "bad".  It is mentally fairly taxin=
g to
> > do a reverse bisection (looking for an antiregression) when one has=
 to
> > flip the meaning of "good" and "bad" (which are very loaded words t=
o
> > our psyche), and it's even worse to try to get a user to do it...
>
> Oh, yes.  And another thing: 'git bisect run' / 'git bisect skip'
> doesn't do a very good job of skipping around broken commits (ie when
> the script returns 126).

s/126/125/

> It just seems to move to the next one; it=20
> would be much better IMHO to first try the commit 1/3rd of the way in=
to
> the range, then if that fails, the commit 2/3rd of the way through it=
,
> etc.

Regards,
Christian.
