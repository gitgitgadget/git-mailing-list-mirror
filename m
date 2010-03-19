From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 20:39:00 -0400
Message-ID: <9e4733911003181739m2f605dd7g9406aaecc296749f@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
	 <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
	 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
	 <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
	 <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>
	 <alpine.LFD.2.00.1003181953010.31128@xanadu.home>
	 <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>
	 <alpine.LFD.2.00.1003181715490.18017@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 02:08:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsQhc-00061S-FZ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 02:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab0CSBIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 21:08:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50062 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0CSBId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 21:08:33 -0400
Received: by gwaa12 with SMTP id a12so1164802gwa.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 18:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nLFse/WVuVepkfIT4BX+HYi8vsGzdl+sdHa0eQXqv0c=;
        b=LUkbOrFvJoM8SAV60GPqmR42lQtnr+me4Kg7KcmJZdRQ/2X4CjvNkKHxsjfPIh0IxL
         bi5Dt9LmCSdZ5xit6vguyZB+nEl+kpijQs9JbgdzpcMarl9RqP0PpcBI4wO9B/9/BEPg
         9+oTAqTDzk5G/K77yO6loQ4r2Ot5G0wrW241w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hFszZ8z1d5o01NoyKGFqBcXEqHAdhn+iGLo3nbeLCwWj1gQWEzmJHwyNlS3UNrw5iT
         iLepkew2OOl8sftYhRLaTUEGIR0/LTfK8aFo1HWcJNejiJsfSfdop97PMh/d1E9WKQzM
         5tlxTHMkr7nOO+xwiXLJdC657RkDu+pg5om4c=
Received: by 10.101.133.35 with SMTP id k35mr5547800ann.50.1268959140974; Thu, 
	18 Mar 2010 17:39:00 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181715490.18017@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142550>

On Thu, Mar 18, 2010 at 8:17 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 18 Mar 2010, Jon Smirl wrote:
>>
>> I'll sent you the file and you can commit it. Please take full credi=
t for it.
>
> Umm. You do realize that what people complained about was mostly that=
 they
> felt a lot of the entries were totally pointless.
>
> For example, you included names whether they were mistyped or not, an=
d
> claimed that everybody needed to always be in the mailmap if they eve=
r
> made any commit.
>
> So I think 99% of the flames were due to just the patch being stupid.

I had all of the names in the list so that I could regenerate the list
and diff it against the old version to know which new names needed to
be checked. Looking back I could have eliminated the names without
errors and then added a comment to the file as to the last date all of
the names were checked.  But that is less reliable than recording
which were checked. The problem is that if you lose track of what has
been checked, you are forced to recheck everything and it takes a long
time to recheck everything.

I'll send you a copy and you can unstupify it.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>



--=20
Jon Smirl
jonsmirl@gmail.com
