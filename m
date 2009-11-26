From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: Please help with GIT install problem.
Date: Thu, 26 Nov 2009 08:44:45 +0100
Message-ID: <4B0E31ED.4070002@statsbiblioteket.dk>
References: <377205.65475.qm@web30806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephan T." <stman937-lingit@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 08:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDZBp-0001Ts-6R
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 08:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759131AbZKZHyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 02:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759124AbZKZHyo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 02:54:44 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:41032 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759061AbZKZHyo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 02:54:44 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Nov 2009 02:54:44 EST
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.393.1; Thu, 26 Nov 2009 08:44:45 +0100
User-Agent: Thunderbird 2.0.0.22 (X11/20090710)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <377205.65475.qm@web30806.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133775>

Stephan T. wrote:
> Hello there,
> 
> My system is a:
> % uname -a
> Linux naboo 2.4.21-50.ELsmp #1 SMP Tue May 8 17:18:29 EDT 2007 i686 i686 i386 GNU/Linux
> 

Looks like you're on RHEL 3 or a derivative.

> Trying to install "git-1.6.5.3".  Configure goes happily to the end but make gives me the following error:
> 
>> make
>     CC fast-import.o
> In file included from /usr/include/openssl/ssl.h:179,
>                  from git-compat-util.h:138,
>                  from builtin.h:4,
>                  from fast-import.c:143:
> /usr/include/openssl/kssl.h:72:18: krb5.h: No such file or directory
> In file included from /usr/include/openssl/ssl.h:179,
>                  from git-compat-util.h:138,
>                  from builtin.h:4,
>                  from fast-import.c:143:
> /usr/include/openssl/kssl.h:134: syntax error before "krb5_enctype"
> 
> 
> What is missing on my system?
> 

You need to add "-I/usr/kerberos/include" to CFLAGS to build with 
openssl on el3.

Instead of doing your own build you could install the packages I 
maintain for my own use:
http://jupiterrise.com/tmp/git-el3

This is just a temporary location, in the future I hope so have this in 
rpmforge.

Not that perl-Git will require perl-Error from rpmforge 
(http://packages.sw.be/perl-Error)

-tgc
