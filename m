From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 19:26:13 -0400
Message-ID: <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>
	 <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>
	 <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:26:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsP6d-0004kp-Us
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab0CRX0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 19:26:16 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:64785 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0CRX0P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 19:26:15 -0400
Received: by qyk12 with SMTP id 12so616464qyk.5
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 16:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ERDFgeKk0bJFDa2YmWx/zzupU/51cbm3HOlnGcpNCkg=;
        b=niCvbFYizGL6gXApJ5+tRhtUeAMmZ/zdxkgXSm9N2xalDlms7+Q9Iihu8H089mQnHN
         XLxQCzCoZuFrlswiMm/ma154eS3v7Qc+oNfLie+fMNv2UEx2zhjFGAmCRJUGiNQK3J+5
         Mt9/gisMIrN3wknNIzhQ/+L8OIckkqJ2mWvs0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Au2zWEGT3gwLuIuJSYTlTZQ1wpr2lVn5KGJ2r1oORmhQ0QpsetVvxdGyJ+OYcNCK1/
         wUb8HhlUA0FetzZgIlWub/Xz+8Z8Wst+Gs4uVEQlm1GElucmCJEkzByN26yLjja+OHEW
         syE5DVKJtrDOBmfgiwNJmyy3zEBffx4HL2YgU=
Received: by 10.224.59.134 with SMTP id l6mr996096qah.224.1268954773896; Thu, 
	18 Mar 2010 16:26:13 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142535>

On Thu, Mar 18, 2010 at 7:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> On Thu, 18 Mar 2010, Martin Langhoff wrote:
>
>> On Thu, Mar 18, 2010 at 1:27 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> > Even shorter version: NO.
>>
>> One thing we all forgot to mention here is that even if it was a goo=
d
>> idea (which it is not), implementing it means a flag day: changing i=
n
>> the pack format, wire protocol and APIs, messing up with compatibili=
ty
>> with users of pre-flag-day git, and rippling out to all the GUIs,
>> frontends and integration scripts out there.
>
> And nobody yet mentioned what should happen when someone sends a patc=
h
> by email. =A0Most commits in git.git originated from a patch sent via
> email. =A0Should we start pasting UUIDs in the email body? =A0What if=
 the
> cut & paste was quickly done and the UUID is missing a character or t=
wo?
> Because this does happen. =A0And because this UUID thing is supposed =
to be
> a perfect identity representation then we'll need a .uuidmap to corre=
ct
> such mistakes of course.
>
> Better improve on the existing .mailmap instead.

If anyone is interested I can send them a .mailmap that fixes a lot of
the problems in the kernel tree. It's two years old so it will need
updating.

>
>
> Nicolas
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Jon Smirl
jonsmirl@gmail.com
