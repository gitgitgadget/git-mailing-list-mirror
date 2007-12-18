From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Explain what 'ginstall' is
Date: Tue, 18 Dec 2007 15:03:09 +0100
Message-ID: <200712181503.10614.jnareb@gmail.com>
References: <Pine.LNX.4.64.0712171641370.24957@fractal.phys.lafayette.edu> <200712181333.01051.jnareb@gmail.com> <20071218143246.2437bfaf@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Dougherty <doughera@lafayette.edu>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 18 15:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4d3V-0002eT-6C
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 15:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928AbXLROD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 09:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757916AbXLRODZ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 09:03:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:19506 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873AbXLRODY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 09:03:24 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1360431nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=dLc/aMXSYI/yDXq/aCJLnlyvAdOJfExTPUEuRRQErw0=;
        b=c6NqwMTQR1EsM2e2/9YJeh9rDKBXym5F6Jw/EjNtuXHauaSiEjt6MO04sowFbbkkntus+k7Ap8vzo0AN0F01d0jjlpvNclZBDyw2+HfXKREsN4YASneBtKsTzTOVBFCtHbLR4vxnSxs7Nr2Ckr0AUHX5wjBPtP24j2eNwklvbhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dfTk5KMjW5Icv+NutfaQfcAs2aB3ti9yfMfOMrYz88NYowH2Eh2/1x+F8riZ5NIbcd913bZOnwkkW6tx3vFBb0QLKX0/dkYyV3JK+QDyIGE4bJrdYF2LExYJpOTUZhwh1f7Dy8NfXOXOZP15g1hsSIVgI18tM3XFoJV0D1eM1Zs=
Received: by 10.86.51.2 with SMTP id y2mr7684568fgy.6.1197986599913;
        Tue, 18 Dec 2007 06:03:19 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.255.201])
        by mx.google.com with ESMTPS id l19sm4390387fgb.2007.12.18.06.03.17
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 06:03:18 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20071218143246.2437bfaf@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68749>

On Tue, 18 Dec 2007, H.Merijn Brand wrote:
> On Tue, 18 Dec 2007 13:32:59 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>> H.Merijn Brand wrote:
>>> On Tue, 18 Dec 2007 10:14:38 +0100, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> 
>>>> What is ./configure output in your case?
>>  
>>> /pro/3gl/LINUX/git-2007-12-17 119> cp /pro/3gl/GNU/gcc/r3/gcc-4.2.2/install-sh install-sh
>> 
>>> -- uncommented the AC_PROG_INSTALL line ...
>> 
>>> OK, rebuild configure ...
>>> 
>>> a5:/pro/3gl/LINUX/git-2007-12-17 129> make configure
>>>     GEN configure
>>> a5:/pro/3gl/LINUX/git-2007-12-17 130> rm config.{log,status}
>>> a5:/pro/3gl/LINUX/git-2007-12-17 131> configure --prefix=/pro/local \
>>>    --disable-nls --without-iconv --with-perl=/pro/bin/perl >& config-log 
>>> a5:/pro/3gl/LINUX/git-2007-12-17 132> grep -w install config-log config.log config.status
>>> config-log:checking for a BSD-compatible install... /opt/imake/bin/install -c
>>> config.log:configure:2218: checking for a BSD-compatible install
>>> config.log:configure:2273: result: /opt/imake/bin/install -c
>>> config.log:ac_cv_path_install='/opt/imake/bin/install -c'
>>> config.status:INSTALL="/opt/imake/bin/install -c"
>> 
>> Does chosen by ./configure script 'install' binary, namely 
>> /opt/imake/bin/install works correctly, meaning does it install
>> git correctly?
> 
> No. I reported this before, but not to the list. This is why I created
> my own make-install shell:

I though that you were talking about _default_ 'install' program
(first in PATH). Is /opt/imake/bin/install used below?

I have forgot to tell that beside uncommenting AC_PROG_INSTALL line
in configure.ac (and doing "make configure") you have to also uncomment
the "INSTALL = @INSTALL@" in config.mak.in for "make install" to use
install program found by ./configure script.

> /pro/3gl/LINUX/git-2007-12-17 113> make install
>     SUBDIR git-gui
>     INDEX lib/
>     SUBDIR gitk-git
> make[1]: Nothing to be done for `all'.
>     SUBDIR perl
>     SUBDIR templates
> install -d -m 755 '/pro/local/bin'
> rm: /pro/local/bin/ directory
> Usage: mv [-f] [-i] [-e warn|force|ignore] f1 f2
>        mv [-f] [-i] [-e warn|force|ignore] f1 ... fn d1
>        mv [-f] [-i] [-e warn|force|ignore] d1 d2

Strange...

By the way, I have took a look at hos ./configure script chooses which
'install' to use, and at least for GNU Autoconf 2.59 it does not talk
about HP-UX at all, and checks binaries to reject by grepping for
a string, instead of checking if it install files correctly using some
script (at least checking if it install files and creates directories,
and accepts install options used, without checking for correct permissions
and group, etc.).

Relevant fragment of generated ./configure script

-- >8 -- configure

# Find a good install program.  We prefer a C program (faster),
# so one script is as good as another.  But avoid the broken or
# incompatible versions:
# SysV /etc/install, /usr/sbin/install
# SunOS /usr/etc/install
# IRIX /sbin/install
# AIX /bin/install
# AmigaOS /C/install, which installs bootblocks on floppy discs
# AIX 4 /usr/bin/installbsd, which doesn't work without a -g flag
# AFS /usr/afsws/bin/install, which mishandles nonexistent args
# SVR4 /usr/ucb/install, which tries to use the nonexistent group "staff"
# OS/2's system install, which has a completely different semantic
# ./install, which can be erroneously created by make from ./install.sh.
echo "$as_me:$LINENO: checking for a BSD-compatible install" >&5
echo $ECHO_N "checking for a BSD-compatible install... $ECHO_C" >&6
if test -z "$INSTALL"; then
if test "${ac_cv_path_install+set}" = set; then
  echo $ECHO_N "(cached) $ECHO_C" >&6
else
  as_save_IFS=$IFS; IFS=$PATH_SEPARATOR
for as_dir in $PATH
do
  IFS=$as_save_IFS
  test -z "$as_dir" && as_dir=.
  # Account for people who put trailing slashes in PATH elements.
case $as_dir/ in
  ./ | .// | /cC/* | \
  /etc/* | /usr/sbin/* | /usr/etc/* | /sbin/* | /usr/afsws/bin/* | \
  ?:\\/os2\\/install\\/* | ?:\\/OS2\\/INSTALL\\/* | \
  /usr/ucb/* ) ;;
  *)
    # OSF1 and SCO ODT 3.0 have their own names for install.
    # Don't use installbsd from OSF since it installs stuff as root
    # by default.
    for ac_prog in ginstall scoinst install; do
      for ac_exec_ext in '' $ac_executable_extensions; do
	if $as_executable_p "$as_dir/$ac_prog$ac_exec_ext"; then
	  if test $ac_prog = install &&
	    grep dspmsg "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
	    # AIX install.  It has an incompatible calling convention.
	    :
	  elif test $ac_prog = install &&
	    grep pwplus "$as_dir/$ac_prog$ac_exec_ext" >/dev/null 2>&1; then
	    # program-specific install script used by HP pwplus--don't use.
	    :
	  else
	    ac_cv_path_install="$as_dir/$ac_prog$ac_exec_ext -c"
	    break 3
	  fi
	fi
      done
    done
    ;;
esac
done


fi
  if test "${ac_cv_path_install+set}" = set; then
    INSTALL=$ac_cv_path_install
  else
    # As a last resort, use the slow shell script.  We don't cache a
    # path for INSTALL within a source directory, because that will
    # break other packages using the cache if that directory is
    # removed, or if the path is relative.
    INSTALL=$ac_install_sh
  fi
fi
echo "$as_me:$LINENO: result: $INSTALL" >&5
echo "${ECHO_T}$INSTALL" >&6

-- 
Jakub Narebski
Poland
