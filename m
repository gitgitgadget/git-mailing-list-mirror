From: "Hillel (Sabba) Markowitz" <sabbahillel@gmail.com>
Subject: Re: Newbie question about setting up git repository from svn (git svn)
Date: Sun, 6 Mar 2011 22:20:46 -0500
Message-ID: <AANLkTinzJC5WnrqnYDsrWzO8B=Ye8wjQmYEk0S4w61g9@mail.gmail.com>
References: <AANLkTi=UG4oq4QHhKoDOi9+4bhF1TDy4Z26ORj9Bdcwc@mail.gmail.com>
	<4D7441A9.7090505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 04:22:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwR1L-0002t9-MT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 04:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120Ab1CGDWB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 22:22:01 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44028 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934Ab1CGDWA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Mar 2011 22:22:00 -0500
Received: by vxi39 with SMTP id 39so3406260vxi.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XccTktUfiV/9jpgLk4XXlR132Jz1m4viDfYexqUMLdg=;
        b=GrVx92vCDKkTI+Ile7hhExqg3mQIxHS2/zOocZuH3Db89x0CCdA2J+mYq0Pb6LCCBJ
         STJ9mmYrhG9SAIPD+VnAxDCcgbmeREaV8uooGgFip4nX4sx+cGD6IA4owxnhamfKpHwl
         WJyamNDNm/t8WVwnd2a8XhOHAA1+PhW/curPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iMy+KDf4g2Uo1V+Q3YTLucN0bTS9u20J3mi6FagHf3yM7vJbJslyC/rzpjh103mXs5
         93Pv/gf+avMSWI18+Dz1iZYaiVrJSxerknX5aEkJdgw9ZH4CA6D9fU0DgemWlyuQblSm
         ZB0Q9aKyb0Tj88/tjc1LB4VoMUUDI2weJ07ZA=
Received: by 10.52.68.168 with SMTP id x8mr2213024vdt.158.1299468046550; Sun,
 06 Mar 2011 19:20:46 -0800 (PST)
Received: by 10.52.158.9 with HTTP; Sun, 6 Mar 2011 19:20:46 -0800 (PST)
In-Reply-To: <4D7441A9.7090505@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168567>

On Sun, Mar 6, 2011 at 9:23 PM, Neal Kreitzinger <nkreitzinger@gmail.co=
m> wrote:

> not being familiar with git-svn, but familiar with "git", I would adv=
ise you
> to do the following:
> (1) on "gitserver" perform:
> (a) git branch branch1 remotes/branch1 (this will create a branch cal=
led
> branch1 that tracks remotes/branch1)
> (b) git branch branch2 remotes/branch2
> (c) git branch trunk remotes/trunk
> Now you have the branches master, branch1, branch2, and trunk on
> "gitserver".

> Despite my ignorance regarding svn and git-svn, I hope my comments wi=
ll be
> of some help to you or point you in the right direction.
>
> v/r,
> Neal
>
>

Thanks, this seems to point to what I want to do. I think that this
should give me the information that I want.


--=20
=C2=A0 =C2=A0 =C2=A0=C2=A0 Sabba=C2=A0 =C2=A0=C2=A0 -=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =D7=A1=D7=91=D7=90 =D7=94=D7=9C=D7=9C=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 -=C2=A0 =C2=A0=C2=A0 Hillel
Hillel (Sabba) Markowitz | Said the fox to the fish, "Join me ashore"
=C2=A0SabbaHillel@gmail.com | The fish are the Jews, Torah is our water
http://sabbahillel.blogspot.com
