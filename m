From: Subho Banerjee <subs.zero@gmail.com>
Subject: Re: GSoC Application [ Parallelism + Git.pm ]
Date: Wed, 21 Mar 2012 19:23:06 +0530
Message-ID: <CAB3zAY319iV5ogaAeumo5bXC5vkvq=x_-6E689+fN8yZ6jtg1w@mail.gmail.com>
References: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
 <871uomt929.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 21 14:53:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SALyp-0003Ds-KI
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 14:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287Ab2CUNx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Mar 2012 09:53:28 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55394 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965124Ab2CUNx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Mar 2012 09:53:27 -0400
Received: by vcqp1 with SMTP id p1so1027920vcq.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ws3faWJv8wLzibe/+LhdK5hSTPns8JDKikMqIVQbneI=;
        b=JDGae9xAmMswq52i51L/bNRoJ4Z+yF2Os7nNfZTsFGTPZWeoenifiTKjxwSjIPUkN3
         cXXMZIWRds0B4Nx55NHBcBOxb3/Hb6ePf1LeQTHjcqvTOxidz0lUbNWUA82BbFXFWCYx
         WltingGP2q6bWD3KtsDCxXdbPdnJTT/EcwKoopLjOnGBcZLFZlPieDQetfBxfxXikDuX
         /LNxXS7EI+FPYBNuOnZcbD0Jayatpiw80sdd9vvwcPsEytQh6DYlAIoMV8H6Lov16Nvt
         4URWcACqTQ+hZj6saFhaBmrLLH9DCYtD+YLmdYo752kMdwf669RjUD5RGLAkxnxVOhIN
         N6Pg==
Received: by 10.52.35.12 with SMTP id d12mr1574618vdj.99.1332338006855; Wed,
 21 Mar 2012 06:53:26 -0700 (PDT)
Received: by 10.220.141.193 with HTTP; Wed, 21 Mar 2012 06:53:06 -0700 (PDT)
In-Reply-To: <871uomt929.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193578>

Hello,
Thanks for the links. Those really helped.
This threading that will have to be done, will this have to platform
independent, for example will it be used in windows without cygwin?

Cheers,
Subho.

On Wed, Mar 21, 2012 at 6:17 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>
> Subho Banerjee <subs.zero@gmail.com> writes:
>
> > * In the first one, which wants to parallelize certain commands in
> > git, I believe =A0the major challenges will be to actually find a l=
arge
> > list of commands which can be parallelized.In addition to the comma=
nds
> > mentioned in the Ideas page, only other place I currently think of
> > exploiting parallelism is in traversing the commit tree when one is
> > cloning a repository. I would really like it if someone can suggest
> > more places where this sort of parallelism might be usable, so that=
 I
> > could use that to make a more complete application. I believe one o=
f
> > the major difficulties I will initially face, is my unfamiliarity w=
ith
> > the code. This makes finding these commands which might have better
> > performance with parallelism a little difficult.
>
> Please read my reply to Felipe in the other thread:
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/193352/focu=
s=3D193574
>
> as I'd have to repeat myself.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
