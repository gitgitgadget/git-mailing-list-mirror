From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 6/7] user-manual: add global config section
Date: Sat, 2 May 2009 01:51:37 +0300
Message-ID: <94a0d4530905011551r635a4ebfrba86707419e13cc4@mail.gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-6-git-send-email-felipe.contreras@gmail.com>
	 <1238837909-3060-7-git-send-email-felipe.contreras@gmail.com>
	 <7v7i1zv3cg.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530905010137h772b53f1q8af0d30400a05043@mail.gmail.com>
	 <7v3abowk6v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 02 00:51:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M01a7-0004Nl-Ps
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 00:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbZEAWvk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2009 18:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbZEAWvj
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 18:51:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:36852 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbZEAWvi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2009 18:51:38 -0400
Received: by fg-out-1718.google.com with SMTP id 16so812729fgg.17
        for <git@vger.kernel.org>; Fri, 01 May 2009 15:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NGr7hotdtPSQhf+Z9oLbKGjDrmxgaiBiR6tFZ5LYVqY=;
        b=U52cVqS/NUrTuIgHomyNlPP3c+r305hme/w6I10Kjas6LMJglY2u5HOCxbDaRJltsA
         t5NXS066sdz/WvD0HtlBm819/DP7ezIknSvcKmHGEv3RI2CtDOUDSTYDrrAWWeBmyXvR
         2W0omGm2WQAb6lP+rCL6OYLApv0m/2AhDsBBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kSZlrr9VOJAivORbilfRKKQ88XxicA+Ie+vjFv6WZ6t3CdxrAQSHNtceYMeuEe3Hio
         m+0Z8F8LBouuW8d80CeubwLvGgKgyn5Lwyzo1G8tOXZYZngsm3R+xvt7vOHx/vHGsoiQ
         KWyX/RIS7PzLoBJpXdMEX55ncN5Ggk+7G/Mr4=
Received: by 10.86.91.3 with SMTP id o3mr3301453fgb.20.1241218297663; Fri, 01 
	May 2009 15:51:37 -0700 (PDT)
In-Reply-To: <7v3abowk6v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118105>

On Sat, May 2, 2009 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> For that "introductory" purpose, however, I'd suggest showing how t=
hey
>>> appear in the actual .git/config file first in the editor and then =
show a
>>> way to use the "git config" command as an alternative.
>>
>> I disagree. Opening ~/.gitconfig will just open an empty file for th=
e
>> new users, afterwards they'll just scratch their heads wondering, no=
w
>> what?
>
> Why on earth would anybody start introducing ~/.gitconfig before talk=
ing
> about .git/config?

In most people's minds 'configuring git' means a global configuration.
The first configuration most people do is to configure their e-mail,
doing it for only one repository is not useful at all.

> A good sequence would be:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0To start working on a tarball extract (or =
your uncontrolled
> =C2=A0 =C2=A0 =C2=A0 =C2=A0project) with git, first do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git init
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Whoa. =C2=A0That was fast. =C2=A0Did it do=
 anything? =C2=A0Yes, it created a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0subdirectory .git that is going to store y=
our history and other
> =C2=A0 =C2=A0 =C2=A0 =C2=A0control information. =C2=A0Right now you d=
o not have any history (nor
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the current state for that matter) recorde=
d in it, but it already
> =C2=A0 =C2=A0 =C2=A0 =C2=A0has some control information. =C2=A0One of=
 the more important one is
> =C2=A0 =C2=A0 =C2=A0 =C2=A0the per-repository configuration file. =C2=
=A0Take a look:

Most people don't start with 'git init' they start with 'git clone'

> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git config --edit
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0It would show something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[core]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... explain a bit on how simple the config=
uration syntax is ...
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0While you have it open, it would be a good=
 idea to add this to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0introduce yourself to git:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[user]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0email =3D clue=
ful@git.us.er
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0name =3D My Se=
lf
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If you work in multiple projects under the=
 same identity, you
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do not have to add user.email and user.nam=
e to each and every
> =C2=A0 =C2=A0 =C2=A0 =C2=A0repository this way. =C2=A0Instead, you ca=
n do that to your per-user
> =C2=A0 =C2=A0 =C2=A0 =C2=A0configuration file, like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git config --global --edit
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0but if you work in different projects usin=
g different mail address
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(e.g. work vs hobby projects), you would w=
ant to have this
> =C2=A0 =C2=A0 =C2=A0 =C2=A0information per-repository.

All that is already explained in detail, if people want a short-cut
this fits better:

Before making any commits, configure your user:
$ git config --global user.name "Simisani Takobana"
$ git config --global user.email simisani@gmail.com

This is what most guides use:

gnome:
http://live.gnome.org/Git/Developers

sourceforge:
http://apps.sourceforge.net/trac/sourceforge/wiki/Git

github:
http://github.com/guides/tell-git-your-user-name-and-email-address/6

sourcemage:
http://www.sourcemage.org/Git_Guide

archlinux:
http://wiki.archlinux.org/index.php/Super_Quick_Git_Guide

amarok:
http://amarok.kde.org/wiki/Development/Git

I could continue.

The reason why they use 'git config --global' is because introductions
must be quick so that the user can do something useful as fast as
possible. Many people are not patient enough and even when the guide
is simple and fast people still send patches with wrongly configured
email addresses.

This is a more usual (and pleasant) introduction to git:

$ git config --global user.name "Foo Bar"
$ git config --global user.email foo.bar@gmail.com
$ git clone git://git.gnome.org/foo

make changes

$ git commit -a
$ git format-patch origin/master

There, the user has achieved something useful. Hopefully at that point
the user will say:

Hey, that was easy, I wonder why people complain about git not being
user-friendly. Let's read a bit more about what I just did.

--=20
=46elipe Contreras
