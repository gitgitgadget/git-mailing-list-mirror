From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: questions about git-mktree
Date: Sun, 10 May 2009 08:31:52 -0700 (PDT)
Message-ID: <m3d4ahm0t6.fsf@localhost.localdomain>
References: <2cfc40320905100641v3e8742c4v1d0e1091a730970b@mail.gmail.com>
	<20090510151200.GA10189@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>, gitster@pobox.com,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun May 10 17:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3B0T-0005vK-3J
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 17:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbZEJPby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 11:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbZEJPby
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 11:31:54 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:56894 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbZEJPbx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2009 11:31:53 -0400
Received: by fxm2 with SMTP id 2so2241120fxm.37
        for <git@vger.kernel.org>; Sun, 10 May 2009 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=TZMr6U679OHGJUlngbfF8m15JIgKSDah35QHMr4Kbig=;
        b=Dc4vO+ndDleP921U9PKmcguK3fa5KdDdmSTheVveZMnBvmM62re8/iGItKlo1wL0Rs
         5CaIYlYGLWGOcYLeDZjNkvqdWkObW/uiBM+oF9RvrvH6RYLo8FL1JMtKqaSVYocZh7aN
         bAQvUdHbFxXFb0qt49TQFLNyGiKwCQNaO8EtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=hazXg/vMF01UwGzlVmAUNJUCIr8g0I4dnWBeKB8RtKXJdr07NSOXPjWHIoN5gdVX2J
         DAJgzM4gUyonEqYQ3DEGmAHKjivYNLWWz02nfc8FrHDfwuTH9stGys0cQ6dYHBdaSMJk
         fqohdTWcdNrDwTv8e3551lf+XJrQc/c7/3BWY=
Received: by 10.103.2.14 with SMTP id e14mr3634627mui.41.1241969512754;
        Sun, 10 May 2009 08:31:52 -0700 (PDT)
Received: from localhost.localdomain (abvi64.neoplus.adsl.tpnet.pl [83.8.206.64])
        by mx.google.com with ESMTPS id i5sm7751366mue.55.2009.05.10.08.31.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 May 2009 08:31:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4AFVpmu014453;
	Sun, 10 May 2009 17:31:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4AFVnQm014450;
	Sun, 10 May 2009 17:31:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090510151200.GA10189@pengutronix.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118723>

Uwe Kleine-K=F6nig    <u.kleine-koenig@pengutronix.de> writes:

> Hello Jon,
>=20
> On Sun, May 10, 2009 at 11:41:17PM +1000, Jon Seymour wrote:
> > Thanks for your explanation.
> >=20
> > Does git-mktree normalize the sort order of the input or take it as=
 it
> > is? I can see  a case for having it do normalization, if it doesn't
> > already and probably for this to be the default behaviour.

> As git-mktree doesn't exists I cannot answer that question ...

$ ls $(git --exec-path)/git-mktree
/usr/libexec/git-core/git-mktree

Examining mktree.c a bit you can see that there is qsort using
ent_compare in write_tree procedure.  It is not long file: 131 lines.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
