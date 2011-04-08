From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Fri, 8 Apr 2011 19:58:21 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com> <4D9EDCEA.9010903@drmicha.warpmail.net>
 <20110408185924.GA25840@elie> <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
 <20110408194548.GA26094@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:04:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Huk-0004hq-CS
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757844Ab1DHUEN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 16:04:13 -0400
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:15209 "EHLO
	herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757789Ab1DHUEM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 16:04:12 -0400
Received: from herc.mirbsd.org (tg@localhost [IPv6:::1])
	by herc.mirbsd.org (8.14.5.Beta0/8.14.5.Beta0) with ESMTP id p38JwNku011577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Apr 2011 19:58:26 GMT
Received: (from tg@localhost)
	by herc.mirbsd.org (8.14.5.Beta0/8.14.5.Beta0/Submit) id p38JwMbT027994;
	Fri, 8 Apr 2011 19:58:22 GMT
Received: by S/MIME Plugin for MirBSD 10 Kv#10uAE-20110220 i386; Fri Apr  8 19:58:21 UTC 2011
X-X-Sender: tg@herc.mirbsd.org
In-Reply-To: <20110408194548.GA26094@elie>
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171154>

Jonathan Nieder dixit:

>Each git commit (try it with "git cat-file commit HEAD) looks like so:
[=E2=80=A6]
>So you see, using ordinary files [=E2=80=A6] makes a lot of
>sense.

True. I=E2=80=99d forgotten for a second that git is a stupid content
tracker and confused it with a VCS. My bad. Your reasoning is
of course sound. (I must admit I personally don=E2=80=99t have much
experience with git, other than losing a lot of data once.)

>Now Michael mentioned an alternative, which is to store this
>information in separate objects.  That way, you could push your

This might be an alternative. RichiH, what are the requirements?
I fear that the dotfile way will meet them better, considering
that they are versioned together, not separately, and what you
told me quickly about the idea.

bye,
//mirabilos
--=20
13:47=E2=8E=9C<tobiasu> if i were omnipotent, i would divide by zero
                all day long ;)
(thinking about http://lobacevski.tumblr.com/post/3260866481 by waga)
