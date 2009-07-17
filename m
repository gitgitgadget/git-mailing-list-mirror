From: John Tapsell <johnflux@gmail.com>
Subject: Re: encrypted repositories?
Date: Fri, 17 Jul 2009 21:22:47 +0100
Message-ID: <43d8ce650907171322y60aaa0f3na335b7a4a2fe32c1@mail.gmail.com>
References: <op.uw7wmbr41e62zd@balu.cs.uni-paderborn.de>
	 <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthias Andree <matthias.andree@gmx.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 22:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRu2L-0007Sn-2S
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 22:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbZGQUWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 16:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756516AbZGQUWw
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 16:22:52 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:41019 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbZGQUWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 16:22:47 -0400
Received: by yxe14 with SMTP id 14so1893357yxe.33
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e6FV1Ii/4P1ZKrONWgEX46b2ki13fQ/1jkdBEjpGJgk=;
        b=TwAMAFCO2mvfoExOztlUPXZ9glwz48NhjScXgMsw/9AGq5t3NVK/zv97T9fSeZNcws
         fH7mK4TI3eC/7zCnq6reG5X1Um3fwiVli1BE4PDY2czp0x6dK4shn2fhGo6rn/DhsbbJ
         NpRH/RMUC/cLGE1XBUJOREvL9iICONZWtTeY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qZX3LNFi6wPeX8phQv9Lymfz0n2JBBIj9bCopnXrXfA4WbwKW790GGagpcEPyBcNJS
         VNJAhFdjPsW6Si/oTgvJ9LEVkzcDnrhAPsHz6lHH4LzKlV7MrRZ8QGFw8yopbFKABc3o
         zl6u85lvDo4voOTjgJgphEFgqczRg8puVXkIM=
Received: by 10.151.98.2 with SMTP id a2mr2616658ybm.191.1247862167095; Fri, 
	17 Jul 2009 13:22:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907171226460.13838@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123486>

2009/7/17 Linus Torvalds <torvalds@linux-foundation.org>:
>
>
> On Fri, 17 Jul 2009, Matthias Andree wrote:
>>
>> Assume you have a repository where you want to work on embargoed information,
>> so that not even system administrators of the server you're pushing to can get
>> a hold of the cleartext data.
>
> If the server can't ever read it, you're basically limited to just one
> story:

Why couldn't you have the actual code encrypted, but have the server
still know about the SHAs etc?  You would expose the actual commit
structure, but that might be acceptable?

John
