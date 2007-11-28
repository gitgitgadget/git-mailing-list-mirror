From: Jakub Narebski <jnareb@gmail.com>
Subject: Adding Git to Better SCM Initiative : Comparison
Date: Wed, 28 Nov 2007 23:39:59 +0100
Message-ID: <200711282339.59938.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 23:41:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxVac-0003k9-0q
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 23:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbXK1WkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 17:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756573AbXK1WkF
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 17:40:05 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:25912 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241AbXK1WkD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 17:40:03 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1588629nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 14:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=LLW9RN8Yq6Z4L0EaPFMRgS3grX5agh7iPqxHErQcB9s=;
        b=leFKNm5S66j0UvMT2j7TZWS6mzbJjkZzm+kQF9psFGE6z1rIHDArmsRT23Dn17JRlsEcJOGq5CMpxWUR0ektDu/lUM6wV6vsXDD4qci9LcCwMYUXgalKGPSeA5m6YlxMifSI5ziUvTNuVquTPZhRN5Cso1m0KZqu0yNyCmGzb4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kPZChDrcgGf1cZp1JGbTBeMg3JFpXhRK7uWTtifvJjYJ3uczSSn+xztCbd9Y05RX+DJ4w2PIf7hyxcNjss2IzYHEHWk7lROvD+FSGScL9CpIJ76mMGLyy4KqoUrLH6rk+sXPtIo/v0Cj/gQoP/Vg6eRBil9CiTdnmDHoaoOCSKQ=
Received: by 10.86.72.15 with SMTP id u15mr531365fga.1196289600956;
        Wed, 28 Nov 2007 14:40:00 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.156])
        by mx.google.com with ESMTPS id i5sm11274500mue.2007.11.28.14.39.59
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 14:40:00 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66445>

I'd like to add Git to comparison table of SCMs at Better SCM
Initiative site:
  http://better-scm.berlios.de

To do that, I need to fill in infomration about Git.  Most
of questions / items didn't give much problem, but there
are a few on which I would like your input.

(Yes, I know that such SCM comparisons are usually biased towards the
idea of what are most important features of a version control system.
Nevertheless...)


1. Ease of Deployment

   How easy it is to deploy the software? What are
   the depenedencies and how can they be satisfied?

There are binary packages for Linux (RPM, deb) and for MS Windows
(msysGit).  Git requires POSIX shell, Perl, and POSIX utilities
(BTW. INSTALL file lacks full specification of dependences); although
there is ongoing effort towards making all commands builtin, in C.
Makefile contains ready configuration for many OS, and there is
autoconf script to generate Makefile configuration.

I'm not sure if the problems with compiling documentation to HTML and
manpage forms, which require AsciiDoc and xmlto toolchains should be
also mentioned here.  Well, that and the fact that there exist
pre-build documentation in html and man forms.


2. Command Set

   What is the command set? How compatible it is with
   the commands of CVS (the current open-source defacto
   standard)?

Should it be: "Tries to follow CVS conventions, but deviates where
there is a different design.", as for Mercurial and Monotone?
If I remember correctly command set is patterned somewhat after
BitKeeper.

"Large command set divided into plumbing (low lewel, to be used in
 scripts) and porcelain (high level commands)."


3. Portability

   How portable is the version-control system to various 
   operating systems, computer architectures, and other
   types of systems?

"Good.  Portable across all POSIX systems.
 There exists Win32 binary using MinGW."

>From the results of Git User's Surveys there are many OS on which Git
is used; but it doesn't tell us how hard was to deply Git on those
exotic operatings systems.


4. Repository Permissions

   Is it possible to define permissions on access to different
   parts of a remote repository? Or is access open for all?

"Partial (?). It is possible to lock down repository
 (access to branches and tags) using hooks."

I don't know if it is possible to do finer level ACLs, i.e. if it
is possible to lock subdirectories or files in Git.  Although for
distributed SCMs ACL doesn't matter much: check diffstat and merge or
not from trusted people.  We have "network of trust" (BTW. Karl Fogel
in OSSBook recommends 'soft' control of access control to repository,
on social rather than on technical level).


P.S. How do "svn diff" looks like?
-- 
Jakub Narebski
Poland
