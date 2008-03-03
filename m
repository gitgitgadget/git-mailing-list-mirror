From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH AMENDED] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Mon, 3 Mar 2008 20:07:49 +0100
Message-ID: <200803032007.49234.chriscool@tuxfamily.org>
References: <200802290814.39366.chriscool@tuxfamily.org> <200803030838.48976.chriscool@tuxfamily.org> <fqga4j$hgt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:02:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWFw3-0001oH-ME
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 20:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719AbYCCTCK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 14:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757316AbYCCTCK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 14:02:10 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:56293 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756860AbYCCTCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 14:02:08 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9C8A61AB314;
	Mon,  3 Mar 2008 20:02:06 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B87BC1AB376;
	Mon,  3 Mar 2008 20:02:03 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <fqga4j$hgt$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75971>

Le lundi 3 mars 2008, Jakub Narebski a =E9crit :
> Christian Couder wrote:
> > Le samedi 1 mars 2008, Junio C Hamano a =E9crit :
> >> How about allowing multi-valued man.viewer like this:
> >>
> >> =A0 =A0 =A0 =A0 [man]
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 viewer =3D woman
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 viewer =3D konqueror
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 viewer =3D man
> >
> > I tried the above in my .git/config and I get:
> >
> > $ git config man.viewer
> > woman
> > error: More than one value for the key man.viewer: konqueror
> > error: More than one value for the key man.viewer: man
> >
> > so I guess this can work only in C.
>
> $ git config --get-all man.viewer

Ooops, you are right, sorry about the noise.

Christian.
