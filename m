From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] autoconf: clean temporary file mak.append
Date: Tue, 08 Aug 2006 22:58:02 +0200
Organization: At home
Message-ID: <ebatsd$f1g$1@sea.gmane.org>
References: <200608081834.09271.jnareb@gmail.com> <7vk65juff7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 08 22:58:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAYeU-0007LC-NH
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 22:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWHHU6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 16:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWHHU6I
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 16:58:08 -0400
Received: from main.gmane.org ([80.91.229.2]:59060 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965039AbWHHU6G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 16:58:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GAYeJ-0007IZ-WA
	for git@vger.kernel.org; Tue, 08 Aug 2006 22:58:04 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 22:58:03 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Aug 2006 22:58:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25089>

Junio C Hamano wrote:

> diff --git a/Makefile b/Makefile
> index d8cc835..d4297c2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -793,7 +793,7 @@ clean:
>       rm -f $(ALL_PROGRAMS) $(BUILT_INS) git$X
>       rm -f *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags
>       rm -rf autom4te.cache
> -     rm -f config.log config.mak.autogen configure config.status config.cache
> +     rm -f configure config.log config.mak.autogen config.mak.append config.status config.cache
>       rm -rf $(GIT_TARNAME) .doc-tmp-dir
>       rm -f $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
>       rm -f $(htmldocs).tar.gz $(manpages).tar.gz

I didn't add configure to make clean, because there was hand-crafted 
configure script in git.git.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
