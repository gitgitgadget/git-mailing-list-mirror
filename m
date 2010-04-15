From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Replace hard-coded path with one from <paths.h>
Date: Thu, 15 Apr 2010 05:27:49 -0700 (PDT)
Message-ID: <m3d3y0gath.fsf@localhost.localdomain>
References: <20100404222801.GB31315@arachsys.com>
	<20100406163525.GF15306@arachsys.com>
	<20100406163643.GG15306@arachsys.com>
	<n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com>
	<20100408105850.GD2146@arachsys.com>
	<m2x40aa078e1004080426u98fbe6b2zfa9a2726172f725@mail.gmail.com>
	<20100408115706.GE2077@arachsys.com>
	<z2o40aa078e1004080508z17c5e71by371bbe6e1cdb8c50@mail.gmail.com>
	<20100409054536.GB2151@arachsys.com>
	<20100413090604.GB770@arachsys.com>
	<20100413090713.GC770@arachsys.com>
	<7vsk6zt93s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 14:28:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2OAp-0005D4-Fh
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 14:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab0DOM1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 08:27:54 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44206 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab0DOM1w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 08:27:52 -0400
Received: by bwz25 with SMTP id 25so1505357bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xTLAhC8Wh67OrUIpXSpq2yn4HpKwIlF/j0rrkfGGtA8=;
        b=G+x/koHtyldA4qagV4X2rqL499z8/pjm+tn4e4N+oIWclBfKRnnVEmh1qx+BBFnaUi
         pYWRlIObqWj3qL2Ypxs4lsr89WXf46pl/hX2p+6LJ65OxmPUsKxvUAx7tHC41F7pzh/W
         z3dkxXXppU5Qm1Pud9aUj2IW/ax/q6fXEsBZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=W9donR2Io59bkR9KUQASe31aZXx/O5iTifMqADQKWfBMabPT2hgaTyNrnue6bjK8gJ
         z7sSNYo8Wh3Us4s02QPt/AvyehOP/+GczZ1kDvBsuQ9L/ShKlGHbdh1WSwfE7bV7jZE2
         0wP/DZyDXwCIn9J/yvn7ocM3aQ5cZdHpE7eLA=
Received: by 10.103.80.22 with SMTP id h22mr33152mul.127.1271334470410;
        Thu, 15 Apr 2010 05:27:50 -0700 (PDT)
Received: from localhost.localdomain (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id e10sm7774035muf.38.2010.04.15.05.27.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 05:27:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3FCRxHX026835;
	Thu, 15 Apr 2010 14:28:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3FCRc0T026831;
	Thu, 15 Apr 2010 14:27:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vsk6zt93s.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144975>

Junio C Hamano <gitster@pobox.com> writes:

> Chris Webb <chris@arachsys.com> writes:
> 
> > In exec_cmd.c, git hard-codes a default path of
> > /usr/local/bin:/usr/bin:/bin.  Get an appropriate value for the system
> > from <paths.h> if possible instead. We only try to include <paths.h> on
> > Linux, FreeBSD, NetBSD, OpenBSD and GNU where it is known to exist.
> >
> > Signed-off-by: Chris Webb <chris@arachsys.com>
> > ---
> >  Makefile          |   10 ++++++++++
> >  exec_cmd.c        |    2 +-
> >  git-compat-util.h |    6 ++++++
> >  3 files changed, 17 insertions(+), 1 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 910f471..f4fe941 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -735,10 +735,12 @@ EXTLIBS =
> >  ifeq ($(uname_S),Linux)
> >  	NO_STRLCPY = YesPlease
> >  	NO_MKSTEMPS = YesPlease
> > +	HAVE_PATHS_H = YesPlease
> >  endif
> 
> Ok.  Somebody else may want to add an autoconf support on top of this, but
> this is good as-is, I think.

Something like that?

-- >8 --
Subject: [PATCH] autoconf: Check if <paths.h> exists

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index e8d96e8..f0aeb8e 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -31,6 +31,7 @@ NO_OPENSSL=@NO_OPENSSL@
 NO_CURL=@NO_CURL@
 NO_EXPAT=@NO_EXPAT@
 NO_LIBGEN_H=@NO_LIBGEN_H@
+HAVE_PATHS_H=@HAVE_PATHS_H@
 NEEDS_LIBICONV=@NEEDS_LIBICONV@
 NEEDS_SOCKET=@NEEDS_SOCKET@
 NO_SYS_SELECT_H=@NO_SYS_SELECT_H@
diff --git a/configure.ac b/configure.ac
index 108a97f..9dc0320 100644
--- a/configure.ac
+++ b/configure.ac
@@ -633,6 +633,12 @@ AC_CHECK_HEADER([libgen.h],
 [NO_LIBGEN_H=YesPlease])
 AC_SUBST(NO_LIBGEN_H)
 #
+# Define HAVE_PATHS_H if you have paths.h.
+AC_CHECK_HEADER([paths.h],
+[HAVE_PATHS_H=YesPlease],
+[HAVE_PATHS_H=])
+AC_SUBST(HAVE_PATHS_H)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=],
-- 
1.7.0.1
