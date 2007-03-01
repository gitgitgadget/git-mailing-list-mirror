From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --pretty=changelog
Date: Thu, 1 Mar 2007 19:15:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703011912090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702271621120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <87y7mhrnrc.fsf@latte.josefsson.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1542346173-1172772950=:22628"
Cc: git@vger.kernel.org, junkio@cox.net
To: Simon Josefsson <simon@josefsson.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 19:19:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMpoo-0001Rk-8k
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 19:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965478AbXCASPx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 13:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965475AbXCASPx
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 13:15:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:49863 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965478AbXCASPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 13:15:52 -0500
Received: (qmail invoked by alias); 01 Mar 2007 18:15:51 -0000
X-Provags-ID: V01U2FsdGVkX1/DX6VxYkHDKz0NYIJkjUdyjqwrqaow5zlBTpk3+m
	K/Hekt9HF/+Nc4
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87y7mhrnrc.fsf@latte.josefsson.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41110>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1542346173-1172772950=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 1 Mar 2007, Simon Josefsson wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This outputs the log in GNU ChangeLog format.
> 
> Many thanks!  I ran this in my cvs->git repository for libtasn1, and 
> then did a diff against the output from cvs2cl in the old repository. 
> Here are some categories of differences:

No good deed goes unpunished, they say...

> 1) Indentation should be under the '*'.  Compare (wrong):
> 
>         * src/asn1Coding.c, src/asn1Decoding.c, src/asn1Parser.c: Improve
>           --help output.  Assume getopt_long, since gnulib provides it.

I saw that in your mail already, and I find the style cvs2cl outputs ugly.

> 2) Don't log anything for empty messages:
> 
>         * gl/.cvsignore: *** empty log message ***
> 
> Possibly, this should be an option.

It does not log anything for empty messages. Not even a colon.

> 3) Possible charset problem?  Compare this (correct):
> 
>         * configure.in: Fix -Wno-pointer-sign test to respect user-defined
>         CFLAGS.  Reported by "Diego 'Flameeyes' Pettenò"
>         <flameeyes@gentoo.org>.
> 
> with (wrong):
> 
>         * configure.in: Fix -Wno-pointer-sign test to respect user-defined
>           CFLAGS.  Reported
> 
> The git log do seem to contain the correct data, though, from git-log:
> 
>     Fix -Wno-pointer-sign test to respect user-defined CFLAGS.  Reported
>     by "Diego 'Flameeyes' Pettenò" <flameeyes@gentoo.org>.

No charset problem. In Git commit messages, the first line is special. It 
is the so called "oneline" description. If you wrap the oneline, it's your 
fault, not Git's.

> 4) Weird error, compare (correct):

This is exactly the same as 3).

> I'll let you fix these and resume the diff later. :)

As far as I am concerned, I don't think there is anything to fix. Except 
maybe the wrapping of your commit messages, but I guess it is too late now 
to change them?

> Can I pull your git tree from somewhere?  Applying patches from e-mail 
> is kind of boring.

No, I don't have a public Git tree.

Ciao,
Dscho

---1148973799-1542346173-1172772950=:22628--
