From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 14:25:43 +0600
Message-ID: <7bfdc29a0803050025p45dfcea9q87a1107a8bed46a6@mail.gmail.com>
References: <20080304051149.GS8410@spearce.org>
	 <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>
	 <20080305053612.GA8410@spearce.org>
	 <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
	 <20080305081523.GK8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Carlos Rica" <jasampler@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWoxF-0007Zd-4u
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600AbYCEIZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757093AbYCEIZq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:25:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:64827 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbYCEIZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:25:45 -0500
Received: by nf-out-0910.google.com with SMTP id g13so796870nfb.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rl6+Pd/CIBMfoy2ErL7to5b5nOVk7O8hiWLowC/pxcA=;
        b=x4pLHLb7jBg4koyWJbAeRSpNT0q4tftpOkMyQRbRlEjvrOnsRk0oI0lwBObzOZj4NOJPUYH1B99absA5RmqlptCoJNao3PtLzcMzlDE9S9omxq4uCKa+o3/qaSjGQAbhbmQJTq5j6WRB3HlcCkrtLLzSvwSS6epNUWKmbeOuQ8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ETbPvdiEQNmw0MLwf4PF8cJ6aSk9mtwyMPQPOkfEn81b31E3oqO15SnyHI4fYVN8/fc6HjnYgo93Wuxwomu5Xbr+cGdlmTRdISbG0nvEaiiznHLyGp1NPGFPLa1GZI9cnBSRYIG47iTzsoTOFPOklq4uc7xHSbIwYJJ4ZEJz2xM=
Received: by 10.78.195.10 with SMTP id s10mr5639331huf.10.1204705543613;
        Wed, 05 Mar 2008 00:25:43 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Wed, 5 Mar 2008 00:25:43 -0800 (PST)
In-Reply-To: <20080305081523.GK8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76190>

On Wed, Mar 5, 2008 at 2:15 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
>  > 1. GIT SCM Plugin for NetBeans (GPLv2 with CPE, same as NetBeans)
>  > The aim of the plugin is to integrate GIT with NetBeans using JNI so
>  > that any change in the implementation of GIT does not effect the SCM
>  > plugins way of work.
>  > Language: Java
>  > Goal: Make GIT available from IDE for NetBeans users and use GIT using
>  > Java Native Interfaces
>
>  Interesting, but libgit.a is *not* suitable for embedding inside of
>  a JVM.  Its no fun when a low level Git function suddenly calls die()
>  because it was fed invalid user input like a mistyped branch name.
>  Your whole IDE shutsdown without a chance to save files.
>
>  So that leaves you with three possible routes:
>
>   * Use JNI and libgit.a
>
>     Now you have three projects, not one.  You first need to make
>     libgit.a embeddable.  *Then* you can work on a JNI wrapper,
>     and finally you can build the UI.
>
>   * Use jgit
>
>     Its at least 100% pure Java and doesn't have the libgit.a issues
>     I mentioned above.  Its also got some active developers and its
>     userbase is growing.  We have been careful to keep jgit such
>     that it runs on any J2SE system, and thus does not require an
>     Eclipse environment.
>
>   * Use java.lang.Process and pipes
>
>     Ick.  Forking a running JVM, especially one the size of an IDE,
>     is not pretty.  At least on Windows you have CreateProcess(),
>     but on POSIX systems the JVM still does a fork/exec pair, and
>     on Solaris that hurts hard when your address space is large.
>
>  Of these only the latter two are really viable for any time to come
>  (just my opinion, but that's that).  jgit is coming along and may
>  actually be able to do most of the critical features that an IDE
>  demands, especially if more people work on it.  The latter option
>  is obviously available today, but doesn't offer anything near the
>  performance or integration that jgit does.
>

To start with I was actually thinking of JNI + "exec from C". So later
when libification is completed we can replace the execs with call to
the libs directly instead. Is this a viable fourth option (sorry I
forgot to mention it the first time around)?

>
>  > 2. distributed versioned web system backup and restoration framework
>  > (GPLv2 with CPE, same as NetBeans)
>  > [I am not sure whether this one is even qualifies or not as a GIT
>  > Community Project]
>  > Language: Java, NetBeans RCP
>  > Goal: Develop a framework which can backup and restore data from
>  > different components of web application. For example, database, ldap,
>  > log, images, files (PHP, JSP, PY, HTML, JS, CSS etc.). Additionally
>  > allow edit and propagation of configuration in distributed nature,
>  > system restart, data restore. Also integrate backup and repo maintain
>  > to Amazon S3.
>
>  Yea, I'm not sure this falls too well under the Git community either.
>  I don't doubt that we would have sufficient mentor experience here
>  to support such a project, but the outcome in terms of both code and
>  a student who is familiar with it would not benefit Git very well,
>  if at all.
>
>  --
>  Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
