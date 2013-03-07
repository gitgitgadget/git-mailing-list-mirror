From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: git-scm.com/book/ru -- incorrect "next" link containing a
 question mark
Date: Thu, 7 Mar 2013 12:47:36 +0400
Message-ID: <20130307124736.3d738c5aab39345fa9ca2930@domain007.com>
References: <5fe58162-33ed-48c2-a095-e98a355ed4f6@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Aleksey Rozhkov <ekkertan@gmail.com>, git@vger.kernel.org
To: git-users@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Mar 07 09:48:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDWUg-0007wL-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 09:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206Ab3CGIrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 03:47:41 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:48165 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930Ab3CGIrk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 03:47:40 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r278laJZ020848;
	Thu, 7 Mar 2013 12:47:37 +0400
In-Reply-To: <5fe58162-33ed-48c2-a095-e98a355ed4f6@googlegroups.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217580>

On Thu, 7 Mar 2013 00:01:31 -0800 (PST)
Aleksey Rozhkov <ekkertan@gmail.com> wrote:

> The page http://git-scm.com/book/ru/
> =F7=D7=C5=C4=C5=CE=C9=C5-=F0=C5=D2=D7=CF=CE=C1=DE=C1=CC=D8=CE=C1=D1-=CE=
=C1=D3=D4=D2=CF=CA=CB=C1-Git contains incorrect link "next"
> Now this link to the page=20
> http://git-scm.com/book/ru/=F7=D7=C5=C4=C5=CE=C9=C5-=EB=C1=CB-=D0=CF=CC=
=D5=DE=C9=D4=D8-=D0=CF=CD=CF=DD=D8? , but this
> page does not exist

I would say "?" is just interpreted as a request part of the URL.

Indeed, the page source contains:

<a href=3D"/book/ru/=F7=D7=C5=C4=C5=CE=C9=C5-=F5=D3=D4=C1=CE=CF=D7=CB=C1=
-Git">prev</a> | <a
href=3D"/book/ru/=F7=D7=C5=C4=C5=CE=C9=C5-=EB=C1=CB-=D0=CF=CC=D5=DE=C9=D4=
=D8-=D0=CF=CD=CF=DD=D8?">next</a>

so the question mark is really included verbatim.

> So, correct link is=20
> http://git-scm.com/book/ru/=F7=D7=C5=C4=C5=CE=C9=C5-=EB=C1=CB-=D0=CF=CC=
=D5=DE=C9=D4=D8-=D0=CF=CD=CF=DD=D8%3F

Good point, thanks.  I Cc'ed the main Git list and made the message
title a bit more clear.

To the Pro Git book maintainer: is it possible to somehow fix the HTML
generation script to URL-encode any special characters if they're to
appear in an URL?
