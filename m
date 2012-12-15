From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 4/4] Declare that HP NonStop systems require strings.h
Date: Sat, 15 Dec 2012 09:25:15 +0100
Message-ID: <00c701cdda9d$b5ee33e0$21ca9ba0$@schmitz-digital.de>
References: <00c601cdda4c$eb6be9a0$c243bce0$@schmitz-digital.de> <50CBB34E.8090609@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, <fedora.dm0@gmail.com>,
	"'Git Mailing List'" <git@vger.kernel.org>
To: "'Johannes Sixt'" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Dec 15 09:25:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjn3x-0007XX-Lw
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 09:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab2LOIZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 03:25:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53185 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab2LOIZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 03:25:19 -0500
Received: from DualCore (dsdf-4db5eef8.pool.mediaWays.net [77.181.238.248])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Mctwz-1TSX9h1SK1-00HyF4; Sat, 15 Dec 2012 09:25:16 +0100
In-Reply-To: <50CBB34E.8090609@kdbg.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFbKK0kjyTjI9j2FDPnwLybJDATHAJX/BqdmOwqIHA=
Content-Language: de
X-Provags-ID: V02:K0:3nTgCnT/YBkcw+38JU1a3fntCEEYQx40nZu+9zBPerx
 r355ECy0OO+5oWIjEaj4hd0NnU6ZTXwZWioylGPbtvew/t93i4
 cQ8qwCwuuDxqS5vEz52NB0MLL6NHjzGcmO56nwHZ9YA6Rc1pej
 21D24pDDjVlJOuWQxfuPiYaK/kYHbdM6M56KIuK4MdNqk1yLe/
 AiGETxlFu1hxASAqXMHBTM+GUEs7daI3sbevSwBo9yR5L5ea32
 s27oGR1rU3cPErIc/IyxmnB77g8PNV+cSdHJKGGdwuspeouEIO
 nzvYqIJfLM3951Tgp0yiSmY7teDQKEbVNwbyUvr5b6Hzq2m8uf
 eIn4S+w67V4nMQPfVuyv293auXXnZudssJG0SEXHBmDh7bu8sp
 C1WMJKFFP/npw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211522>

> From: Johannes Sixt [mailto:j6t@kdbg.org]
> Sent: Saturday, December 15, 2012 12:17 AM
> To: Joachim Schmitz
> Cc: gitster@pobox.com; fedora.dm0@gmail.com; Git Mailing List
> Subject: Re: [PATCH 4/4] Declare that HP NonStop systems require strings.h
> 
> Am 14.12.2012 23:46, schrieb Joachim Schmitz:
> > Johannes Sixt wrote:
> >> Am 14.12.2012 20:57, schrieb David Michael:
> >>> This platform previously included strings.h automatically.  However,
> >>> the build system now requires an explicit option to do so.
> >>>
> >>> Signed-off-by: David Michael <fedora.dm0@gmail.com>
> >>> ---
> >>>  Makefile | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/Makefile b/Makefile
> >>> index fb78f7f..e84b0cb 100644
> >>> --- a/Makefile
> >>> +++ b/Makefile
> >>> @@ -1357,6 +1357,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
> >>>      # Added manually, see above.
> >>>      NEEDS_SSL_WITH_CURL = YesPlease
> >>>      HAVE_LIBCHARSET_H = YesPlease
> >>> +    HAVE_STRINGS_H = YesPlease
> >>>      NEEDS_LIBICONV = YesPlease
> >>>      NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
> >>>      NO_SYS_SELECT_H = UnfortunatelyYes
> >>
> >> If NONSTOP_KERNEL is the platform that defines __TANDEM, then this
> >> should be squashed into the previous patch, shouldn't it?
> >
> > Patch 4/4 does not work without 3/4, Not for HP-NonStop.
> 
> That is clear from the order of the patches in the series.
> 
> To put it in a different way: Do all supported platforms still work
> after 3/4, but without 4/4?

Sorry I didn't make myself clear, I left out a "and vice versa"

Bye, Jojo
