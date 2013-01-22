From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [msysGit] Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Tue, 22 Jan 2013 18:38:49 +0000
Message-ID: <50FEDCB9.6090708@ramsay1.demon.co.uk>
References: <50E9F7C2.1000603@gmail.com> <FBDECCA565D94DF9838DD81FE2E2543A@black> <7v1udxladc.fsf@alter.siamese.dyndns.org> <50EB8EB5.6080204@gmail.com> <CALxABCYHRp17rcoOca1xWG9S19fq2rotz8FEKo09jNdrgMLiyQ@mail.gmail.com> <CALxABCavvW77djKQnbQsjCBcahmMfrP24SDz609NG-94_ifZ9Q@mail.gmail.com> <50F303D8.20709@gmail.com> <50F5A435.5090408@ramsay1.demon.co.uk> <20130120101007.GD16339@elie.Belkin> <50FBCB95.6020201@web.de> <20130120110618.GF16339@elie.Belkin> <50FCD017.6060607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Stephen & Linda Smith <ischis2@cox.net>,
	Eric Blake <eblake@redhat.com>,
	msysGit <msysgit@googlegroups.com>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 22 19:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxinE-00009r-Ir
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 19:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab3AVSlc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2013 13:41:32 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:47200 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab3AVSlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 13:41:31 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id DDE41A0C087;
	Tue, 22 Jan 2013 18:41:30 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 21290A0C081;	Tue, 22 Jan 2013 18:41:30 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Tue, 22 Jan 2013 18:41:27 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <50FCD017.6060607@web.de>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214245>

Torsten B=F6gershausen wrote:
> On 20.01.13 12:06, Jonathan Nieder wrote:
>> Torsten B=F6gershausen wrote:
>>
>>> I wonder, if if we can go one step further:
>>>
>>> Replace
>>> #ifdef WIN32 /* Both MinGW and MSVC */
>> [...]
>>> with
>>> #if defined(_MSC_VER)
>>
>> I thought Git for Windows was built using mingw, which doesn't defin=
e
>> _MSC_VER?
>>
>> Puzzled,
>> Jonathan
>>
> Yes,
> After removing these lines in the git-compat-util.h of msysgit
> v1.8.1 it still compiled.
> So I start to speculate if the comment is still valid for mingw,
> or if that was true in the old days and not now any more.
>=20
> More investigation is needed, sorry for confusion.

Yes, I compiled the last patch on MinGW before I sent it to the list.
I didn't bother with MSVC, since that build is already broken.
I have a patch which fixed the MSVC build, but it already needs to
be updated, since current master fails to build on MSVC.

ATB,
Ramsay Jones
