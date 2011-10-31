From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: New Feature wanted: Is it possible to let git clone continue last
 break point?
Date: Mon, 31 Oct 2011 12:00:08 +0800
Message-ID: <CALUzUxpDVq7GbgEJkgJ5pCw9XouOBZEsD=U4GYyHivX4ji_8FA@mail.gmail.com>
References: <CAEZo+gfKVY-YgMjd=bEYzRV4-460kqDik-yVcQ9Xs=DoCZOMDg@mail.gmail.com>
	<CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mail List <git@vger.kernel.org>
To: netroby <hufeng1987@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 05:00:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKj3A-0004k6-UV
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 05:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab1JaEAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Oct 2011 00:00:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60004 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab1JaEAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2011 00:00:10 -0400
Received: by faan17 with SMTP id n17so5172549faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=56mG53JlEm+T1JGjH2tozBpN5Pk7XX7DXT5canqgUR0=;
        b=gVUGuPbdT72IUxrPA9+/UqH3zuYfO21d8P9vTKX8DCVXGS7cnScGI65zJLUfd/bKBx
         ioHhfEppCK69tgLLPSDmJZw4AlypH8DGeCoaJpjeLz2vlAnctZzQpzLWlVqDy8fqc9Ic
         knkcpk7U1VEAz8b3C6ZQOORIZe+XLe/GhstRw=
Received: by 10.223.58.146 with SMTP id g18mr26502693fah.13.1320033608618;
 Sun, 30 Oct 2011 21:00:08 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Sun, 30 Oct 2011 21:00:08 -0700 (PDT)
In-Reply-To: <CAEZo+gcj5q2UYnak1+1UG7pPzoeaUr=QLsiCiNXbC_n+JQbKQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184491>

This is a hard problem that hasn't been solved. Year after year, it's
a GSoC proposal...

What you can do is use --depth 1 with your git-clone; then "extend"
the depth incrementally.
--=A0Cheers,Ray Chuan

On Mon, Oct 31, 2011 at 10:28 AM, netroby <hufeng1987@gmail.com> wrote:
> Is it possible to let git clone continue last break point.
> when we git clone very large project from the web,=A0 we may face som=
e
> interupt, then we must clone it from zero .
>
> it is bad feeling for low=A0 connection=A0 speed users.
>
> please help us out.
>
> we need git clone continue last break point
>
> netroby
> ----------------------------------
> http://www.netroby.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
