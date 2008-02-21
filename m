From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: problem with git-browser
Date: Thu, 21 Feb 2008 09:52:38 -0500
Message-ID: <51DDC697-9567-44AC-92D9-FD3E82C4279E@yahoo.ca>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 15:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSCsu-0007tb-Oq
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 15:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbYBUO6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 09:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753792AbYBUO6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 09:58:16 -0500
Received: from n14.bullet.mail.mud.yahoo.com ([68.142.201.237]:31405 "HELO
	n14.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753692AbYBUO6P convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 09:58:15 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2008 09:58:15 EST
Received: from [209.191.108.96] by n14.bullet.mail.mud.yahoo.com with NNFMP; 21 Feb 2008 14:52:47 -0000
Received: from [68.142.201.68] by t3.bullet.mud.yahoo.com with NNFMP; 21 Feb 2008 14:52:47 -0000
Received: from [127.0.0.1] by omp420.mail.mud.yahoo.com with NNFMP; 21 Feb 2008 14:52:47 -0000
X-Yahoo-Newman-Id: 915845.83031.bm@omp420.mail.mud.yahoo.com
Received: (qmail 34901 invoked from network); 21 Feb 2008 14:52:45 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Mime-Version:Content-Transfer-Encoding:Message-Id:Content-Type:To:From:Subject:Date:X-Mailer;
  b=MG2tjbJp1SlvlyX3CPDy7J+1t30aF7f0wEChFmuTBp752r72m2EMcV4jU2PG+fRY6lP9UJnTMYS+Md00LiUz5Qa3ZKNZ3SKp4WmeiS9XHLPp2DrrR02C725wQ0QqoudaM8VJPxJZCc1CqD7XYMI6W5BkWgZtIvP+QJq8TEk0qE0=  ;
Received: from unknown (HELO ?10.0.1.3?) (jean_francois_veillette@66.130.96.245 with plain)
  by smtp101.mail.mud.yahoo.com with SMTP; 21 Feb 2008 14:52:45 -0000
X-YMail-OSG: fqtgI8gVM1kCELT89XWkbKKZCC_cjhmjuoNNYZ4BGtaggwybhybvNJFYuudbLRwfGQZfRZjcBwpV5qJCh5v2oib3uI1aAZU.mRLYApc18MjA8gBX0F077WZEo5CQPr6tO_sqOWXaztSjJ0upN6TBmUjPSNc-
X-Yahoo-Newman-Property: ymail-3
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74621>


I've installed gitweb with the git-browser extension.  But when I try =20
to access the =AB graphic log =BB, it doesn't show up.
I get: =AB closeError: invisible_get: timeout requesting /cgi-bin/git-=20
browser.pl?sub=3Dcommits_from_refs&repo=3DcvsConvertedRepo.git&ref=3Dr%=
=20
2Call&shortcomment=3D1 =BB

I tried to debug (Firebugs), and surprisingly, this call (above) does =20
return a content (and does look valid).

I've put breakpoint in the javascript code, but can't get to fix it.
Is it a known bug ?  Is there a workaround ?

Some more info :
: uname -a
	Darwin xxx.local 8.11.0 Darwin Kernel Version 8.11.0: Wed Oct 10 =20
18:26:00 PDT 2007; root:xnu-792.24.17~1/RELEASE_PPC Power Macintosh =20
powerpc

: perl -v
	This is perl, v5.8.6 built for darwin-thread-multi-2level
	(with 4 registered patches, see perl -V for more detail)

: httpd -v
Server version: Apache/1.3.33 (Darwin)
Server built:   Mar 20 2005 15:08:27

- jfv
