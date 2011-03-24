From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Announce: git-number
Date: Thu, 24 Mar 2011 12:46:35 +0700
Message-ID: <AANLkTi==8_hssWSHkR0DTynibtT83iUEq-M_nPO5gN1m@mail.gmail.com>
References: <AANLkTinJTy5OkcU+L=nFVwGMNBepuYgAr-+Jk=OVmG6P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 06:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2dO6-00039c-2y
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 06:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682Ab1CXFrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 01:47:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37589 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab1CXFrG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 01:47:06 -0400
Received: by wya21 with SMTP id 21so8385108wya.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 22:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=QhRXWSoVp5FRv63rapRo+CXKrYP5VCIV9OOWRu0ts0k=;
        b=nXGmGR/X8xwiHIzNGzAgRMijxTbIwGlbRzHrEBu5Gjd1e9uvqdCIrjuQf8k3KJnvsS
         9FWpMm1dPxQM7wc6dVIvCyRfHz1/WtD1J+kyveBexgG+RYxYylaB1iCBjItzpJRwxx1h
         H1iEbfGwVyeIuriqmdqMtfH0+8KeF+QKLQ84Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=eNmYbqPylsRsKUMF6zL6UMunjTNhZ1y08BF1+lPkgsCzCvyUtRQMVcp73nNWMLH7KB
         k/ERSYK7TRaxD8Pu7o4OLriLaqg6PiZDKlL/2VbXfy4a2Oe/02FKrQIsJugA3NeX7ahz
         VdAVrRiyM17GQrzUmiL/12ipRCca/Viu8f5Uo=
Received: by 10.216.157.68 with SMTP id n46mr315549wek.111.1300945625098; Wed,
 23 Mar 2011 22:47:05 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 23 Mar 2011 22:46:35 -0700 (PDT)
In-Reply-To: <AANLkTinJTy5OkcU+L=nFVwGMNBepuYgAr-+Jk=OVmG6P@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169893>

On Thu, Mar 24, 2011 at 11:51 AM, Nazri Ramliy <ayiehere@gmail.com> wro=
te:
> Hi,
>
> I'd like to announce a little tool that I have been using for the pas=
t
> few years whenever I use git: git-number.
>
> git-number allows you to use numbers in place of filenames whenever
> you need to provide them to any git command.
>
> When run without argument it will run git-status and prepend a number
> for each file name that git-status shows, starting from 1:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git number
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# On branch master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Untracked files:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 (use "git add <file>..." to inclu=
de in what will be committed)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#
> =C2=A0 =C2=A0 =C2=A0 =C2=A0#1 =C2=A0 =C2=A0 =C2=A0foo/bar/baz/frobnit=
=2Efu
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nothing added to commit but untracked file=
s present (use "git add" to track)
>
> The output is exactly the same as git status (with color), but with
> numbers associated with each file that is shown.
>
> Now, instead of writing:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git add foo/bar/baz/frobnit.fu
>
> You can just do
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git number add 1
>

Nice. I have something similar in a private tool (same problem: too
long paths to type). This can be made applicable to a few other
commands too, like 'diff --stat'. I think the magic character [1], be
it ':' or '/', can be used to make this (the syntax is for
demostration only):

$ git add :@{1}

equivalent to your 'git number add 1'.

[1] http://article.gmane.org/gmane.comp.version-control.git/169844
--=20
Duy
