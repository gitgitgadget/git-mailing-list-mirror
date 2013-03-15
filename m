From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: building git ; need suggestion
Date: Fri, 15 Mar 2013 09:14:05 -0400
Message-ID: <20130315131403.GA27022@google.com>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
 <20130315124415.GA23122@paksenarrion.iveqy.com>
 <00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Fri Mar 15 14:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGUTA-0000KA-VS
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 14:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab3CONOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 09:14:14 -0400
Received: from mail-ye0-f202.google.com ([209.85.213.202]:45419 "EHLO
	mail-ye0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab3CONOH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 09:14:07 -0400
Received: by mail-ye0-f202.google.com with SMTP id q5so332384yen.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qlHUA64WCLzbkBDy48oYi95p/ITjtNwj0gYZLNx//Zs=;
        b=Pm/MesifD9MeEKpCzcq6JuFeIkEzz2IbktcW4YLdOV7jp3xY8ZhjrXNF/5ZR/zbRO3
         T1D8l1aM7zGsaV/8A2d9W714b1j3LWBQrRzuHnB2AAHbQiEBW1TUp1Ce/tbynlNNjqR0
         et21fWvmKTC86x2CaxIIUkJ5pYOE3Nu31rJZl3W371y4+1T5lN8PFDzV6r7jSG+baShW
         VbgSBblxy+MPfgwTipEipbkX5T0RmOwDqGY5tw+5XL33yMKg9uzPsDJFErjof/YE4e1m
         ifMqH9iB1aNH4vvU2PN6HZvxxndbYMG0RhEWyauki54rkUMndbD62RcybeEZGecjl208
         nYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent:x-gm-message-state;
        bh=qlHUA64WCLzbkBDy48oYi95p/ITjtNwj0gYZLNx//Zs=;
        b=pE6lvZVRxoRz9fAkSpBDFJ5C8sTUYihAAS61+VqrfSuoxunAXQCx2p6bSvPl04SCoS
         chXG4DGwS4ryiGzc2Q8Q28gr0cybN/tZBxZ4rr7gfDDqMT/uxMKTCy3M/+bAGzQzKNfZ
         qsb9aaGM9nTjAVAp3FYVpB/AMIjxjcrgSV1aOOnAeQdM8u1V99qx/dUPMvmzO+sgSSQq
         CSvNQQVpYLzb53wi0aEGp3WrXRRlrPLwBd4UsN2IPnYyhJAQkPgdB2GlGlogit672WOp
         n32gCBFfja4wlmSgldcTyxV/u/4R/twO/n2vBJ7f6+QQ2OmIIxYIKm0u8y09gujrGwME
         W95g==
X-Received: by 10.52.71.7 with SMTP id q7mr2957269vdu.3.1363353246767;
        Fri, 15 Mar 2013 06:14:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id b67si740303yhi.2.2013.03.15.06.14.06
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Fri, 15 Mar 2013 06:14:06 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A5F315A4158;
	Fri, 15 Mar 2013 06:14:06 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 193D14052E; Fri, 15 Mar 2013 09:14:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQloQXUXlIPZYu4YZgIPcOO0hA08lsbi0PK8O7KSE6qQ2q9EZ4IyAMe2tN26TjuuwRdY07miMBu4uDaBrq/98FyVak8dbJYtYEyzH2c7dK7Gr1AST76vT+9oRmNdS3mq3J69eRAU2AuXFbVVqzSo2GYOEMPgUDUbxTBg5esdHrjysx+3h48JnZl6SA4wxKwecNJ0dvNV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218243>

On Friday, March 15, 2013 at 08:52 EDT,
     Joydeep Bakshi <joydeep.bakshi@infoservices.in> wrote:

> On 15-Mar-2013, at 6:14 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrot=
e:
>=20
> > gitolite have a more fine ACL. Check it out. However it doesn't
> > really meet your needs with web-interface (and I'm not even sure
> > about the ACL thing is fine enough for you). You can read more abou=
t
> > ACL in the git book: http://git-scm.com/book/ch7-4.html
> >=20
> > The webgui that's most populair is cgit and git-web. They don't do
> > ACL afaik.
> >=20
> > Why would you need ACL? Why not don't share the branches that are
> > going to be secret? Or are you looking for some branches to be read
> > only?
>=20
> Actually the branches have to be dedicated to a group of users.
>  developer branch ---> developers
> bug fixed branch --- > bug fixer
>=20
> and specific group don't need to RW permission on other branch.
> Obviously the admin must have the full permission on all these branch=
es
> and merge as per requirement.

Right, but that's R/W permissions. Almost any piece of Git hosting
software supports restriction of pushes. Discriminating *read* access
between developers and maintenance people sounds like a disaster if it'=
s
the same organization. Well, it sounds like a disaster even if there ar=
e
two different organizations working on development and maintenance, but
at least it's a reason.

Anyway, Gerrit supports per-branch read ACLs. As long as all changes go
through code review, perhaps Gerrit web interface works sufficiently
well as a repository viewer? Pushes that bypass code review won't show
up there.

http://gerrit-documentation.googlecode.com/svn/Documentation/2.5/access=
-control.html#category_read

> The web-interface is required for checking the history by the users
> themselves and for code review. I don't know any web interface which
> can show repo/branch based on authentication. I have tried gitweb but
> it can handle a single repo or multiple repo with single
> authentication. NO ACL

If you just have two levels of access you could have two separate
Gitweb sites and use Gerrit to replicate a subset of the branches
to each site. You could e.g. have gitweb-dev.example.com and
gitweb-maint.example.com and grant access to those sites accordingly.

--=20
Magnus B=E4ck
baeck@google.com
