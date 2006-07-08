From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git
Date: Sat, 08 Jul 2006 23:28:00 +0200
Organization: At home
Message-ID: <e8p80a$jk3$1@sea.gmane.org>
References: <7vlkr5szi2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jul 08 23:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzKLC-0006V1-V5
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWGHV1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWGHV1w
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:27:52 -0400
Received: from main.gmane.org ([80.91.229.2]:23467 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030401AbWGHV1v (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:27:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FzKL5-0006Tl-CW
	for git@vger.kernel.org; Sat, 08 Jul 2006 23:27:47 +0200
Received: from host-81-190-22-25.torun.mm.pl ([81.190.22.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jul 2006 23:27:47 +0200
Received: from jnareb by host-81-190-22-25.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jul 2006 23:27:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-22-25.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23513>

Junio C Hamano wrote:

> I hope further patches to this series will be added soon to
> autodetect the following in our Makefile (from "pu"):

I have just (re)sent series of patches adding autodetection
of building options via autoconf generated configure.
 
>         NO_D_INO_IN_DIRENT
>         NO_D_TYPE_IN_DIRENT
>         NO_STRCASESTR
>         NO_STRLCPY
>         NO_SETENV
>         NO_SOCKADDR_STORAGE
Done.

>         USE_PIC
To be written by somebody better versed in autoconf.

>         NEEDS_SSL_WITH_CRYPTO
>         NEEDS_LIBICONV
>         NEEDS_SOCKET
Needs checking.

>         WITH_OWN_SUBPROCESS_PY
>         NO_IPV6
>         NO_ICONV
Needs explanation, and probably custom test.

> These are not something you can change without replacing libc
> (or installed Python) wholesale, so autodetection would be
> always correct.
> 
> Also the following would be nice if autodetection worked for
> most of the users with ./configure command line override:
> 
>       CC
>       AR
>       TAR
Done, I think

>       INSTALL
Needs lightweight install-sh script. If I remember correctly someone 
provided such script because of lack of install on some exotic 
architecture. Easily provided.

>       SHELL_PATH
>       PERL_PATH
>       PYTHON_PATH
To be done using --with-shell=PATH, --with-perl=PATH, 
--with-python=PATH, easily.

>       BASIC_CFLAGS    mostly for -I include paths
>       BASIC_LDFLAGS   mostly for -L library paths
>       ALL_LDFLAGS
I don't know how to do this (for now), probably quite easy.

>       NO_OPENSSL
>       MOZILLA_SHA1
>       PPC_SHA1
>       ARM_SHA1
>       NO_CURL
>       NO_EXPAT
>       CURLDIR
>       OPENSSLDIR
>       ICONVDIR
>       EXPATDIR (we do not have one, but I think it should be there
>                 to allow -lexpat installed elsewhere just like
>                 we have CURLDIR and OPENSSLDIR)
Should be done in next series of patches... provided I'd have enough 
free time for this... 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
