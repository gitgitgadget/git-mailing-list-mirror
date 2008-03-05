From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Wed, 5 Mar 2008 14:33:49 +0600
Message-ID: <7bfdc29a0803050033y5aca6b93ma7791ebf070ea8da@mail.gmail.com>
References: <20080304051149.GS8410@spearce.org>
	 <1b46aba20803041247h5cc64186q2abf7973372fd3ef@mail.gmail.com>
	 <20080305053612.GA8410@spearce.org>
	 <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
	 <20080305081523.GK8410@spearce.org>
	 <7bfdc29a0803050025p45dfcea9q87a1107a8bed46a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Carlos Rica" <jasampler@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:34:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWp54-0001WC-KA
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYCEIdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbYCEIdx
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:33:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:1776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbYCEIdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:33:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3151899ugc.16
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 00:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2NgBQlSX1rvMtu5+2dsD2gWq3JNJZ+kMkt6SjaQI/bk=;
        b=bs06GtmeEWu07s1CRXp8GTAEMVKPjhjTXnm2WEOnkLh1U/HaWFwBGLYFEnxVLGs1LK2sEH2FXbJGqb2WcGodkylK0Fba5MBKC8NY1SlncAaATpNLh9q7tkXiezn5mTml+jzIIrH0+ceXz0C5erAtEB24t9I6GxIOYJEw/TTvdtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fvT+WXftq4ong6LPmmuGIdE3mMvWr3rpNXDZsnDojkNDHdO1sYhTgz4QgJ96ACSil9egzDnk3IO5hO0c3m7s1hY4g9taq+AxpNMelFv68EJ8qWXxPdZIfObSLp15UJY3VXmcS45i0Rvudf+r2TI5uXQUSoqTWoNse3hQSgW84o0=
Received: by 10.78.148.8 with SMTP id v8mr5560209hud.31.1204706030082;
        Wed, 05 Mar 2008 00:33:50 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Wed, 5 Mar 2008 00:33:49 -0800 (PST)
In-Reply-To: <7bfdc29a0803050025p45dfcea9q87a1107a8bed46a6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76192>

On Wed, Mar 5, 2008 at 2:25 PM, Imran M Yousuf <imyousuf@gmail.com> wrote:
>
> On Wed, Mar 5, 2008 at 2:15 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>  > Imran M Yousuf <imyousuf@gmail.com> wrote:
>  >  > 1. GIT SCM Plugin for NetBeans (GPLv2 with CPE, same as NetBeans)
>  >  > The aim of the plugin is to integrate GIT with NetBeans using JNI so
>  >  > that any change in the implementation of GIT does not effect the SCM
>  >  > plugins way of work.
>  >  > Language: Java
>  >  > Goal: Make GIT available from IDE for NetBeans users and use GIT using
>  >  > Java Native Interfaces
>  >
>  >  Interesting, but libgit.a is *not* suitable for embedding inside of
>  >  a JVM.  Its no fun when a low level Git function suddenly calls die()
>  >  because it was fed invalid user input like a mistyped branch name.
>  >  Your whole IDE shutsdown without a chance to save files.
>  >
>  >  So that leaves you with three possible routes:
>  >
>  >   * Use JNI and libgit.a
>  >
>  >     Now you have three projects, not one.  You first need to make
>  >     libgit.a embeddable.  *Then* you can work on a JNI wrapper,
>  >     and finally you can build the UI.
>  >
>  >   * Use jgit
>  >
>  >     Its at least 100% pure Java and doesn't have the libgit.a issues
>  >     I mentioned above.  Its also got some active developers and its
>  >     userbase is growing.  We have been careful to keep jgit such
>  >     that it runs on any J2SE system, and thus does not require an
>  >     Eclipse environment.
>  >
>  >   * Use java.lang.Process and pipes
>  >
>  >     Ick.  Forking a running JVM, especially one the size of an IDE,
>  >     is not pretty.  At least on Windows you have CreateProcess(),
>  >     but on POSIX systems the JVM still does a fork/exec pair, and
>  >     on Solaris that hurts hard when your address space is large.
>  >
>  >  Of these only the latter two are really viable for any time to come
>  >  (just my opinion, but that's that).  jgit is coming along and may
>  >  actually be able to do most of the critical features that an IDE
>  >  demands, especially if more people work on it.  The latter option
>  >  is obviously available today, but doesn't offer anything near the
>  >  performance or integration that jgit does.
>  >
>
>  To start with I was actually thinking of JNI + "exec from C". So later
>  when libification is completed we can replace the execs with call to
>  the libs directly instead. Is this a viable fourth option (sorry I
>  forgot to mention it the first time around)?
>

Just wanted to add that we can also make them 2 separate projects and
the reason I wanted to go with JNI is to take advantage of the new
developments of GIT without having to change the API (unless a new
release of the API all together).

>
>  >
>  >  > 2. distributed versioned web system backup and restoration framework
>  >  > (GPLv2 with CPE, same as NetBeans)
>  >  > [I am not sure whether this one is even qualifies or not as a GIT
>  >  > Community Project]
>  >  > Language: Java, NetBeans RCP
>  >  > Goal: Develop a framework which can backup and restore data from
>  >  > different components of web application. For example, database, ldap,
>  >  > log, images, files (PHP, JSP, PY, HTML, JS, CSS etc.). Additionally
>  >  > allow edit and propagation of configuration in distributed nature,
>  >  > system restart, data restore. Also integrate backup and repo maintain
>  >  > to Amazon S3.
>  >
>  >  Yea, I'm not sure this falls too well under the Git community either.
>  >  I don't doubt that we would have sufficient mentor experience here
>  >  to support such a project, but the outcome in terms of both code and
>  >  a student who is familiar with it would not benefit Git very well,
>  >  if at all.
>  >
>  >  --
>  >  Shawn.
>  >
>
>
>
>
>
> --
>  Imran M Yousuf
>  Entrepreneur & Software Engineer
>  Smart IT Engineering
>  Dhaka, Bangladesh
>  Email: imran@smartitengineering.com
>  Mobile: +880-1711402557
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
