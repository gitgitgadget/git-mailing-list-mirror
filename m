From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 19:41:02 -0400
Message-ID: <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
	 <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
	 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
	 <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:41:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsPKx-0001VT-Sd
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab0CRXlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 19:41:06 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:61915 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0CRXlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 19:41:05 -0400
Received: by qyk12 with SMTP id 12so628999qyk.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 16:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DMTB/ZvYzRikYJBX0L9r4uMLdxPkk7WOWrd6taRUFVg=;
        b=ItMrLq2igRJWDsDydjFjglDwlH4nCzCqGmceJ2vxScva7qUiE0rkZzF8xt1mFEW9oe
         NUFgSioG4M9faoebDewzuus3fsv1ArmSy2cvVg2KAe9jeUE72jIVy8MWVyJ6mG9OF5gX
         /2RcpHDL6RzkTfqVT8q6FQvD3g4dPQnBS7ho8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jVoWglKJMvrZgsAfMyx6EByDNIL+riTj0RblOEYy1QnkR9up3qVNjfOCJOMNYTW3Kl
         qf3K6u/5F7Bj67OAJMrsxYWM6r3EZ/Lwt5T0HYqDquRXvQa8FzZJ1sgjAUwAV2BY0MSA
         YntgreawxwcfgQheU9xJAtkWVLD4l8pJn+T0g=
Received: by 10.224.78.15 with SMTP id i15mr998069qak.38.1268955662770; Thu, 
	18 Mar 2010 16:41:02 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142539>

On Thu, Mar 18, 2010 at 7:34 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 18 Mar 2010, Jon Smirl wrote:
>
>> If anyone is interested I can send them a .mailmap that fixes a lot =
of
>> the problems in the kernel tree. It's two years old so it will need
>> updating.
>
> Please just make a patch with it, and post it to lkml and CC Linus an=
d
> Andrew Morton. =A0Repost a month later if no one picked it up.

Been there, done that. 1000 message flame war ensued about privacy
concerns over people's email address in the file.

>
> I think that 'git log' should really consider the .mailmap by default=
=2E
> Otherwise what's the point? =A0 The only time when .mailmap should no=
t be
> considered is when using --pretty=3Draw or when explicitly told not t=
o.
>
>
> Nicolas
>



--=20
Jon Smirl
jonsmirl@gmail.com
