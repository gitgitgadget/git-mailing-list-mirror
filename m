From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Avery Pennarun's git-subtree?
Date: Mon, 26 Jul 2010 10:48:54 -0700
Message-ID: <AANLkTi=XrAwSe9Lfr8FDT00VS5+PZDx3pvh6+hC8wy2Z@mail.gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 
	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 
	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 
	<4C49B31F.8000102@xiplink.com> <AANLkTi=LHYDhY=424YZpO3yGqGGsxpY2Sj8=ULNKvAQX@mail.gmail.com> 
	<AANLkTinhd2DYh7WXzMvhMkqp98fYtTWWuQi0RSL9Rome@mail.gmail.com> 
	<AANLkTimLayG_HFxGdq+Tt8hU_MApBpSdHHiYPxcakpRJ@mail.gmail.com> 
	<4C4DB9AC.9000306@xiplink.com> <AANLkTimQywtn-0Fcr-ceLeHGeSBNROt+T=K+TowF_u5h@mail.gmail.com> 
	<4C4DC799.6070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Avery Pennarun <apenwarr@gmail.com>, skillzero@gmail.com,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Bryan Larsen <bryan.larsen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 19:56:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdRv3-0007MR-G3
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab0GZR4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 13:56:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50979 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754109Ab0GZR4s convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 13:56:48 -0400
Received: from mail-yx0-f174.google.com (mail-yx0-f174.google.com [209.85.213.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o6QHuToi013523
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:56:29 -0700
Received: by yxg6 with SMTP id 6so162830yxg.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:56:24 -0700 (PDT)
Received: by 10.150.227.14 with SMTP id z14mr312517ybg.19.1280166555280; Mon, 
	26 Jul 2010 10:49:15 -0700 (PDT)
Received: by 10.151.142.21 with HTTP; Mon, 26 Jul 2010 10:48:54 -0700 (PDT)
In-Reply-To: <4C4DC799.6070702@gmail.com>
X-Spam-Status: No, hits=-2.953 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151864>

On Mon, Jul 26, 2010 at 10:36 AM, Bryan Larsen <bryan.larsen@gmail.com>=
 wrote:
>
> To me, that's what git-subtree is: an internal private mirror of an e=
xternal
> repo. =A0 Using git submodule moves that into a separately managed re=
po, which
> is just unnecessary hassle. =A0Why maintain repo called "clone of lib=
rary X
> for project A" when you can just stick it inside of project A without=
 any
> downsides?

Without any downsides?

What about merging? What about complex history? IOW, what about
_anything_ but a few extra one-liner patches?

Background: the only time I ever used CVS modules, we had submodules
for things like gcc, binutils, etc. And maintained them separately
from upstream for _years_. Not with some simple one-liner fixes, but
with big fundamental changes that couldn't be sent upstream (and
wouldn't have been accepted anyway) etc.

THAT is the problem space. Not "just a mirror of another project".

                   Linus
