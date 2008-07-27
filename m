From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] t6030 (bisect): work around Mac OS X "ls"
Date: Sun, 27 Jul 2008 06:04:16 +0200
Message-ID: <200807270604.16581.chriscool@tuxfamily.org>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu> <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu> <200807270519.41441.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Sun Jul 27 06:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMxRv-0005E0-K1
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 06:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbYG0EAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jul 2008 00:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbYG0EAd
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 00:00:33 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:41122 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbYG0EAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2008 00:00:31 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id DB68612B6C3;
	Sun, 27 Jul 2008 06:00:27 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id BE58312B6C2;
	Sun, 27 Jul 2008 06:00:27 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200807270519.41441.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90304>

Le dimanche 27 juillet 2008, Christian Couder a =E9crit :
> Le jeudi 24 juillet 2008, Jonathan Nieder a =E9crit :
> > t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
> > status when asked to list nonexistent files.  Unfortunately,
> > /bin/ls on Mac OS X 10.3 exits with exit code 0.  So look at
> > its output instead.
> >
> > Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
>
> Acked-by: Christian Couder <chriscool@tuxfamily.org>

It seems that there is a problem with the message itself though. When I=
 "git=20
am" it, I get:

fatal: cannot convert from x-unknown to utf-8

It seems that it is mime encoded or something and my git=20
(1.6.0.rc0.80.gf54f0) doesn't like it.

Regards,
Christian.
