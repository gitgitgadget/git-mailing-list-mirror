From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Fixing path quoting issues
Date: Fri, 12 Oct 2007 14:20:36 +0200
Message-ID: <A7970E82-92E0-4267-AF79-D4ABDB21F0D0@wincent.com>
References: <11920508172434-git-send-email-jon.delStrother@bestbefore.tv> <470DC05A.8020209@viscovery.net> <854pgytafi.fsf@lola.goethe.zz> <470DCC76.7070809@viscovery.net> <81156EED-7AC0-4C8B-98B1-8338262459A6@bestbefore.tv> <470DD3B8.1080809@viscovery.net> <85k5pts796.fsf@lola.goethe.zz> <E43846E3-4F42-4B3A-BA5F-1A21FE70C3FB@wincent.com> <Pine.LNX.4.64.0710121235230.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 12 14:21:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgJW5-0006zD-RV
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 14:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbXJLMVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2007 08:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbXJLMVJ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 08:21:09 -0400
Received: from wincent.com ([72.3.236.74]:44161 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbXJLMVI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2007 08:21:08 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9CCKxYu019108;
	Fri, 12 Oct 2007 07:21:00 -0500
In-Reply-To: <Pine.LNX.4.64.0710121235230.25221@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60684>

El 12/10/2007, a las 13:37, Johannes Schindelin escribi=F3:

> On Fri, 12 Oct 2007, Wincent Colaiuta wrote:
>
>> El 11/10/2007, a las 22:53, David Kastrup escribi=F3:
>>
>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>
>>>> Jonathan del Strother schrieb:
>>>>> How are you going to test that git works on paths with spaces =20
>>>>> if the
>>>>> test suite doesn't run there?
>>>>
>>>> By writing a specific test?
>>>
>>> This is going to be much less thorough.  And it does no harm if the
>>> test scripts demonstrate defensive programming.
>>
>> +1: especially in this case, where it really is "defensive" and not
>> "paranoiac".
>
> I am all for it, _iff_ the guilty parties (and by that, I mean =20
> _you_) do
> it and keep maintaining it.  See?  Discussion closed already.

How am *I* the guilty party? I'm merely endorsing David's comment =20
that a modicum of defensive programming isn't a bad thing; an =20
eminently reasonable position which is somewhat difficult to argue =20
against.

Cheers,
Wincent
