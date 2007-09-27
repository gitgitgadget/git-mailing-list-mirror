From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 12:24:38 -0700
Message-ID: <94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	 <20070927185707.GC12427@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Kelvie Wong" <kelvie@ieee.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 21:24:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iayyd-000795-Nr
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419AbXI0TYl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756981AbXI0TYl
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:24:41 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:8072 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892AbXI0TYk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2007 15:24:40 -0400
Received: by an-out-0708.google.com with SMTP id d31so397591and
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=8Q1XTDuwGzMBzZNDwJ2A2TeJbJyPIurjbw6EtyoWrwo=;
        b=FBJMvxcTG5H8zT1Q5+PA0D4fJjs9eA4gEDGAptHpxCB7zNd+vdySNy4iwD2YGGeELpZ8fAtKcv7FjqRMw2udDqQyZdFJNqXv3DEmd4Koq+7scz9MwpPyr9FnpmRWN92ajCWHIir5b7vi3E1YrifeglcQI/TSV9f9BNm9MgjfNcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Cr+KJPwWvwuRxL8qqJko5KsoQZmrgXfmVJS+/k4TuKbfSWbbPdTTpv+FMKz1zGmeKq0sWnggztesfQzidUrxG7Hs0lJATvUiqVEF3/k7jXoOP3JTBJiGts76OgbY6XwveJcgGhPliPKAxyppKpNdh1wO0XTJxVRlSawAy+n7O10=
Received: by 10.114.92.2 with SMTP id p2mr283115wab.1190921078844;
        Thu, 27 Sep 2007 12:24:38 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 12:24:38 -0700 (PDT)
In-Reply-To: <20070927185707.GC12427@artemis.corp>
Content-Disposition: inline
X-Google-Sender-Auth: 24b89f1e99c5f328
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59318>

I've tried all of the ones that were supported, the result is the same
-- blank files in all three windows.

It is because git mergetool fails to generate these files for whatever
reason (the filebasename.{REMOTE,LOCAL,BASE}.* files).  I don't know
why this happens.

As for merge utilities, all I need is something that looks for the
first <<<<<, and lets me choose which version I want (either top or
bottom), plain and simple :/  I don't even need/want a gui.

But oh well, I guess the answer here is to write a script that does it.

Kelvie

On 9/27/07, Pierre Habouzit <madcoder@debian.org> wrote:
> On Thu, Sep 27, 2007 at 06:31:19PM +0000, Kelvie Wong wrote:
> > At work, I've been using a git-svn import for my daily workflow (st=
ill
> > somewhat of a git newbie, but now has come to the point where it's
> > tough to work without it), and while rebasing from svn (on a rather
> > old branch), I found that the mergetool option does not work too we=
ll
> > for me.
>
>   Which tool are you using ? kdiff3 ? I've noticed that it often fail=
s
> miserably, or worse, create bad merges silentely with it.
>
>   And as none of the other merge tool that are supported are able to
> either do 3way merges, or have a decent UI (that definitely seems to =
be
> exclusive features) I've given up on git-mergetool (and to be fair, i=
t
> sucks, because it could be _sooo_ useful sometimes).
>
> --
> =B7O=B7  Pierre Habouzit
> =B7=B7O                                                madcoder@debia=
n.org
> OOO                                                http://www.madism.=
org
>
>


--=20
Kelvie
