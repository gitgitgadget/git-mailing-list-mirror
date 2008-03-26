From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path" config var
Date: Thu, 27 Mar 2008 00:42:16 +0100
Message-ID: <200803270042.16822.chriscool@tuxfamily.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org> <200803250719.02044.chriscool@tuxfamily.org> <7vzlsnpaj3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?=
	 =?utf-8?q?_?= <nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 00:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JefBK-0006CA-Nh
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 00:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYCZXgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2008 19:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbYCZXgl
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 19:36:41 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:39702 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbYCZXgl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 19:36:41 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4C3421AB2AD;
	Thu, 27 Mar 2008 00:36:40 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E13651AB2AC;
	Thu, 27 Mar 2008 00:36:39 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vzlsnpaj3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78319>

Le mardi 25 mars 2008, Junio C Hamano a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> >
> > In my experience KDE people have never changed the binary names lik=
e
> > that. They just use (or advice users to use) different directory na=
mes
> > and change environment variables (QTDIR, KDEDIR and maybe others) t=
o
> > point to the new dirs.
>
> I was more worried about what distro people do, not "KDE people".  Fo=
r
> example, Contents-i386.gz file from an unnamed distribution lists a
> handful /usr/bin/k*[0-9] files with their counterparts without the
> trailing digit.

You are right. This is probably because of the current switch from KDE3=
 to=20
KDE4. But as I could find no "konqueror4", we are probably safe for at=20
least a few years.

By the way I just sent a documentation patch to add a "Note about konqu=
eror"=20
in "Documentation/git-web--browse.txt", to be consistent with the note=20
in "Documentation/git-help.txt".

Thanks,
Christian.
