From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] rev-list --bisect: Move finding bisection into do_find_bisection.
Date: Mon, 17 Sep 2007 05:19:19 +0200
Message-ID: <200709170519.19504.chriscool@tuxfamily.org>
References: <20070915125957.0899841b.chriscool@tuxfamily.org> <7vk5qr575a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 05:12:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX723-0000Xu-OQ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 05:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXIQDMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 23:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXIQDMN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 23:12:13 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57274 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbXIQDMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 23:12:12 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5A6611AB2B4;
	Mon, 17 Sep 2007 05:12:11 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3FD911AB2AF;
	Mon, 17 Sep 2007 05:12:11 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vk5qr575a.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58376>

Le dimanche 16 septembre 2007, Junio C Hamano a =E9crit :
> > +static struct commit_list *do_find_bisection(struct commit_list *l=
ist,
> > +					     int nr, int *weights);
> > +
> >  /*
> >   * zero or positive weight is the number of interesting commits it=
 can
> >   * reach, including itself.  Especially, weight =3D 0 means it doe=
s not
>
> The comment whose top part we can see here talks about the magic
> values -1 and -2 used while do_find_bisection() after the
> refactoring does its work, and these magic values are never
> visible to the calling function.  You should move the comment to
> the top of do_find_bisection() as well.
>
> Also this forward declaration is unwarranted.  A bottom-up
> sequence to define do_find_bisection() first, then to define its
> sole caller find_bisection() next is easier to read at least for
> me.
>
> The latter comment also applies to your other patch.

All right, I will send new patchs with these changes.

Thanks,
Christian.
