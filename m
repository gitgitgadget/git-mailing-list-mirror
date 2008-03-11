From: Filippo Zangheri <filippo.zangheri@yahoo.it>
Subject: Re: [QUESTION] Selective fetch possible?
Date: Tue, 11 Mar 2008 13:29:10 +0100
Message-ID: <47D67B16.8040709@yahoo.it>
References: <47D5AFF3.90000@yahoo.it> <20080310225302.GE8410@spearce.org> <m3d4q2ywyx.fsf@localhost.localdomain> <47D6341C.7030505@dawes.za.net> <20080311075053.GQ8410@spearce.org> <47D64BE4.9010009@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 13:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ3cJ-0004i6-TP
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 13:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbYCKM3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 08:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYCKM3T
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 08:29:19 -0400
Received: from n10.bullet.re3.yahoo.com ([68.142.237.123]:42926 "HELO
	n10.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753743AbYCKM3S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 08:29:18 -0400
Received: from [68.142.230.29] by n10.bullet.re3.yahoo.com with NNFMP; 11 Mar 2008 12:29:13 -0000
Received: from [69.147.75.182] by t2.bullet.re2.yahoo.com with NNFMP; 11 Mar 2008 12:29:13 -0000
Received: from [127.0.0.1] by omp103.mail.re1.yahoo.com with NNFMP; 11 Mar 2008 12:29:13 -0000
X-Yahoo-Newman-Id: 643837.44477.bm@omp103.mail.re1.yahoo.com
Received: (qmail 14455 invoked from network); 11 Mar 2008 12:29:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:OpenPGP:Content-Type:Content-Transfer-Encoding;
  b=lRgYvwcxqM+R96vgcFt3byQ57iUygd+u3SfDDIljJvIZwuOVw8Qlg6Q8V5gOUcecf1yHOuejmGtfX1gsHV897vPv2U6Jjhz2QNCO7BCm6hvGv/3dpFAAPLF9iyKrlwI7K9KbojYTA0HbWnenn44WR4+cUftSFbutvhDplRYVbAg=  ;
Received: from unknown (HELO ?82.53.180.68?) (filippo.zangheri@82.53.180.68 with plain)
  by smtp116.plus.mail.re1.yahoo.com with SMTP; 11 Mar 2008 12:29:13 -0000
X-YMail-OSG: LQUlBc8VM1mvlTa3_N3S8N.Hs2qXZY3.FVreJh7oOUdXSNtBnd8LyVWmR69sQ3TOO35283mq81mzEcuQGK3ix6.aJk5bp1._KHMtwqQoyIx9Wapqq4wNl8cvPTmvzw--
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <47D64BE4.9010009@dawes.za.net>
X-Enigmail-Version: 0.95.6
OpenPGP: id=E1D879FA;
	url=http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE1D879FA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76831>

Rogan Dawes ha scritto:
(...)
> I think that one should not *expect* to be able to complete merges with 
> only a partial checkout, though. It *may* work in cases where there are 
> no conflicts, but I think it would be a perfectly valid error path to 
> fail if there is a conflicting merge in a part of the tree that has not 
> been checked out.
> 
> So, for a user working on partial trees, they would be able to modify 
> their partial tree, and check in their changes, but merges would have to 
> be done by someone with a complete checkout. For the given examples 
> where partial trees make sense (documentation workers), this seems like 
> a reasonable compromise.

I think this is what every reasonable developer should have in mind
when he's working on just a project subset :). And I also think,
this is not a valid reason for forbidding/not implementing such a
partial (or subtree) checkout.


-- 
Filippo Zangheri

GPG key ID: 0xE1D879FA
Key fingerprint: 816B CE57 D43C 0A47 EF35 3378 EA5F A72A E1D8 79FA
Key server: pgp.mit.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GE d- s+:- a-- C++ UL+++ P+ L+++ E-- W+ N* o-- K- w--- O-- M--
V- PS++ PE+ Y+ PGP++ t 5-- X++ R* tv b+ DI-- D---- G-- e++ h--
r++ z*
------END GEEK CODE BLOCK------
