From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5
Date: Wed, 14 Oct 2009 15:11:50 -0700 (PDT)
Message-ID: <m3fx9lfwwr.fsf@localhost.localdomain>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 00:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyCHU-0007yt-K0
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 00:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762069AbZJNWNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 18:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762060AbZJNWNl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 18:13:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:60192 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbZJNWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 18:13:40 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1622641fga.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 15:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=HGiNgBz9oepArWmi+u+KMg+yfDSJ22vTg8Ze7ANTmiQ=;
        b=u1B3iHgtDFup3x2Fl6SuLUWyYKIwacZxAL7wDI7WX2OGDbIFcCMGZabZoNmEE52bYY
         2b1bEQO/DFstryA8pmXCV5m8gqIWUk4H3ZJCtCnxHZbLUHIItFNaa3bCGqlqQ1GMKh8e
         8WPv8KqNhzz5eewzLCShGZHb/KHBe/tr6kA0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Dn0SJjYF5WC9Bzumi8ukKACUqJHC0y7orOw6NR03BIa+7N5rV9uHry+fti3KCCtJDS
         u/7cFxNbSIcOJd2mwbDR9SIbW6DQHCULx2njtGUXyC+GXvya+K+Tody/kP75Hlvd9f+s
         ewb0PVLkCvl1DQ79lpdhjgdGnt1XKsgXPB8k0=
Received: by 10.86.211.38 with SMTP id j38mr8189393fgg.26.1255558311397;
        Wed, 14 Oct 2009 15:11:51 -0700 (PDT)
Received: from localhost.localdomain (abvu196.neoplus.adsl.tpnet.pl [83.8.218.196])
        by mx.google.com with ESMTPS id 3sm353952fge.14.2009.10.14.15.11.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 15:11:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9EMBoZQ014966;
	Thu, 15 Oct 2009 00:11:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9EMBn5m014963;
	Thu, 15 Oct 2009 00:11:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130343>

Junio C Hamano <gitster@pobox.com> writes:

> The latest feature release GIT 1.6.5 is available at the usual
> places:
> 
>   http://www.kernel.org/pub/software/scm/git/
> 
>   git-1.6.5.tar.{gz,bz2}			(source tarball)
>   git-htmldocs-1.6.5.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.6.5.tar.{gz,bz2}		(preformatted docs)
> 
> The RPM binary packages for a few architectures are found in:
> 
>   RPMS/$arch/git-*-1.6.5-1.fc9.$arch.rpm	(RPM)
> 
> This cycle took a bit longer than I hoped, but here it is.  We already
> have some new features cooking in 'next', and I expect we may be able to
> have 1.6.6 by the end of the year.

Compiling git from source RPM git-1.6.5-1.fc9.src.rpm using

  $ rpmbuild --rebuild git-1.6.5-1.fc9.src.rpm

fails with the following error:

    SUBDIR perl
/usr/bin/perl Makefile.PL PREFIX='/usr'
Only one of PREFIX or INSTALL_BASE can be given.  Not both.
make[1]: *** [perl.mak] Error 2
make: *** [perl/perl.mak] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.53174 (%build)

Compiling git from source with

 $ make prefix=/home/local/git \
        bindir=/home/local/git \
        gitexecdir=/home/local/git \
        template_dir=/home/local/git \
        GIT_PYTHON_DIR=/home/local/git 

gives the same error.

It might matter that I am using modern Perl way of installing Perl
modules locally, via local::lib, with ~/perl5/.modulebuildrc
containing 

  install  --install_base  /home/jnareb/perl5

and I have

  export MODULEBUILDRC="$HOME/perl5/.modulebuildrc"
  export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

Doing

 $ unset PERL_MM_OPT

before compiling (from SRPMS) made compilation pass this stage,
and finally succeed.

I guess that perl/Makefile (or rather the file that generates it)
should unset PERL_MM_OPT, or use INSTALL_BASE as DESTDIR rather
than fiddling with PREFIX.


But I am not a Perl hacker
------------------------------------------------------------
perl, v5.8.6
ExtUtils::MakeMaker 6.54 (local)
ExtUtils::MakeMaker 6.17 (global)

export MODULEBUILDRC="$HOME/perl5/.modulebuildrc"
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
-- 
Jakub Narebski
Poland
ShadeHawk on #git
