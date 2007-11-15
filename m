From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Thu, 15 Nov 2007 17:11:41 +0100
Message-ID: <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IshK7-000774-BA
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbXKOQLq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 11:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758207AbXKOQLq
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:11:46 -0500
Received: from wincent.com ([72.3.236.74]:39903 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755756AbXKOQLp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 11:11:45 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAFGBgCA023849;
	Thu, 15 Nov 2007 10:11:43 -0600
In-Reply-To: <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65132>

El 15/11/2007, a las 17:04, Brian Gernhardt escribi=F3:

> On Nov 15, 2007, at 8:46 AM, Wincent Colaiuta wrote:
>
>> Was just running the test suite against the master branch and saw =20
>> that t9101 is currently failing on Leopard, and a review with git-=20
>> bisect indicates that it has been ever since it was first =20
>> introduced (in commit 15153451). Not sure if this problem is =20
>> Leopard-specific or not as I only have one machine.
>
> It is not a Leopard specific problem, as far as I can tell.  I just =20
> ran the test and had no errors on my Leopard machine.  So perhaps =20
> it's some other detail of your setup?
>
>> I'm not a git-svn user myself, but if there's anything I can do to =20
>> help diagnose this problem further on Leopard please let me know.
>
> I just tested it using svn from fink and (after discovering it =20
> exists) from Leopard.  No problems.  Do you have an old svn package =20
> (client, admin, or perl binding) installed from Darwin Ports or Fink =
=20
> perhaps?

I don't use Darwin Ports or Fink, and this is a clean Leopard install =20
(ie. nothing installed in /usr/local apart from git and a very small =20
number of other tools that aren't related to Subversion).

This is the output of "/usr/bin/svn --version":

svn, version 1.4.4 (r25188)
    compiled Sep 23 2007, 22:32:34

Perhaps then it is something in the environment.

Cheers,
Wincent
