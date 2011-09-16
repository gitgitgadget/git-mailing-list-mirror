From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: zealous git convert determined to set up git server
Date: Sat, 17 Sep 2011 00:39:22 +0200
Message-ID: <201109170039.22954.jnareb@gmail.com>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 17 00:39:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4h4I-0003WY-Mz
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 00:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab1IPWj3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 18:39:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab1IPWj3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2011 18:39:29 -0400
Received: by fxe4 with SMTP id 4so2120877fxe.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=raGBkrlUQPv/2oYOZNY2Hcc/SI8eXYhBEgZ+zGBKz7M=;
        b=lvXJLwHeOyFoIwVMvOLgXMysQglztayr04wmWCX8Fh1ZMrOzBUM1dYEN1dPGwGfZUH
         wRHVHlNqFiekzxJHUghIb5g3hSmhDVJQH/A0wfqy0CyLbL8DvB0AQ9/dvPW5kHXsUTHF
         7Ct1pwybMqfYsA5CcfwdwEqctzrPuZmjmMVm4=
Received: by 10.223.36.153 with SMTP id t25mr1474774fad.148.1316212767589;
        Fri, 16 Sep 2011 15:39:27 -0700 (PDT)
Received: from [192.168.1.13] (abvu156.neoplus.adsl.tpnet.pl. [83.8.218.156])
        by mx.google.com with ESMTPS id r3sm12137819fam.26.2011.09.16.15.39.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Sep 2011 15:39:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181564>

Joshua Stoutenburg wrote:
> 2011/9/15 Jakub Narebski <jnareb@gmail.com>:

> > I think that either "Pro Git" book, or "The Git Community Book"
> > would be a best source to learn about setting-up git server.
> >
> > I think the simplest solution for git hosting management would be t=
o
> > use gitolite (there are other git repository management software:
> > Gitosis, SCM Manager, Gitblit).
> >
> > If you want to host something like GitHub, there are open source
> > solutions too: Gitorious, InDefero, Girocco + gitweb,...
> >
> > HTH
> > --
> > Jakub Nar=C4=99bski
> >
> >
>=20
> I totally didn't see "The Git Community Book".  There's no link for i=
t
> where I was looking: http://git-scm.com/documentation

I think that link to "Git Community Book" (http://book.git-scm.com) on =
Git
Documentation page (http://git-scm.com/documentation) got replaced by t=
he
link to "Pro Git" book; I guess becaue the former is not finished and i=
t
doesn't look like it would be finished soon.

[...]
> Question 2: It seems gitolite is the popular choice for git user
> management.  Any reason why?

=46rom Gitosis and Gitolite, both git repository management tools, Gito=
sis
requires setuptools beside Python, and looks like it is not developed
anymore, while Gitolite (which started as rewrite of Gitosis in Perl)
requires only Perl and is actively developed.

Nb. even Gitosis author recommends Gitolite:
http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-sec=
ure-way

  Update (12-12-2010): For additional features not present in gitosis,
  check out gitolite.
=20
> Question 3: So, Gitorious is more than just a repository hosting
> website?  It's also an open source repository hosting platform, which
> powers the Gitorious website?  That's pretty cool.

Yes, GitHub:FI (this one proprietary), Gitorious (powering gitorious.or=
g),
InDefero, Gitblit and Girocco + gitweb (the last one powering http://re=
po.or.cz)
are all full-fledged git hosting sites, with web interface to view and
manage repositories.

--=20
Jakub Narebski
Poland
