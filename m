From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Fix segfault for insane ident line
Date: Thu, 25 Apr 2013 18:52:13 +0800
Message-ID: <CANYiYbGC0VqtsPH8H4wmarJC-Y480+zE7irf1Y1RNLR2jA=EjA@mail.gmail.com>
References: <cover.1366885748.git.worldhello.net@gmail.com>
	<e7453e2b99517ebed045d82be4d5f2c9388bb002.1366885748.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 12:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVJmq-0007ul-8l
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 12:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931Ab3DYKwR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 06:52:17 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:61314 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757898Ab3DYKwP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 06:52:15 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so8473385wiv.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=Zv7GN66iF+9K/EC4eqquQyZhhBsb6jIhJz+zXEta9O0=;
        b=Y33gN4Mb3GFyN4a29AM8cgESx5DATiZtnROTcSRLYD5VTUFmIYtqXHOAqMDQdjL/7F
         dApSViXxmkihBuPioBqlylfv9teqaQ4ZCwrEI9WdeHv/81PpWoJtEYKq4Z4yVqo5h105
         hkr/QTPfuWRww8rD369liCX4/JhMXCs4UhSYHNbOfcEx6O+MlwQvNbBdgaxZ0MEwmize
         zz4zCaYJKw0mM08bwqmfbSdRONwk01qoOvoOa61Zk9+liUq0bydASqkbVWYD/Sy0Vue4
         Rg7xfsNC774GCxPnSGdBWhAFi1CWuHRA0DgvHONd+ow7W1OL8DVGwT+9Hnfo7DH5EfVw
         D1oQ==
X-Received: by 10.180.12.235 with SMTP id b11mr71757791wic.13.1366887134062;
 Thu, 25 Apr 2013 03:52:14 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Thu, 25 Apr 2013 03:52:13 -0700 (PDT)
In-Reply-To: <e7453e2b99517ebed045d82be4d5f2c9388bb002.1366885748.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222364>

Oops, Ignore this patch please, I found they were already fixed by the
following commits
of next branch. Maybe next time I should patch something in next branch=
=2E

commit 9dbe7c3d7f4424cf0c27c2d4efabf72e58fa76b9
Author: Ren=A8=A6 Scharfe <rene.scharfe@lsrfire.ath.cx>
Date:   Wed Apr 17 20:33:35 2013 +0200

    pretty: handle broken commit headers gracefully

    Centralize the parsing of the date and time zone strings in the new
    helper function show_ident_date() and make sure it checks the point=
ers
    provided by split_ident_line() for NULL before use.

    Reported-by: Ivan Lyapunov <dront78@gmail.com>
    Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


commit de5abe9fe91a496d019d62abefe23df9d72fad30
Author: Ren=A8=A6 Scharfe <rene.scharfe@lsrfire.ath.cx>
Date:   Wed Apr 17 20:33:54 2013 +0200

    blame: handle broken commit headers gracefully

    split_ident_line() can leave us with the pointers date_begin, date_=
end,
    tz_begin and tz_end all set to NULL.  Check them before use and sup=
ply
    the same fallback values as in the case of a negative return code f=
rom
    split_ident_line().

    The "(unknown)" is not actually shown in the output, though, becaus=
e it
    will be converted to a number (zero) eventually.

    Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>


--
=BD=AF=F6=CE

=B1=B1=BE=A9=C8=BA=D3=A2=BB=E3=D0=C5=CF=A2=BC=BC=CA=F5=D3=D0=CF=DE=B9=AB=
=CB=BE
=D3=CA=BC=FE: worldhello.net@gmail.com
=CD=F8=D6=B7: http://www.ossxp.com/
=B2=A9=BF=CD: http://www.worldhello.net/
=CE=A2=B2=A9: http://weibo.com/gotgit/
=B5=E7=BB=B0: 18601196889
