From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: git undo # last command
Date: Fri, 16 Aug 2013 22:29:04 +0200
Message-ID: <20130816202904.GA21779@paksenarrion.iveqy.com>
References: <CAAUyY9ADW2iHVWhTGcTF8j0hrdumpBcLv_mLo0y8VDAyBpftJQ@mail.gmail.com>
 <20130816132612.GF20138@sigill.intra.peff.net>
 <CAAUyY9DqCrpMJPKKmzLGWVkoJRPfA5URLQz0uyTLZCPe6QKe5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: =?utf-8?B?U2HFoWEgVG9tacSH?= <tomic80@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 17 00:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VASNb-0004P7-TR
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 00:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab3HPWUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 18:20:16 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:41773 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab3HPWUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:20:15 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so1943259lab.35
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 15:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZZmghHsQsd5zR5jyhZmjZPb+Ph1S6yG0m0LE96zDuME=;
        b=AWYpekPef0DFr2RJX8tbz15d6EFg2aOlWWQSjOBo5Mxt++mJO4f/s2yhzG7dSNzZqn
         882lL3C3KIqzuoqafoSBb3IBkvH/C6QPwCGqGQoFL7NEPtmP7YbpLqL3It818ADiGcw5
         HC40ErEVaXaBiuaMFwNsUMoRc54rKAwRtSGhP5LjjqehPiilYFiySTzG52PWJRirj557
         c+h6l3Od+Rmn+FO4VEBJFk4gpLm3rtxcciQpNVCXLJAidm0IgHuV9ODvD7BhqUMNnq8z
         aFSptpBKIykAUfwzpFw33XtmaEIkBiKA3SoHAdywbDj188WJOjQ30scXFu/sxXx/eNoB
         j6zw==
X-Received: by 10.112.130.134 with SMTP id oe6mr3566151lbb.30.1376684698243;
        Fri, 16 Aug 2013 13:24:58 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id v5sm1602451lbv.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 13:24:57 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1VAQds-0005gi-Jl; Fri, 16 Aug 2013 22:29:04 +0200
Content-Disposition: inline
In-Reply-To: <CAAUyY9DqCrpMJPKKmzLGWVkoJRPfA5URLQz0uyTLZCPe6QKe5w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232440>

On Fri, Aug 16, 2013 at 04:21:59PM +0200, Sa=C5=A1a Tomi=C4=87 wrote:
> git commit =3D=3D> git reset --soft HEAD^
The commit does still exists, you can find it in the reflog. This is
important if you for example commits a huge file and wants to remove it=
=2E
That commit needs to be gc:ed too, and this is dangerous...

It's a not common, but often asked, question on #git@freenode . And for
many it's hard to understand why a git rm doesn't shrink their repo.

Also consider that many git commands relies on eachother. For example
the submodule scripts uses git checkout, clone, etc.
--=20
Med v=C3=A4nliga h=C3=A4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
