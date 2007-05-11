From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to /usr/share/man
Date: Fri, 11 May 2007 22:42:44 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705112242.44618.ismail@pardus.org.tr>
References: <200705081349.34964.ismail@pardus.org.tr> <200705112025.58095.ismail@pardus.org.tr> <7v646zb1p4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 11 21:41:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmazZ-0002SZ-Kd
	for gcvg-git@gmane.org; Fri, 11 May 2007 21:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965977AbXEKTk5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 May 2007 15:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965959AbXEKTk5
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 15:40:57 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:51957 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965933AbXEKTk4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 15:40:56 -0400
Received: from southpark.local (unknown [88.233.178.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id A2D1F5FD2B4E;
	Fri, 11 May 2007 22:40:46 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7v646zb1p4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46974>

On Friday 11 May 2007 22:27:35 you wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > On Tuesday 08 May 2007 13:49:31 you wrote:
> >> Hi,
> >>
> >> According to FHS standard default man page path is $prefix/share/m=
an [0]
> >> , attached patch fixes this for GIT.
> >>
> >> [0] http://www.pathname.com/fhs/pub/fhs-2.3.html#USRSHAREMANMANUAL=
PAGES
> >>
> >> Signed-off-by: Ismail Donmez <ismail@pardus.org.tr>
> >
> > ACK? NAK? Do we care about this? :)
>
> I would not say the patch is wrong per-se, but:
>
>  - People who do not override prefix to install in $HOME would
>    suddenly get their mandir under $HOME/share/man; the fact
>    nobody complained so far suggests me that these people have
>    $MANPATH pointing at $HOME/man, which means your patch breaks
>    things for them, unless they have been overriding mandir in
>    which case your patch does not matter to them;

Or nobody is reading man pages? *g*

>  - Distros who package git and want to conform to FHS would have
>    been overriding not just prefix but mandir anyway, so your patch
>    is not an improvement to them;

True that.

>  - People who override prefix to install locally in /usr or
>    /usr/local does "make prefix=3D" thing anyway, and the fact
>    nobody complained so far suggests me that they have already
>    known they need to override mandir as well if they do not
>    like /usr/local/man, so your patch is not an improvement to
>    them.

Most(All?) distros /usr/share/man in MANPATH so I believe this patch sh=
ouldn't=20
break anything but well you have the final say. I am ok with doing  =20
make mandir=3D/usr/share/man install-doc .

Regards,
ismail

--=20
Perfect is the enemy of good
