From: Sergei Organov <osv@javad.com>
Subject: Re: Where man git-format-patch sends me?
Date: Fri, 02 Nov 2007 14:25:52 +0300
Message-ID: <87odec28jj.fsf@osv.gnss.ru>
References: <87lk9i2hkc.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711011437440.4362@racer.site>
	<877il22cip.fsf@osv.gnss.ru>
	<2A9EA819-C27A-4538-A9ED-B5281D137B94@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 12:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InufO-00021T-Bk
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 12:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbXKBL0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 07:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbXKBL0H
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 07:26:07 -0400
Received: from javad.com ([216.122.176.236]:3422 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbXKBL0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 07:26:06 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA2BPxm86907;
	Fri, 2 Nov 2007 11:26:00 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Inueu-0006Nn-Oc; Fri, 02 Nov 2007 14:25:52 +0300
In-Reply-To: <2A9EA819-C27A-4538-A9ED-B5281D137B94@wincent.com> (Wincent Colaiuta's message of "Fri\, 2 Nov 2007 11\:03\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63105>

Wincent Colaiuta <win@wincent.com> writes:

> El 1/11/2007, a las 16:47, Sergei Organov escribi=C3=B3:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> Hi,
>>>
>>> On Thu, 1 Nov 2007, Sergei Organov wrote:
>>>
>>>> $ man git-format-patch
>>>> [...]
>>>> OPTIONS
>>>>       -p     Generate patch (see section on generating patches)
>>>>
>>>>       -u     Synonym for "-p".
>>>
>>> As you can easily see from Documentation/git-format-patch.txt, this=
 =20
>>> part
>>> is generated from the file Documentation/diff-options.txt.
>>
>> Sorry, I did saw that, but it doesn't change anything.
>>
>> 1. As a user reading man git-format-patch, where do I find this =20
>> "section
>>   on generating patches"? In another man-page? In the html
>>   documentation? On the moon?
>>
>> 2. I can't find "section on generating patches" in the man git-diff
>>   either, and I did say this in the part of my original message you'=
ve
>>   snipped.
>>
>> So the main question remains: could you please point me to the exact
>> place in 'Documentation/' directory where this "section on generatin=
g
>> patches" resides?
>
> I believe the section in question is in Documentation/diff-format.txt

Ah, thank you! Now, diff-format.txt is included by
git-diff-index/git-diff-files/git-diff-tree, but not by git-diff and
git-format-patch. Do you think it is the right thing for the latter two
to include diff-format as well?

--=20
Sergei.
