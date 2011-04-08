From: Tharindu Rukshan Bamunuarachchi <btharindu@gmail.com>
Subject: keeping -RT and mainline tree in single repository
Date: Fri, 8 Apr 2011 12:33:25 +0530
Message-ID: <BANLkTikGMG76QhLaGfs-m-SizcaqnZ0mhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:04:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85je-0007oD-9P
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab1DHHD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:03:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35973 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab1DHHD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 03:03:56 -0400
Received: by vws1 with SMTP id 1so2482703vws.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=HF91K053iFL2B4TqIt4aXq+5FYWH54BncjjQbrt3vco=;
        b=OE3TwQIrz8wIxuaAlPTzBo17bEdxIDccPCGGHUyWSKsGYcUl3Dvv5gD0cre/33QNSy
         AFy84VP2BvTsavwomewMjzMINeYRkfVjyai7pIO0s7nyYTfLbG1adiWLWN8wo4DapU2e
         xwVNlu2UnDxpwHEBG53AepaZDRmmqMXOY1vx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=dHOzRhmzT/JK/609o+XPVg7OlDz2PgCnAkTyPh2BZWzGIGc6QDlMXr5YzlIPHkhD8q
         tOGlFltzezDnc9P9nqoY3FetgSjq5YMOwlFmTSDHya9WwhEGKVO1v2LlJEQQhQiNxDPJ
         nOEc2OgLm0UBu9r9P+U6WTszNzMIcAdqP6Rds=
Received: by 10.52.73.193 with SMTP id n1mr2731631vdv.226.1302246235266; Fri,
 08 Apr 2011 00:03:55 -0700 (PDT)
Received: by 10.52.166.106 with HTTP; Fri, 8 Apr 2011 00:03:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171108>

hi All,

at the moment i am pulling latest source from
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
and keep my driver development up-to-date with mainline.

i need to port my driver to -rt also.

1. do i have to pull and use another git repository from RT GIT. i.e.
git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
2. how can i use current GIT repository to keep sync with both -RT and
mainline ?
3. how can i pull latest commits without switching between branches. (
i hv two branches ... master & my-own-hacked). Every time i switch to
master and pull latest code.

Really appreciate if you can point howto/resource ?

Thanks in advance
__
Tharindu "R" Bamunuarachchi.
