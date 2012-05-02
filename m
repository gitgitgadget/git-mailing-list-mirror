From: David Aguilar <davvid@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #11; Sun, 29)
Date: Tue, 1 May 2012 23:04:06 -0700
Message-ID: <CAJDDKr7qzKUdQgr--6fPxa89qmo-KTaXT+UzLxosuJwBXPNbwQ@mail.gmail.com>
References: <7vbomahu1h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 02 08:04:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPSfo-000700-EX
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 08:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159Ab2EBGEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 02:04:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52392 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2EBGEH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2012 02:04:07 -0400
Received: by yhmm54 with SMTP id m54so290557yhm.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 23:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=R68QII0cjTa6GlwoODuIw8oa4c2/CXAghQ/6Zbdar3w=;
        b=sTyR+9V7+IVRbXt4/aVda7ZxB+MthVsPCwPkSb8j1nmhGDkEyRo8ywi6IWB77IqVGD
         atxzCRjhbe63CHjLx5RABmYi4l9y6eZAv6F2p45bmGntotuMFyAudpllXit+pzM+cxoS
         8J6980YzO07WvdTBBGucPe6F3xFtuMK9VUZm8jusDRCytSJpWfcevT6qV9mWNfJUPvbp
         hHJfmTJtgKksLxR8E6a6XelQyNEderKzd++smzS8nxKXbYAGLAUGVjHpSTqCSJyYoo9c
         gWq2+7YR8nu/YEst94jUokaEIYIgOTuFCOGtZfaOH0H5h4u8JyZHSLuJO7oy9x9CIJe1
         mmzQ==
Received: by 10.236.201.134 with SMTP id b6mr11671671yho.55.1335938646913;
 Tue, 01 May 2012 23:04:06 -0700 (PDT)
Received: by 10.146.153.6 with HTTP; Tue, 1 May 2012 23:04:06 -0700 (PDT)
In-Reply-To: <7vbomahu1h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196786>

On Sun, Apr 29, 2012 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> --------------------------------------------------
> [Cooking]
>
> * th/difftool-diffall (2012-04-23) 8 commits
> =C2=A0- difftool: print list of valid tools with '--tool-help'
> =C2=A0- difftool: teach difftool to handle directory diffs
> =C2=A0- difftool: eliminate setup_environment function
> =C2=A0- difftool: stop appending '.exe' to git
> =C2=A0- difftool: remove explicit change of PATH
> =C2=A0- difftool: exit(0) when usage is printed
> =C2=A0- difftool: add '--no-gui' option
> =C2=A0- difftool: parse options using Getopt::Long
>
> Rolls the two-directory-diff logic from diffall script (in contrib/) =
into
> "git difftool" framework.
>
> What's the doneness of this topic? =C2=A0David?

It looks good to me.  I've tested it and haven't seen anything
unexpected so far.

I was happy to see it "just work" when I tried it on both Linux and OS =
X.
--=20
David
