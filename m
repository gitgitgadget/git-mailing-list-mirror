From: Markus Hitter <mah@jump-ing.de>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 14:48:52 +0200
Message-ID: <53EE01B4.3040905@jump-ing.de>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de> <53ED0257.3070505@jump-ing.de> <20140814222939.GA32124@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010203030504080504070107"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 14:49:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIGwG-0003t6-6T
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 14:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbaHOMs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 08:48:56 -0400
Received: from ud03.udmedia.de ([194.117.254.43]:54467 "EHLO
	mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaHOMsz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 08:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=mail.ud03.udmedia.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type; s=beta; bh=UvTvGqaEMALS6BSEPT1qmk76to
	GqX44HWfzjHZc/mso=; b=EqAIrUi1wfsKC36n0rizgnHBB/QPwhkN0iwPNalXql
	B6h6anVDz6ciYFL/puuYkfItg0N8zQkYRSOMOVpu7sUjERMhklmPJubBmyiGDxe+
	WI2nwrtcoXrZt7/5J4Wcb6NVqfxD1vK5usnu+xIcxtcg+rr1694wQU3fPtv0BqPN
	A=
Received: (qmail 6716 invoked from network); 15 Aug 2014 14:48:52 +0200
Received: from unknown (HELO ?10.0.0.102?) (ud03?291p1@134.3.201.241)
  by mail.ud03.udmedia.de with ESMTPSA (DHE-RSA-AES128-SHA encrypted, authenticated); 15 Aug 2014 14:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140814222939.GA32124@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255288>

This is a multi-part message in MIME format.
--------------010203030504080504070107
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Am 15.08.2014 um 00:29 schrieb Jonathan Nieder:
> Orthogonal to that: a patch to the Darwin section of config.mak.uname
> so you can build without the 'make configure' would be even more
> welcome. :)

On this one. You need at least NO_GETTEXT and NO_EXPAT. I've attached a config.mak.autogen to show what's needed.

However, if somebody chooses to install gettext or expat after OS installation, how is the build process expected to detect this? IMHO, checking for OS version number instead of actually available features is the wrong thing to do.


Markus

-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/

--------------010203030504080504070107
Content-Type: text/plain; charset=UTF-8;
 name="config.mak.autogen"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config.mak.autogen"

# git Makefile configuration, included in main Makefile
# config.mak.autogen.  Generated from config.mak.in by configure.

CC = cc
CFLAGS = -g -O2
CPPFLAGS = 
LDFLAGS = 
AR = ar
TAR = tar
DIFF = diff
PACKAGE_TARNAME = git
#INSTALL = @INSTALL@		# needs install-sh or install.sh in sources

prefix = /usr/local
exec_prefix = ${prefix}
bindir = ${exec_prefix}/bin
gitexecdir = ${exec_prefix}/libexec/git-core
datarootdir = @datarootdir@
template_dir = ${prefix}/share/git-core/templates
sysconfdir = ${prefix}/etc
docdir = @docdir@

mandir = ${prefix}/man
htmldir = @htmldir@

AUTOCONFIGURED=YesPlease
INLINE=
CC_LD_DYNPATH=
TCLTK_PATH=wish
NEEDS_SSL_WITH_CRYPTO=
NO_OPENSSL=
NO_CURL=
NO_EXPAT=YesPlease
NEEDS_LIBICONV=YesPlease
NO_ICONV=
NO_DEFLATE_BOUND=
NEEDS_SOCKET=
NO_INET_NTOP=
NO_INET_PTON=
NO_HSTRERROR=
NEEDS_RESOLV=
NEEDS_LIBGEN=
LIBC_CONTAINS_LIBINTL=
NO_GETTEXT=YesPlease
NO_SYS_SELECT_H=
NO_SYS_POLL_H=
NO_INTTYPES_H=
OLD_ICONV=UnfortunatelyYes
SOCKLEN_T=
NO_D_INO_IN_DIRENT=
NO_D_TYPE_IN_DIRENT=
NO_GECOS_IN_PWENT=
NO_SOCKADDR_STORAGE=
NO_IPV6=
NO_REGEX=
FREAD_READS_DIRECTORIES=
SNPRINTF_RETURNS_BOGUS=
NO_LIBGEN_H=
HAVE_PATHS_H=YesPlease
HAVE_LIBCHARSET_H=YesPlease
HAVE_STRINGS_H=YesPlease
CHARSET_LIB=-liconv
NO_STRCASESTR=
NO_MEMMEM=YesPlease
NO_STRLCPY=
NO_UINTMAX_T=
NO_STRTOUMAX=
NO_SETENV=
NO_UNSETENV=
NO_MKDTEMP=
NO_MKSTEMPS=
NO_INITGROUPS=
PTHREAD_CFLAGS=
PTHREAD_LIBS=
NO_PTHREADS=

--------------010203030504080504070107--
