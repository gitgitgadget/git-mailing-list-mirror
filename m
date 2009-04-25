From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Sat, 25 Apr 2009 22:24:22 +0300
Message-ID: <94a0d4530904251224g6b228448q276436f17f7e5cc3@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
	 <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
	 <alpine.LNX.2.00.0904251445030.2147@iabervon.org>
	 <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 21:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxnYn-0007Q7-0a
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 21:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbZDYTY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 15:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbZDYTYZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 15:24:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:55230 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbZDYTYY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 15:24:24 -0400
Received: by fg-out-1718.google.com with SMTP id 16so355502fgg.17
        for <git@vger.kernel.org>; Sat, 25 Apr 2009 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=T2KRzyUuDv0OrZn2cEXb7ZTwmzR9zCh5f/PZrSghJG8=;
        b=ZcOP5Xw+/3WLam+l0O59cNslDq+mB02QOHrhW3Nz4VaIC07h4Jz2AEYHQMoJ7JNhsk
         92rK0z0YDkVpV7RR+9mGwix+FNVdUWQ/ODszrXH9RU/dIaA2p6E4ld/BmG6f1S4tpzro
         sMpktDrF70uo8I8anj55vZZwM4enJrEHaOSJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tPpnd7py4JDseauwhGo8sApqENDTsYpQdr1Jojej+6S0H207Mqo/w0Buh28xmYiHG7
         Fmjf2Z4+10jjClnAR/Xy0RH8lFFLiuHzmOJifD7mAf24biRUhemDhQ8a7xGbB+vcKbWu
         lrWz9Zr0Sjmx1HoB9uW5/zX72uStGKUJvFVyM=
Received: by 10.86.23.20 with SMTP id 20mr1846451fgw.17.1240687463073; Sat, 25 
	Apr 2009 12:24:23 -0700 (PDT)
In-Reply-To: <b4087cc50904251216p617e347bmdc70e109298fa9b2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117574>

On Sat, Apr 25, 2009 at 10:16 PM, Michael Witten <mfwitten@gmail.com> wrote:
> On Sat, Apr 25, 2009 at 13:55, Daniel Barkalow <barkalow@iabervon.org> wrote:
>> On Fri, 24 Apr 2009, Michael Witten wrote:
>>
>>> > And the term is already in use for this particular case,
>>> > and it doesn't mean anything else at all (since, of course, the crypto
>>> > thing is "SHA-1", not "sha1"), and it's short (which is important for
>>> > making it easy to look at usage help).
>>>
>>> What happens when SHA-1 is shown to be broken or there is a better
>>> alternative? Then we'll see "sha1 for historical reasons"... bleh!
>>
>> Why do you think SHA-1 has anything to do with it?
>
> Well, it's named sha1.
>
>> Git's sha1s could just
>> as easily be 160 bits of a SHA-256 hash and there wouldn't be any
>> user-visible difference. The term doesn't imply any particular significant
>> connection to a particular algorithm.
>
> Then give it a generic name like 'hash'.

For most purposes in the documentation sha1's are used as ids, so why
don't use "id" instead? Like 'commit id'. The fact that the id is also
a hash sum is hardly relevant for the user.

-- 
Felipe Contreras
