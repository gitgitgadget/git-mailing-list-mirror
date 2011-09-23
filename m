From: Scott Chacon <schacon@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Fri, 23 Sep 2011 07:44:13 -0700
Message-ID: <CAP2yMaL3rewYZSXQFxkSLkiNbaBAP8r707x2dScVK1zeVr8hXQ@mail.gmail.com>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 16:44:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R76zD-0006NI-Uc
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 16:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372Ab1IWOoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 10:44:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59509 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab1IWOoN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 10:44:13 -0400
Received: by gyg10 with SMTP id 10so2592521gyg.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 07:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gOzXPto1iYVKHR6etgTQTOUSBYyfXZOqOin6lAJ3WKg=;
        b=Xu7ng2tjN9MepICMknTPOL+MQgbF5eZ8zih2BfK3r6VC89oqQEby2ObkWDJ0QUM9tl
         ry9FkwB7z5LGXlFkbTH3H3gBtYaBpCwZyliyked7DXzAf5YEKVpqu1YrOsAD5LckkPWi
         pq9AB6AtqD0WXmWZFebKPva6EAzqA+kbd4B84=
Received: by 10.150.213.7 with SMTP id l7mr3813509ybg.424.1316789053191; Fri,
 23 Sep 2011 07:44:13 -0700 (PDT)
Received: by 10.150.212.13 with HTTP; Fri, 23 Sep 2011 07:44:13 -0700 (PDT)
In-Reply-To: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181969>

Hey,

On Wed, Sep 21, 2011 at 10:04 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Here are the topics that have been cooking. =C2=A0Commits prefixed wi=
th '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.
>
> Here are the repositories that have my integration branches:
>
> With maint, master, next, pu and todo:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D git://repo.or.cz/alt-git.git
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D https://code.google.com/p/git-core=
/
>
> With only maint and master:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D git://git.sourceforge.jp/gitroot/g=
it-core/git.git
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D git://git-core.git.sourceforge.net=
/gitroot/git-core/git-core
>
> With all the topics and integration branches:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D https://github.com/gitster/git
>

It appears that you're no longer pushing the 'html' branch to the
GitHub repo, but you are to some of the other ones, which is sort of
strange because *everything* else is there.

Since the k.org hosting of the man pages is down, I was working on
putting them on git-scm.com, where you could select which version of
the docs you want to see and could search through them and whatnot.
Can you push 'html' to GitHub too?  I want to pull my data out of it
on an ongoing basis and it's the only one with a git object level API.

Thanks,
Scott
