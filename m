From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: [RFC] git-cvs script
Date: Sun, 31 May 2009 08:42:10 +0100
Message-ID: <b2cdc9f30905310042u592a6f5cv541055194524cce0@mail.gmail.com>
References: <4A213793.3030205@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Sun May 31 09:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAfgU-0000r6-VZ
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 09:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068AbZEaHmM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 03:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbZEaHmL
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 03:42:11 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:50315 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbZEaHmK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 May 2009 03:42:10 -0400
Received: by bwz22 with SMTP id 22so6892989bwz.37
        for <git@vger.kernel.org>; Sun, 31 May 2009 00:42:11 -0700 (PDT)
Received: by 10.103.215.15 with SMTP id s15mr2546282muq.118.1243755731004; 
	Sun, 31 May 2009 00:42:11 -0700 (PDT)
In-Reply-To: <4A213793.3030205@yahoo.co.uk>
X-Google-Sender-Auth: 5a85e4f03df9c1ef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120384>

2009/5/30 Nick Woolley <nickwoolley@yahoo.co.uk>:
> Hi,
>
> I have script which wraps git-cvsimport and git-cvsexport, called "gi=
t-cvs".
>
> The main aim of the script is to automate the steps for tracking a CV=
S
> repository with the git-cvs* commands.
>
> It's not currently as sophisticated as git-svn, it's undoubtably flaw=
ed and
> isn't foolproof (e.g. exports to CVS of merged git histories can be
> problematic), but I find it useful, because a lot of the nitty-gritty=
 is done
> for me.
>
> I'd like to ask:
>
> =A0- Is this at all useful to anyone else in it's current form?

If this is using the inbuilt cvsps and perl then it will likely choke
on very large CVS repos. For some CVS tree's I've had to resort to a
hacked up version of parsecvs to get a conversion running.

The other repo it tends to die on is ones which have been pruned (i.e.
old branches have been cut off). But people there have made a decision
to mess with their repo.

> =A0- Written in Perl, uses only core modules (tested with v5.8.8)
>
> =A0- There is a small test suite in t/, run individually or with "pro=
ve/*.t"
>

I'll give your script a spin on the repo I have here and I'll report
on how it does :-)

--=20
Alex, homepage: http://www.bennee.com/~alex/
CV: http://www.bennee.com/~alex/cv.php
