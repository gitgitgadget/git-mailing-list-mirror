From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: Re: [EGIT PATCH] Add support for writing/appending .gitignore file
Date: Mon, 20 Apr 2009 08:55:54 +0100
Message-ID: <4D1840C4-B04C-4D75-9A01-BDCDC40D0A29@gmail.com>
References: <AFFAB806-28F7-4D48-B603-B7B96052B0F3@gmail.com> <200904192350.56348.robin.rosenberg.lists@dewire.com> <636fd28e0904191940t3476b016qc76c0e1e624f7b37@mail.gmail.com> <200904200832.28361.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ferry Huberts <ferry.huberts@pelagic.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 09:57:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvoNs-0004KX-AB
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 09:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbZDTH4K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 03:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbZDTH4K
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 03:56:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:21866 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbZDTH4I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 03:56:08 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1237035ywb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=VQITX9Cl5e6ZY/gFptzkMkdu4FuyRtJoYGyEZ6zPClE=;
        b=QJmC4bjXndqG7JvQ/KVIg1W0y41zXH5IiWorWBWIa6DCFCWjVeEi0sxD1+KVeiOIXy
         pQX4GR/TA05zlp+0YGvkDOW9iSPBq37oZKhp1WAR8dpruDUGAVRLx5ZRAnbNzJISBKGh
         9lUex0LB5R9qsFGBGVYq6u+GnOEERU58R07d4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=rQW/Ocf/RUOYUN++sqIJfFGm5wbXACAL+KwqGMEHPnQ0C6rpmLdTTQbeia9vjT2dhP
         QzcyOhrDyN3St+sSD7ePryQaDFLyjxjRoGfILibesD6hIIwEaXqyY/wEMIwH8gfIPpQH
         b+FBYWYQ38usmS5pqgpk4X+l9rV5zVQY4vFpg=
Received: by 10.90.67.6 with SMTP id p6mr7120448aga.25.1240214167584;
        Mon, 20 Apr 2009 00:56:07 -0700 (PDT)
Received: from apple.int.bandlem.com (server.bandlem.com [217.155.97.60])
        by mx.google.com with ESMTPS id 4sm9921930agc.12.2009.04.20.00.56.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 00:56:07 -0700 (PDT)
In-Reply-To: <200904200832.28361.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116942>


On 20 Apr 2009, at 07:32, Robin Rosenberg wrote:

> m=E5ndag 20 april 2009 04:40:42 skrev Alex Blewitt <alex.blewitt@gmai=
l.com=20
> >:
>> On Sun, Apr 19, 2009 at 10:50 PM, Robin Rosenberg
>> <robin.rosenberg.lists@dewire.com> wrote:
>> One advantage of attaching issues is you don't have MUA problems :-)
>> I'll try and get a patch to work via git-send-email later.
>
> The problem is review. With e-mail I can just hit reply and comment =20
> on your
> patch. Did your try the SMTP interface to gmail? I think e-mailing =20
> inlined patches is
> a nearly perfect. Inline-attachment is ok with me. That makes it =20
> possible to
> comment on them like any email in my mail program.

Right, but the same approach is possible in a bug tracking system - =20
just comment. And people get a notification that a change has =20
occurred, too. Except instead of one giant inbox of a collection of =20
patches, all the discussion/feedback/comments are limited to the right =
=20
scope (i.e. just that bug/patch). In fact, quite a lot of review goes =20
on outside of the mail client and directly inside the editor e.g. via =20
Mylyn or internal web browser to the issue.

It also allows others - who might not be on the original 'to' list - =20
to subscribe to a bug (or star it, in Google's terms) to receive =20
notifications and see specific updates.

>> I've been incrementally committing to my local git copy. Whenever I =
=20
>> do
>> git format-patch <since> it spews out individual patchettes. How =20
>> can I
>> use git to generate one patch? I could git diff <since>, but that's
>> not following the SUBMITTING_PATCHES, is it?
>
> Often, after a long session, you end up with a "mess" of commits, =20
> many which
> don't make sense to anyone but you. For this you use rebase -i to =20
> clean up.

Great, that's useful to know. Unfortunately, I get an error when I try =
=20
this:

apple:egit alex$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 9 commits.
#
nothing to commit (working directory clean)

apple:egit alex$ git rebase -i origin/master
Working tree is dirty
apple:egit alex$ git rebase -i d0fd6f96b9311b972c6bffa8680544607d7e3c56
Working tree is dirty
apple:egit alex$

I'm probably doing something obviously wrong here, but I don't know =20
how to understand the difference between 'working tree is dirty' and =20
'working directory clean', especially since git status (or git commit -=
=20
a) doesn't show any differences.

Please excuse me whilst I figure out how to get comfortable working =20
with git ...

Alex
=09
