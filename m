From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/5] bisect--helper: add "--next-exit" to output bisect results
Date: Tue, 21 Apr 2009 07:51:39 +0200
Message-ID: <200904210751.39215.chriscool@tuxfamily.org>
References: <20090419115607.c7089503.chriscool@tuxfamily.org> <49EC2353.7080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 07:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw8wI-0002fu-Ub
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 07:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbZDUFxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 01:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZDUFxD
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 01:53:03 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:56188 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbZDUFxB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 01:53:01 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 53B2EE080D1;
	Tue, 21 Apr 2009 07:52:48 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 5BA99E08030;
	Tue, 21 Apr 2009 07:52:46 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <49EC2353.7080206@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117091>

Le lundi 20 avril 2009, Stephen Boyd a =E9crit :
> Christian Couder wrote:
> > +	printf("There are only 'skip'ped commit left to test.\n"
> > +	       "The first bad commit could be any of:\n")
>
> Should this be "There are only 'skip'ped commits left to test"?

Yes, but the same message was printed previously, so it is a slightly=20
incompatible change and I think it should go into another patch. Would =
you=20
care to send such a patch?

Thanks,
Christian.
