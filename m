From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] Documentation: bisect: add a few "git bisect run" examples
Date: Thu, 8 May 2008 00:18:39 +0200
Message-ID: <200805080018.40181.chriscool@tuxfamily.org>
References: <20080507062931.dd72d7e1.chriscool@tuxfamily.org> <vpqlk2mbpao.fsf@bauges.imag.fr> <20080507072536.GJ23672@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	Thomas Adam <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu May 08 00:14:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtruM-0005AC-Tg
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763906AbYEGWNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 May 2008 18:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763385AbYEGWNw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:13:52 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60622 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757771AbYEGWNt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 May 2008 18:13:49 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E2CEF1AB2B0;
	Thu,  8 May 2008 00:13:48 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 859CF1AB2CE;
	Thu,  8 May 2008 00:13:47 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080507072536.GJ23672@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81483>

Le mercredi 7 mai 2008, Miklos Vajna a =E9crit :
> On Wed, May 07, 2008 at 08:29:03AM +0200, Matthieu Moy=20
<Matthieu.Moy@imag.fr> wrote:
> > Perhaps also s/~/./g, since it's not a good idea to put temporary
> > files in $HOME IMHO.
>
> the point is to have it outside the repo.=20

Yes. Especially, if the test case is a new one, the scripts that are us=
ed=20
must not have been checked in. Otherwise when bisect will checkout olde=
r=20
versions, the scripts will be removed.

> at least i regularly have 'git=20
> clean -f -x -d' in such a script if i don't trust the upstream build
> system. ;)
