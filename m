From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Where man git-format-patch sends me?
Date: Fri, 2 Nov 2007 11:03:46 +0100
Message-ID: <2A9EA819-C27A-4538-A9ED-B5281D137B94@wincent.com>
References: <87lk9i2hkc.fsf@osv.gnss.ru> <Pine.LNX.4.64.0711011437440.4362@racer.site> <877il22cip.fsf@osv.gnss.ru>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntNw-0000rj-OJ
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbXKBKD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 06:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXKBKD4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:03:56 -0400
Received: from wincent.com ([72.3.236.74]:36951 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbXKBKDz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2007 06:03:55 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA2A3ljc027291;
	Fri, 2 Nov 2007 05:03:48 -0500
In-Reply-To: <877il22cip.fsf@osv.gnss.ru>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63091>

El 1/11/2007, a las 16:47, Sergei Organov escribi=F3:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Hi,
>>
>> On Thu, 1 Nov 2007, Sergei Organov wrote:
>>
>>> $ man git-format-patch
>>> [...]
>>> OPTIONS
>>>       -p     Generate patch (see section on generating patches)
>>>
>>>       -u     Synonym for "-p".
>>
>> As you can easily see from Documentation/git-format-patch.txt, this =
=20
>> part
>> is generated from the file Documentation/diff-options.txt.
>
> Sorry, I did saw that, but it doesn't change anything.
>
> 1. As a user reading man git-format-patch, where do I find this =20
> "section
>   on generating patches"? In another man-page? In the html
>   documentation? On the moon?
>
> 2. I can't find "section on generating patches" in the man git-diff
>   either, and I did say this in the part of my original message you'v=
e
>   snipped.
>
> So the main question remains: could you please point me to the exact
> place in 'Documentation/' directory where this "section on generating
> patches" resides?

I believe the section in question is in Documentation/diff-format.txt

But you've basically found a documentation bug. Someone invoking "man =20
git-format-patch" shouldn't be expected to have to grep the source =20
tree in order to find out where the referenced documentation is. =20
Especially given that he/she may not even have the source.

Cheers,
Wincent
