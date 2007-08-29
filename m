From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git: cannot rename foo to Foo on a case-insensitive filesystem (e.g. on Windows)
Date: Wed, 29 Aug 2007 11:31:10 +0200
Message-ID: <1BA15C6C-1F37-401B-B8D8-4BD147CF5225@wincent.com>
References: <3f4fd2640708280117k3f1cd03el676a87084a83480f@mail.gmail.com> <46D3ED4E.6030606@op5.se> <82tzqjgbx0.fsf@mid.bfk.de> <5A2EFA05-7A86-440B-B027-6360DA04CD89@wincent.com> <46D42C07.50001@op5.se> <54CFD615-6E05-42AC-A0D7-063B146295B8@wincent.com> <Pine.LNX.4.64.0708282144250.28586@racer.site> <301B4A5B-1765-426E-B72C-F6248894A3E0@wincent.com> <Pine.LNX.4.64.0708290321530.28586@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Florian Weimer <fweimer@bfk.de>,
	Reece Dunn <msclrhd@googlemail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 29 11:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJtw-0005wV-Q4
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbXH2Jbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 05:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498AbXH2Jbt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:31:49 -0400
Received: from wincent.com ([72.3.236.74]:50218 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbXH2Jbs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2007 05:31:48 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l7T9VcrU030363;
	Wed, 29 Aug 2007 04:31:39 -0500
In-Reply-To: <Pine.LNX.4.64.0708290321530.28586@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56916>

El 29/8/2007, a las 4:23, Johannes Schindelin escribi=F3:

> On Wed, 29 Aug 2007, Wincent Colaiuta wrote:
>
>> El 28/8/2007, a las 22:45, Johannes Schindelin escribi?:
>>
>>> On Tue, 28 Aug 2007, Wincent Colaiuta wrote:
>>>
>>>> Personally, I don't like HFS+ much at all, but your statement that
>>>> Mac OS X "doesn't even have a case sensitive filesystem" is false.
>>>
>>> It is right that they support it.  But since the _default_ is case
>>> insensitive (but only as long as it is not _reporting_ file =20
>>> names), it
>>> is _as bad_ as "doesn't even have a case sensitive filesystem".  No
>>> sophistry helps here.
>>
>> I don't think my correction qualifies as "sophistry" by any =20
>> reasonable
>> definition of the word. Andreas claimed that Apple had turned "a
>> perfectly decent unix-clone such as FreeBSD into some defect =20
>> monstrosity
>> that doesn't even have a case sensitive filesystem"; I merely =20
>> sought to
>> correct his misstatement.
>
> I acknowledged that.
>
> But it does not change the _meaning_ of Andreas' criticism.  They =20
> took a
> perfectly sane system, and turned it into a mess.

I don't think it's productive to enter into arguments about whether a =20
particular operating system is a "monstrosity", "sane" or "a mess"; =20
that's why I limited my comment to a correction of a factual =20
misstatement by Andreas and left the opinion part unchallenged. We =20
could have avoided this thread if instead of "doesn't even have a =20
case sensitive filesystem", he'd started his flame with "defaults to =20
a using a case-insensitive filesystem".

> Yes, you _can_ change the setting.  No, most don't.  Yes, the =20
> effect is...
> you guessed it: the same as if they did not allow case sensitivity =20
> at all.

While I agree that most just accept the default, your argument here =20
and in your previous email is spurious; it amounts to saying "A and B =20
is offered, but because A is the default it is the same as if B were =20
not supported at all", which isn't valid logic. If you limited your =20
argument to criticizing case-insensitive filesystems then I would =20
have to agree with you; I am not a fan of them. Likewise, if you said =20
that the default has undesirable consequences I would also concur. =20
It's your attempt to extend your claim to an argument for equivalence =20
that I can't buy.

> Plenty of people have this setup

Agreed...

> and we have to suffer.

but, don't you think you're exaggerating a bit here? How much =20
"suffering" has this really caused you? I gather that you're not even =20
a user of that operating system; I am (have been since the first =20
developer previews), have always accepted the default filesystem =20
choice, don't even like the filesystem (have ranted repeatedly about =20
its flakiness on my weblog), but I think I've run into case-=20
insensitivity issues two times. If you want to talk about "suffering" =20
then ask me about HFS+ data integrity.

Cheers,
Wincent
