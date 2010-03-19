From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 12:40:15 +0000
Message-ID: <3f4fd2641003190540y79685d69x7270c3aa84cdf6f7@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <4BA338C1.7030803@alum.mit.edu>
	 <b4087cc51003190439x3c9ff269g35d11432bd2a3d60@mail.gmail.com>
	 <alpine.DEB.2.00.1003190441530.3821@asgard.lang.hm>
	 <20100319115445.GA12986@glandium.org>
	 <3f4fd2641003190509j6e4908e4kab87b601d2ce9c00@mail.gmail.com>
	 <9e4733911003190525m552a400exdd7fb3f6c88cc4ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mike Hommey <mh@glandium.org>, david@lang.hm, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 13:40:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsbV3-0000yJ-5v
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 13:40:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab0CSMkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 08:40:19 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49613 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0CSMkR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 08:40:17 -0400
Received: by wwe15 with SMTP id 15so1766399wwe.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=vifhLtqieBgQmc0QsiKNgn2xILH4utfFhoBHxK9QJ7I=;
        b=HA6x4/xC9PhNQZqhvhTfKYQSdkKnTzwJ3kMq0qYm9iBD/yV1fhXmHtMqt+0EEnwR2+
         brdTwzxOmSNRg6n1G5fOulDwG3u+zbuxJt24lIHYqGVNl22dQuISGZm5+wxZxV6Vdlvh
         S4jS53PTuSm4YzxQ13YJyVOlN5bPpRUAXK0mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qbm/C8ncodK29M5dDwu2Jj6fQpwX1NOFgWE4YD/UjInPCLb0qwCkbdQ6U0HMh79Tq3
         47FWioK81GctJ/xJhyiHckkHZBpRFO5oD3gL5Zpb9GXRsoh9iMNavVfiYsHRew/w5NdY
         eyAnA+TEIfvkMcp0llJLJVTAknQyV6g+h2AKA=
Received: by 10.216.93.68 with SMTP id k46mr808427wef.104.1269002416216; Fri, 
	19 Mar 2010 05:40:16 -0700 (PDT)
In-Reply-To: <9e4733911003190525m552a400exdd7fb3f6c88cc4ca@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142585>

On 19 March 2010 12:25, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Fri, Mar 19, 2010 at 8:09 AM, Reece Dunn <msclrhd@googlemail.com> wrote:
>> On 19 March 2010 11:54, Mike Hommey <mh@glandium.org> wrote:
>>> On Fri, Mar 19, 2010 at 04:45:38AM -0700, david@lang.hm wrote:
>>>> here is where you are missing the point.
>>>>
>>>> no, there is not 'much less chance' of it getting messed up.
>>>>
>>>> you seem to assume that people would never need to set the UUID on
>>>> multiple machines.
>>>>
>>>> if they don't need to set it on multiple machines, then the
>>>> e-mail/userid is going to be reliable anyway
>>>>
>>>> if they do need to set it on multiple machines and can't be bothered
>>>> to keep their e-mail consistant, why would they bother keeping this
>>>> additional thing considtant? Linus is pointing out that people don't
>>>> care now about their e-mail and name, and will care even less about
>>>> some abstract UUID
>>>>
>>>> people who care will already make their e-mail consistant.
>>>
>>> While I don't agree with the need for that uuid thing, I'd like to
>>> pinpoint that people who care can't necessarily make their e-mail
>>> consistant. For example, Linus used to use an @osdl.org address, and
>>> he now uses an @linux-foundation.org address. It's still the same Linus,
>>> but the (name, email) pair has legitimately changed.
>>
>> So create an aliases list that maps one (name,email) to another that
>> is from the same person. There is no need for an additional item (a
>> uuid) to solve this problem. It also means that searching on any
>> (name,email) pair will find the others, so you only need to
>> remember/find one of the identities for the person you are interested
>> in finding the commits for.
>
> git already supports aliases via the .mailmap file. Pick one
> name/address pair that you like and then use .mailmap to map all of
> the variations into the primary one. Granted some git tools don't
> process .mailmap, but it is easier to fix the tools that create a new
> ID system.
>
> Look at the .mailmap in the current kernel tree. It fixes a few
> problems. I have a much larger one that fixes most address issues.
>
> You don't need to reimplement this aliases, they are already in git.

Indeed. I wasn't aware that mailmap catered for this as well.

- Reece
