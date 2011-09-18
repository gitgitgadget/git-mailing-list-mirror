From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Most elegant way to reference to SVN from GIT?
Date: Sun, 18 Sep 2011 11:47:07 -0700 (PDT)
Message-ID: <m3litlsn82.fsf@localhost.localdomain>
References: <j53c2h$gff$2@dough.gmane.org>
	<20110918034318.GC17977@sigill.intra.peff.net>
	<j54keg$ug9$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 20:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5MOZ-0003Ab-P4
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab1IRSrK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Sep 2011 14:47:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45818 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab1IRSrJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2011 14:47:09 -0400
Received: by fxe4 with SMTP id 4so3246768fxe.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=UE4iEPay8+GiOYI6TK+fqY+NzatfMl1H9voAf19gCjM=;
        b=KPi3qfPQaHGKWlsJjCBRzaG05LDwHPEAW3/+cOAH1dwxnLegTJcNNKcf5CBIdjqg1z
         OfdeqvXcOqHvEQ2Iu0wl88U73/uKVYqLR1vIVkz4KRnKLQ+DkN+ne/tN7bcH4LT7Ndaw
         arqsYsUYPNKuc9+ILKLA7PvPVGPpS6NhBmbNs=
Received: by 10.223.47.216 with SMTP id o24mr3592163faf.145.1316371628392;
        Sun, 18 Sep 2011 11:47:08 -0700 (PDT)
Received: from localhost.localdomain (abvm199.neoplus.adsl.tpnet.pl. [83.8.210.199])
        by mx.google.com with ESMTPS id n15sm9780019fah.24.2011.09.18.11.47.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 11:47:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8IIkUuD030168;
	Sun, 18 Sep 2011 20:46:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8IIk6JF030164;
	Sun, 18 Sep 2011 20:46:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <j54keg$ug9$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181619>

Manuel Reimer <Manuel.Spam@nurfuerspam.de> writes:
> Jeff King wrote:

> > You can pull their commits into git using git-svn, and then merge t=
hem.

Nb. there is also so called "remote helper" approach, where you can
use repositories using other SCM just like native remote Git
repositories.  But I think it is in early beta, or even alpha stages -
- adding support for Subversion was this year Google Summer of Code
2011 project.
=20
> Tried that, but maybe I did something wrong.
>=20
> If I have a git-svn repo inside my git repo, then for some reason my
> own repo doesn't known the git-svn repo. Means that I cannot push
> changes, that occured in the SVN repo, to my GIT server.

Errr... isn't it more or less expected for _any_ remote repository
added, be it native (git) or Subversion one?

Remote tracking branches are not usually pushed / fetched, unless you
clone in a mirror mode, or set refspecs for fecthing / pushing by
hand...

--=20
Jakub Nar=EAbski
