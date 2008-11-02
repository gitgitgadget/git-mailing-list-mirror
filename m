From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 1/2] bisect: add "git bisect replace" subcommand
Date: Sun, 2 Nov 2008 12:20:09 +0100
Message-ID: <200811021220.09439.chriscool@tuxfamily.org>
References: <20081102021910.fef1532e.chriscool@tuxfamily.org> <alpine.DEB.1.00.0811020515370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 02 12:19:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwayv-0001tn-Om
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 12:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYKBLRl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 06:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbYKBLRl
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 06:17:41 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:35543 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431AbYKBLRk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Nov 2008 06:17:40 -0500
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 7187217222;
	Sun,  2 Nov 2008 12:17:37 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1A64C17236;
	Sun,  2 Nov 2008 12:17:36 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0811020515370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99839>

Hi,

Le dimanche 2 novembre 2008, Johannes Schindelin a =E9crit :
> Hi,
>
> On Sun, 2 Nov 2008, Christian Couder wrote:
> > This new subcommand should be used when you have a branch or a part=
 of
> > a branch that isn't easily bisectable because at some point, say A,=
 a
> > bug as been introduced. The bug has been fixed latter at another po=
int,
> > say B, but between these points the code is not easily testable bec=
ause
> > of the bug, so it's not easy to bisect between these points.
>
> Would it not be more intuitive to have support for
>
> 	git bisect skip A..B
>
> ?

We can have both. "bisect skip" is about not being able or wanting to t=
est=20
some commits and "bisect replace" is about testing using fixed up branc=
hes=20
(that you can share with others) instead of branches that you can't tes=
t.

When working on big projects where many people are often bisecting (lik=
e the=20
Linux kernel), then having shared "bisect-replace" branches (and tags)=20
might save a lot of time to all people bisecting, as they will not have=
 to=20
often skip the same commits or maintain sets of patches to apply when=20
bisecting.

Thanks,
Christian.
