From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Newbie grief
Date: Tue, 1 May 2012 16:01:42 -0700
Message-ID: <CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F3919.6060805@palm.com>
	<CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
	<20120501111415.GD5769@thunk.org>
	<CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
	<4FA02830.3040407@palm.com>
	<86havzoi8h.fsf@red.stonehenge.com>
	<4FA04D02.6090702@palm.com>
	<86mx5rmx32.fsf@red.stonehenge.com>
	<4FA055D0.7040102@palm.com>
	<86aa1rmvhb.fsf@red.stonehenge.com>
	<4FA05E9F.9090709@palm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Wed May 02 01:01:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPM4r-0007b3-7f
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 01:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab2EAXBo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 19:01:44 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63309 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622Ab2EAXBn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 19:01:43 -0400
Received: by wgbdr13 with SMTP id dr13so29831wgb.1
        for <git@vger.kernel.org>; Tue, 01 May 2012 16:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oH4fgfNey56mHszOwxEfgFfiQvTdazm3aO9804X8Z2c=;
        b=OHGDDjO1mCeXOvw2aJzFGwK9ZUzM+CAckwDhzdm1QShjmNmAc9X60InM2yXAcz6tBR
         VjxeE66WJ+vnSkZxG/A/VFSnjV9V3Bn6oF5HRgDqnJfRjj6/PV3hEtuK/FOSEg8x5TG2
         lwVn5zB7dk5QO3sm0x1rvm/vKrRQ0uOjOV4Ym9Ej3UU3q4FQnnC5Vnxxz8CTmmxhzYiA
         pD4pED7SG28rRtpLcx2wO0xeGiNFWosAzXAkgfP6k17Xi5mCsogoQ9rohPO1/Ii1T+Cq
         nzk0TDQkmvabfi/peqwhRtWAiaf4aoQHTZ83lZzWhZleJi/vseMJ4VehkxIN3UcxvdXo
         yu9g==
Received: by 10.180.82.136 with SMTP id i8mr8539575wiy.19.1335913302637; Tue,
 01 May 2012 16:01:42 -0700 (PDT)
Received: by 10.223.116.200 with HTTP; Tue, 1 May 2012 16:01:42 -0700 (PDT)
In-Reply-To: <4FA05E9F.9090709@palm.com>
X-Google-Sender-Auth: 83lq--Rv9FsUKzrjuhP6h_tA7-Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196767>

On Tue, May 1, 2012 at 3:07 PM, Rich Pixley <rich.pixley@palm.com> wrot=
e:

> No, not a deploy system. =A0You use a deploy system to set up somethi=
ng like
> multiple server http farms. =A0What I'm doing is more akin to porting=
 the same
> piece of software to 20 different operating system distributions. =A0=
I'm not
> "deploying" the source code. =A0I'm developing it.

I fail to see how you would end up with more than one branch per
environment, though.  Fewer, if you do the merge before pushing your
change back to the server.

It sounds like you're asking for branches without names (or
automatically assigned names like master-0, master-1, etc.).  I'm sure
it's all very intuitive in Hg (which I know nothing about), but it
sounds to me like a recipe for confusion.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
