From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Sun, 11 Nov 2012 18:49:49 +0100
Message-ID: <CAMP44s2ec-m0Jta2bQeg2McKAFCR6MSSP4nQx3-T=2W=3xUeyw@mail.gmail.com>
References: <5093DC0C.5000603@drmicha.warpmail.net>
	<20121108200919.GP15560@sigill.intra.peff.net>
	<509CCCBC.8010102@drmicha.warpmail.net>
	<CAMP44s3Lhxzcj93=e8TXwqAVvGJBKhZEVX33G8Q=n2+8+UfCww@mail.gmail.com>
	<509E8EB2.7040509@drmicha.warpmail.net>
	<CAMP44s219Zi2NPt2vA+6Od_sVstFK85OXZK-9K1OCFpVh220+A@mail.gmail.com>
	<509EAA45.8020005@gmail.com>
	<CAMP44s1dsEU=E8tdgMYxWFyFw+F03bstdb5o7Ww_-RCQPd3R0w@mail.gmail.com>
	<509FD9BC.7050204@gmail.com>
	<CAMP44s1pWm_n-SwB5Bi8UxM-oRG=4dGXq7jVKx_E1rcoRaXaHw@mail.gmail.com>
	<509FE2EA.3020407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:50:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbfX-0000x6-UW
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab2KKRtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:49:50 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45139 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab2KKRtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:49:50 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5547284obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=21hredvZdewcSlUoG0jn9mj/GKekxjbiuCUA+l7IFP8=;
        b=R+m3jwvzwImdeDV184pOhuieWXZQEsh97eKBiurI5ZW3obhFD/1kURX45q8ZeGs3bZ
         VSlilJHnZPXb/zvcTAEAGsCZkeYc7ewvT1glLVzREed2vmIPJh2kmeE8KAL2RnD6Mx7N
         vm+EvqfCU1EUxrpzaEECAiWWNj4CI4Gj5ieRY9CBay8867VQti/9ilykJmhMvfiZ0lbs
         1/FobdZQsZHB+V7ZTxXzgzmqmd3izT+y96GOwdY4Bnc8dt3T/ZUsxwW8mPKRjmzUBSQO
         vEpJl6bQYTgXZWLDDDhZy6B5zcZitilN0qsNj+pdIgqtai9qAGYcu6wVgzWIbk/g6Nrz
         EqgQ==
Received: by 10.182.116.6 with SMTP id js6mr13248153obb.82.1352656189524; Sun,
 11 Nov 2012 09:49:49 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 09:49:49 -0800 (PST)
In-Reply-To: <509FE2EA.3020407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209428>

On Sun, Nov 11, 2012 at 6:39 PM, A Large Angry SCM <gitzilla@gmail.com> wrote:
> On 11/11/2012 12:16 PM, Felipe Contreras wrote:

>> And how do you propose to find the commit commands without parsing all
>> the other commands? If you randomly look for lines that begin with
>> 'commit /refs' you might end up in the middle of a commit message or
>> the contents of a file.
>
> I didn't say you didn't have to parse the protocol. I said that the protocol
> is pretty simple.

Parsing is never simple.

>>> I agree that an additional filter _may_ decrease performance somewhat if
>>> you
>>> are already CPU constrained. But I suspect that the effect would be
>>> negligible compared to the all of the SHA-1 calculations.
>>
>> Well. If it's so easy surely you can write one quickly, and I can measure
>> it.
>
> Not my itch; You care, you do it.

It was your idea, I don't care.

If it's so simple, why don't you do it? Because it's not that simple.
And anyway it will have a performance penalty.

-- 
Felipe Contreras
