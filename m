From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sat, 27 Mar 2010 12:16:27 +0530
Message-ID: <f3271551003262346g286e7e72u751e15cbc99a9c1@mail.gmail.com>
References: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 07:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvPnW-0002DO-Ea
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 07:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab0C0Gqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Mar 2010 02:46:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59403 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab0C0Gqs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 02:46:48 -0400
Received: by gyg13 with SMTP id 13so489898gyg.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Kx7nN7vF7tK1l24uggRL7+q3tteYqmweftTQOwj+A+I=;
        b=Xoh1t7KfM0DQdq4XqUc8z2zYmq435ZBmDOK+dtS0cI0zJ/8WDngpm6pEoN+/LfsSZS
         VUjFyuoPoWHDDgL7piopt2TPtJcJPS0AMnOJA3YNO46ouprkbEY1OSGfFfwCKNIEHvWA
         +cizbLWcWgbnaLOceZ0Es+Jf+47ThihbwQ7ss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=cnUrNUXmr2ec3Px67X2ZNUM74eWG+iy1gP5WnWJoPfVgbWwnNmkHnVb0p6cprFTj15
         R3dje0CeijmUfnLpPf8cif5mYhhXYwt/+NaGE9DgF6m2iBAWKOAc57yA9GvNf2y78RHN
         TfIP2K4MgPbAL1WQwujMrI5GbyYPpd8hFBYI8=
Received: by 10.90.52.9 with HTTP; Fri, 26 Mar 2010 23:46:27 -0700 (PDT)
In-Reply-To: <3d4937ff1003262240t6159d9c5sc9253f555c3aed1@mail.gmail.com>
Received: by 10.91.95.14 with SMTP id x14mr1475679agl.1.1269672407108; Fri, 26 
	Mar 2010 23:46:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143318>

[Please don't cull people from cc]

> Would cython meet the needs of increasing the speed of the python cod=
e
> without requiring a rewrite?

Actually, I've subsequently decided that this is unnecessary. Besides,
I'm writing in C mainly for portability to msysgit (Windows). Could
you please look at the updated version of my project proposal?

> I work at a company with a LDAP server that I can look up the svn use=
rname to
> get real name and email address. =A0This way I don't have to manually=
 maintain a
> svn authors file.

> I'm torn on how the current system handles this, =A0I like all tags t=
o
> be tags, and
> that if a tag had a branch like behavior (bad SVN users!), that a bra=
nch exists
> for it, with the tag pointing to its branches head.

This shouldn't be a problem to implement/ improve at the end of my
GSoC term. However, it's important that I don't lose focus and
concentrate on the core task at hand for GSoC, which is more about
getting native support for SVN than anything else. I have neither the
expertise or time (one GSoC term) to build a fantastic importer and
get native support: I will be re-using several parts of existing
importers for the purpose of the GSoC.

> Support for SVN's blank folders. =A0Some of the old build systems I h=
ave used
> need the blank folders, so I have to create to make the build work :-=
(

Okay, this should be simple enough to implement. Thank you for pointing=
 it out.

> One of my SVN repositories using the current system fails to import t=
hat
> repository is missing a revision in its SVN history. =A0In other word=
s
> the SVN repo
> has corrupted history the current git-svn will fail to import the rep=
ository.

I'll keep this in mind when designing svn-fast-import: a certain
revision's checkout can fail, and a mechanism to bail the user out of
such a situation can be helpful. Again, I can't promise that this'll
be completed by the end of the GSoC term, but I will make it easy
enough to write the functionality in later on.

> If you want me to test your work on a hairy repository with corrupt h=
istory and
> thousands of branches, I'll do that for you.

Thanks! That'll be wonderful. If my proposal gets accepted, I
certainly will contact you (and several others) for testing, once the
core task of the GSoC is complete.

> But working at a company with lots of history in SVN makes me passion=
ate
> about the SVN integration in git :-)

Good to know. Thank you for your support :)

-- Ram
