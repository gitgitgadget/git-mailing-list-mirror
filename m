From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] t9101 (master) busted on Leopard
Date: Fri, 16 Nov 2007 14:14:24 +0100
Message-ID: <406D1E35-2C24-4D47-9F3E-793EAFA39B0E@wincent.com>
References: <D68F81D3-5833-460B-BC7A-98C7E1D8B3E4@wincent.com> <BB9A8E3F-DC19-4844-80E1-6AEAADF926CD@silverinsanity.com> <041C0054-5E50-483C-9779-B2FE1AE6947C@wincent.com> <1D7CC3C0-46C1-40D9-AAD5-B9ADFF99B58A@lrde.epita.fr> <73246E38-9C22-4279-A53E-678434238E5C@wincent.com> <20071116124850.GA14473@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 14:14:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It124-0006Lh-JR
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 14:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297AbXKPNOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 08:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752106AbXKPNOe
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 08:14:34 -0500
Received: from wincent.com ([72.3.236.74]:41897 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752411AbXKPNOd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 08:14:33 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAGDEPdR019871;
	Fri, 16 Nov 2007 07:14:27 -0600
In-Reply-To: <20071116124850.GA14473@atjola.homenet>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65223>

El 16/11/2007, a las 13:48, Bj=F6rn Steinbrink escribi=F3:
> On 2007.11.16 12:00:02 +0100, Wincent Colaiuta wrote:
>> That last commit is a no-op because, for some reason, the svn propse=
t
>> before it is also a no-op:
>>
>> svn propset svn:keywords Id kw.c
>
> It _is_ a no-op. At least here. Because I got an auto-props setting i=
n
> my ~/.subversion/config to automatically add Id for *.c files. So tha=
t
> property was already there before we explicitly ask for it and the
> propset turns into a no-op. If I remove that line from the subversion
> configuration, the test succeeds. Same for you I guess.
>
> That said, I had a quick glance over the subversion CLI help, but it
> didn't tell me how to ignore/override ~/.subversion/config. Anyone =20
> less
> clueless than me around, having a smart idea how to work around that
> "bug"?

Ah, excellent catch, Bj=F6rn. That's it. The --no-auto-props switch wil=
l =20
fix this then; will post a patch to the list in a few minutes.

Cheers,
Wincent
