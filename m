From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sat, 20 Sep 2008 09:45:22 -0700 (PDT)
Message-ID: <m31vzen4v5.fsf@localhost.localdomain>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 18:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh5bP-0002RT-Fd
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 18:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbYITQp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 12:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbYITQp0
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 12:45:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:42002 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbYITQpZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Sep 2008 12:45:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so887191fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=B9gAf8EzrxC5Fes3zX5BNtlUv1a1L2Qaku6riStoU8s=;
        b=Mk2Trr3lnMxp8fnd2WzUWBUvCADR+Lz+WjMj6skh0qxfkY5iFfzgfxS/yhMsMcP5La
         Zm0oJsOZy8MTJWxujIRuWZSB5LONQU84y9ZRdvDYXU4e/InE2hU5z5kuz4quyAq593l1
         Tiyo0Fw9/YU06sOwX9F6HYGYsfsW8ZrIjRxd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=mbSo6SflzzhXZQkheOJKWx1rqVZw4crC1NvnvYN94yUTU8eYMlPal3As7moNZZrhIV
         6Ify7jQbBJqZFctLeoivZrKXCdhWm00k28TQGqD1LkSRbNHP6YMAm5dK+4XRAQzPfDkP
         T9cH36ZxWP2Eck2N1jYgP9UfTwgec6S0Uxubc=
Received: by 10.86.28.2 with SMTP id b2mr3225145fgb.31.1221929123774;
        Sat, 20 Sep 2008 09:45:23 -0700 (PDT)
Received: from localhost.localdomain (abvi94.neoplus.adsl.tpnet.pl [83.8.206.94])
        by mx.google.com with ESMTPS id d6sm2825800fga.2.2008.09.20.09.45.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 09:45:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8KGjJeu031668;
	Sat, 20 Sep 2008 18:45:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8KGjIcK031665;
	Sat, 20 Sep 2008 18:45:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96356>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Main changes from the last round are:
>  - The name is now "sparse checkout"

I guess that 'sparse checkout' would be more recognizable than 'narrow
checkout'.

>  - "git clone --path" =3D> "git clone --narrow-path"
>  - "git checkout --path" =3D> "git checkout --reset-path"

I am not sure about that change, especially the fact that git-clone
and git-checkout use differently named options, because those options
affect clone only as they affect the checkout part of the clone.  One
would think that git-clone =3D git-init + git-remote add + git-fetch +
git-checkout, and that git-clone would simply pass sparse checkout
flags to git-checkout.

>  - New narrow spec (or "sparse patterns" from now) resembles
>    .gitignore patterns

You mean here that rules for patterns to select which parts of tree
mark as "no-checkout" and/or checkout/leave in checkout are the same
(or nearly the same) as rules for ignoring files, isn't it?

BTW I think that the same rules are used in gitattributes, aren't
they?

>  - "git ls-files" now supports more fine-grained listing. It can now
>    list checkout files, no-checkout files or orphaned (previously
>    "overlay") files. --overlay is gone

Good.  I hope (I haven't read the post yet) that you extended '-t' and
'-v' output (or added similar option for no-checkout bit specially)
for git-ls-files.

>  - "git status" shows orphaned entries and remedies

Good.  I guess (I haven't read the post yet) that git-status displays,
or can be asked to display "orphaned"/"unwanted" files (files which
exists in working repository, but are marked with "no-checkout" bit),
and perhaps simply the fact that we commit/are in narrow checkout
(there is at least one file with "no-checkout" bit set in the index).

> For code changes, significant changes are:

>   [10/14] ls-files: support "sparse patterns", used to form sparse
>           checkout areas

Hmmm...
=20
> I hope I have addressed all the issues. If I miss anything, please
> speak up.
=20
By the way, pleas do not worry if there would be new round of
comments.  Sparse checkout is a new feature, and I think it is quite
important to get UI (interface) part, like names of configuration
variables and options first, or at least correct them before sparse
checkout hits released version.  It is harder IMVHO to change user
interface (this applies also to non-local repository data) due to
concerns for backwards compatibility; it is I think easier to correct
code.

> Nguy=C3=A1=C2=BB=C2=85n Th=C3=83=C2=A1i Ng=C3=A1=C2=BB=C2=8Dc Duy (14=
):

Errr... what happened here? For me it doesn't look like correct UTF-8
encoding, but perhaps that it is just my news client (Gnus)...

P.S. Thanks for numbering this series.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
