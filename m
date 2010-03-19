From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 22:05:52 -0400
Message-ID: <9e4733911003181905i25e908f9u472d0467f68d3b00@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181930230.31128@xanadu.home>
	 <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>
	 <alpine.LFD.2.00.1003181953010.31128@xanadu.home>
	 <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>
	 <alpine.LFD.2.00.1003181715490.18017@i5.linux-foundation.org>
	 <9e4733911003181739m2f605dd7g9406aaecc296749f@mail.gmail.com>
	 <alpine.LFD.2.00.1003181739310.18017@i5.linux-foundation.org>
	 <9e4733911003181812k1cf08833ke683226377527b56@mail.gmail.com>
	 <alpine.LFD.2.00.1003182141050.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 03:06:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsRbB-0007KM-Jl
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 03:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab0CSCFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 22:05:54 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:24373 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab0CSCFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 22:05:54 -0400
Received: by qw-out-2122.google.com with SMTP id 8so469218qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 19:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SV6kLvfGvPCIDe4udgYt5WXy2F8ASbeBatEhsZvS+oI=;
        b=DtzOpdfQqQyGyTRNIdhWBBvyYLyFCvH/I0wXwWH9JBCgaMRpxM9A5YzCXmtCIvo7Jl
         5Ve703lADVjK89MHeP+dHrAZxcojJ2tEUpCDZAKw62/yYbWqB6OU/4QAVMNGO6QXy+m6
         rb6bdu+E71g0GvOxRNxcICllYHidkGF+ySMIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qEG2m/kutWUGOWgPEgQzPgyuUr+3NsUwYlFNSzOLwbLz7PD4b27CwRT5qGDW/VJgQM
         HzQGOIICxLTSuR2z3HPedHhOCgR+jVb2dArFaaHHFlRrV24k6GexVkCei43GtCHlJJzC
         PtHGvOoMLIRXZwlM7qDyIMWG4Lq09KB3NZWvY=
Received: by 10.224.69.197 with SMTP id a5mr1026079qaj.185.1268964352308; Thu, 
	18 Mar 2010 19:05:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003182141050.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142554>

On Thu, Mar 18, 2010 at 9:45 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 18 Mar 2010, Jon Smirl wrote:
>
>> On Thu, Mar 18, 2010 at 8:50 PM, Linus Torvalds
>> > There is no real _value_ in making a .mailcap for each such buggy =
entry is
>> > what I'm trying to tell you. Those things are maybe used for stati=
stics.
>> > On the whole, they are correct.
>>
>> I was trying to track how many real people were working on the kerne=
l.
>> =A0If we don't collapse the 13 different versions of you down to one
>> person the number numbers are way off.
>
> If you have a cleaned up .mailmap file which doesn't include unneeded
> entries then just submit it for inclusion. =A0If someone else eventua=
lly
> cares to check and update it then another patch should come forth at
> that point. =A0That doesn't have to be any more complicated than that=
=2E

I sent you a copy, feel free to do whatever you want with it.  The
academics doing statistics on Linux will love you for submitting it.

--=20
Jon Smirl
jonsmirl@gmail.com
