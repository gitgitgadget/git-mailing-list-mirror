From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Fri, 16 Nov 2007 06:25:09 +0200
Message-ID: <8B2E66EB-22C7-4C08-9947-C0D6A755309F@pp.inet.fi>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com>
 <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com>
 <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 05:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Issm4-0004lF-6a
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 05:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757661AbXKPEZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 23:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756302AbXKPEZb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 23:25:31 -0500
Received: from hyat.suomi.net ([82.128.152.22]:60738 "EHLO hyat.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756120AbXKPEZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 23:25:29 -0500
Received: from taku.suomi.net ([82.128.154.66])
 by hyatt.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JRL00A50084JS20@hyatt.suomi.net> for
 git@vger.kernel.org; Fri, 16 Nov 2007 06:24:04 +0200 (EET)
Received: from spam3.suomi.net (spam3.suomi.net [212.50.131.167])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRL00JTD0AFIF30@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 16 Nov 2007 06:25:27 +0200 (EET)
Received: from Kaalimaa.fudeco.com
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam3.suomi.net (Postfix) with ESMTP id 1807A164EFA; Fri,
 16 Nov 2007 06:25:09 +0200 (EET)
In-reply-to: <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com>
X-Mailer: Apple Mail (2.912)
X-DNA-MailScanner-Information: Please contact the ISP for more information
X-DNA-MailScanner: Found to be clean
X-DNA-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-0.76,
	required 5, AWL 0.14, BAYES_00 -1.00, RDNS_DYNAMIC 0.10)
X-DNA-MailScanner-From: v@pp.inet.fi
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65187>


On Nov 15, 2007, at 18:11, Wincent Colaiuta wrote:

> El 15/11/2007, a las 17:04, Brian Gernhardt escribi=F3:
>
>> On Nov 15, 2007, at 8:46 AM, Wincent Colaiuta wrote:
>>
>>> Was just running the test suite against the master branch and saw =20
>>> that t9101 is currently failing on Leopard, and a review with git-=20
>>> bisect indicates that it has been ever since it was first =20
>>> introduced (in commit 15153451). Not sure if this problem is =20
>>> Leopard-specific or not as I only have one machine.
>>
>> It is not a Leopard specific problem, as far as I can tell.  I just =
=20
>> ran the test and had no errors on my Leopard machine.  So perhaps =20
>> it's some other detail of your setup?
>>
>>> I'm not a git-svn user myself, but if there's anything I can do to =
=20
>>> help diagnose this problem further on Leopard please let me know.
>>
>> I just tested it using svn from fink and (after discovering it =20
>> exists) from Leopard.  No problems.  Do you have an old svn package =
=20
>> (client, admin, or perl binding) installed from Darwin Ports or =20
>> Fink perhaps?
>
> I don't use Darwin Ports or Fink, and this is a clean Leopard =20
> install (ie. nothing installed in /usr/local apart from git and a =20
> very small number of other tools that aren't related to Subversion).
>
> This is the output of "/usr/bin/svn --version":
>
> svn, version 1.4.4 (r25188)
>   compiled Sep 23 2007, 22:32:34
>
> Perhaps then it is something in the environment.

I cannot reproduce this on Leopard (not yet updated to 10.5.1). I =20
tested this with self-compiled GIT from commit id ca2b71c

svn version is the same as yours, I do use Fink, and I have used Fink =20
to install Perl SVN bindings.

--
V=E4in=F6