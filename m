From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 18:34:57 -0500
Message-ID: <b4087cc51003181634u102cacaey3cb3a870a3f9fc0f@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org> 
	<46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com> 
	<alpine.LFD.2.00.1003181909180.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Mar 19 00:35:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsPFN-0007eW-6R
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 00:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158Ab0CRXfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Mar 2010 19:35:19 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:37552 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab0CRXfS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 19:35:18 -0400
Received: by fxm19 with SMTP id 19so172465fxm.21
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 16:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+86HoDq0mJegBcLQkbTo2lxeIi1gRtWCxxgQ4QnfyfY=;
        b=BH5NMXcm6768l9JNLtTSAJvwIezHw4RS9zkhSyf6Xev8iBK7jivaZa5NJwnXlzqQPk
         NcVpQOfOHqjvrAvlxJ3qxIkOygRGbV1pJoZXa0U8VmVOsfSKvGOTclvHbArvjwVIvKdg
         L++Od2Y23KODNAkmWeyaue1CGJ4Q8DAmVdusw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ENvckeeUaeHFD1oX2P9MagZ3KnsoIiiVDYcGNPWWItzNpi1yie9DEB8c8JSeylCCH/
         EoVjdr/leYvdaQr1woCFpDkMC59OO3lwnhY9ZlMJXEibUl8+Lv7DOoMDRHtmZPOfTbdh
         3jDaIDEaF3VHO5GKdYEW74aSQLSZn4O/gk1X4=
Received: by 10.239.189.76 with SMTP id s12mr1473313hbh.111.1268955317164; 
	Thu, 18 Mar 2010 16:35:17 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1003181909180.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142537>

On Thu, Mar 18, 2010 at 18:17, Nicolas Pitre <nico@fluxnic.net> wrote:
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
> by email. =C2=A0Most commits in git.git originated from a patch sent =
via
> email. =C2=A0Should we start pasting UUIDs in the email body? =C2=A0W=
hat if the
> cut & paste was quickly done and the UUID is missing a character or t=
wo?
> Because this does happen. =C2=A0And because this UUID thing is suppos=
ed to be
> a perfect identity representation then we'll need a .uuidmap to corre=
ct
> such mistakes of course.
>
> Better improve on the existing .mailmap instead.

Actually, those points were touched upon earlier (including my rebuttal=
s).
