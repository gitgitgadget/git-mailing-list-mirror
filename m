From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 20:16:31 -0400
Message-ID: <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
	 <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
	 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
	 <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
	 <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>
	 <alpine.LFD.2.00.1003181953010.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 01:16:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsPtG-0005kn-SS
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 01:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab0CSAQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 20:16:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56733 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab0CSAQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 20:16:33 -0400
Received: by gyg8 with SMTP id 8so1297743gyg.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hHpMa0oZ2yUx8lwSHSRqcSJYLuGRD1G46WzYRlql6Uc=;
        b=QNyrJrXm/TXb+3iPV8aTjMzNfgMvyiEgS/1vIYb8pt/SSqwQAf/uAt+SRLHa9VjC+G
         /Knn5WVywlc4ajgnyKwzRuCd/TyKJfMrPNdE0ZallUTUxDFh0YgxwVPBj0L6UfYBAI97
         WmV1tP149GyaXUvXdOJA9axjkhR8vqBwCCgzc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FuGTgBT+r0Iej9jmUIuXrc+EClHEbST07Bi5uogOeAYwOx+ZstuDsE3/YMglPFgdIl
         Q1+OQ/IWoU2ya2dkYLHQj1E2fM+kJAFkWpImH6aPvIZckVEWPRv+sE0dkV1HIjENQ4a/
         c69WxXYCp18DODO3Zq7fvtWMABqfv5f5WVGOw=
Received: by 10.101.39.1 with SMTP id r1mr5467391anj.101.1268957792038; Thu, 
	18 Mar 2010 17:16:32 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181953010.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142544>

On Thu, Mar 18, 2010 at 7:58 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 18 Mar 2010, Jon Smirl wrote:
>
>> On Thu, Mar 18, 2010 at 7:34 PM, Nicolas Pitre <nico@fluxnic.net> wr=
ote:
>> > On Thu, 18 Mar 2010, Jon Smirl wrote:
>> >
>> >> If anyone is interested I can send them a .mailmap that fixes a l=
ot of
>> >> the problems in the kernel tree. It's two years old so it will ne=
ed
>> >> updating.
>> >
>> > Please just make a patch with it, and post it to lkml and CC Linus=
 and
>> > Andrew Morton. =A0Repost a month later if no one picked it up.
>>
>> Been there, done that. 1000 message flame war ensued about privacy
>> concerns over people's email address in the file.
>
> Well, you used git itself as the data source to fix up those email
> addresses, right? =A0If so there is simply no privacy concerns as the=
 data
> is already there and public. =A0Just don't venture adding emails that=
 are
> not already present in the whole Git history/content at all without
> consent.

I'll sent you the file and you can commit it. Please take full credit f=
or it.
http://lkml.org/lkml/2008/7/28/134

All of the data came out of git tree.

--=20
Jon Smirl
jonsmirl@gmail.com
