From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [BUG] t9101 (master) busted on Leopard
Date: Thu, 15 Nov 2007 23:22:07 +0100
Message-ID: <9A0785C3-1150-458C-BC84-1E13CC039D28@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Nov 15 23:22:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isn6T-0008U5-Rl
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 23:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759546AbXKOWWM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2007 17:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbXKOWWM
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 17:22:12 -0500
Received: from wincent.com ([72.3.236.74]:40570 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbXKOWWL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Nov 2007 17:22:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAFMLPZn000960;
	Thu, 15 Nov 2007 16:22:08 -0600
In-Reply-To: <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65175>

El 15/11/2007, a las 22:13, Benoit Sigoure escribi=F3:

> On Nov 15, 2007, at 5:11 PM, Wincent Colaiuta wrote:
>
>> El 15/11/2007, a las 17:04, Brian Gernhardt escribi=F3:
>>
>>> On Nov 15, 2007, at 8:46 AM, Wincent Colaiuta wrote:
>>>
>>>> Was just running the test suite against the master branch and saw =
=20
>>>> that t9101 is currently failing on Leopard, and a review with git-=
=20
>>>> bisect indicates that it has been ever since it was first =20
>>>> introduced (in commit 15153451). Not sure if this problem is =20
>>>> Leopard-specific or not as I only have one machine.
>>>
>>> It is not a Leopard specific problem, as far as I can tell.  I =20
>>> just ran the test and had no errors on my Leopard machine.  So =20
>>> perhaps it's some other detail of your setup?
>>>
>>>> I'm not a git-svn user myself, but if there's anything I can do =20
>>>> to help diagnose this problem further on Leopard please let me =20
>>>> know.
>>>
>>> I just tested it using svn from fink and (after discovering it =20
>>> exists) from Leopard.  No problems.  Do you have an old svn =20
>>> package (client, admin, or perl binding) installed from Darwin =20
>>> Ports or Fink perhaps?
>>
>> I don't use Darwin Ports or Fink, and this is a clean Leopard =20
>> install (ie. nothing installed in /usr/local apart from git and a =20
>> very small number of other tools that aren't related to Subversion).
>>
>> This is the output of "/usr/bin/svn --version":
>>
>> svn, version 1.4.4 (r25188)
>>   compiled Sep 23 2007, 22:32:34
>>
>> Perhaps then it is something in the environment.
>
> Hi Wincent,
> Can you reproduce this deterministically?  If yes, can you re-run =20
> the test with the --verbose flag and post the gzipped output (or =20
> send it to me if the list doesn't like this sort of attachment).

Yes, have just sent you the output of "--verbose" and also running the =
=20
script using "sh -x" (off list).

Cheers,
Wincent
