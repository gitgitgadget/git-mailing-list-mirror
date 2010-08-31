From: Chris Patti <cpatti@gmail.com>
Subject: Re: Example git hooks (Re: Odd results writing a Git pre-receive hook
 to syntax check PHP files.)
Date: Tue, 31 Aug 2010 17:14:57 -0400
Message-ID: <AANLkTi=8GQrF_4r44FscA8xCVRnXG-J4cO3fW07WTmL+@mail.gmail.com>
References: <AANLkTikktdPoZN8MwJD+Gxus16xBGtScCAqT9W0eiWAb@mail.gmail.com>
	<4C7B8E1E.6050708@drmicha.warpmail.net>
	<AANLkTimqzDO49h40b16gQ_=X42NXN-wZNV7d7f3KYygt@mail.gmail.com>
	<20100830141602.GF2315@burratino>
	<AANLkTi=GUrnH87faWH8G0tD7_KAynVf_ig0KpQRwnsaE@mail.gmail.com>
	<20100830143411.GH2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 23:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqYAa-0003Uu-5O
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 23:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676Ab0HaVO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 17:14:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60964 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab0HaVO6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 17:14:58 -0400
Received: by bwz11 with SMTP id 11so4821326bwz.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IfP4Cx+SUqcEwqv5sRT3v/yTe1F6XjBc8t5Ur8Bg2RY=;
        b=ckIRYW6t/N4JOSXWG/eVu9Rt9+c6bxc2jBstntg4RvlK3VAaylQUlWtc4BhOaId+ws
         sWhZixgGGX1ZDntxFahn4l+dwKvqV1XBitQyjYF/pMlJZQrBsXJAEddY4MBSwjjye9Xq
         Yy8GSGwHqNP8D2P92bFKnXj0LYz/oWOOlwJMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tbAWnLAMdZYqwXGqJBQMZ11GI2Oc2D/VCksr3CPVP0L0y7LPLHyopOoKSrVakrafwg
         z4tyoMOUZUDQKyYxMZ2xZgQCkf/yD2DFUES7lRw5xlebqMlDniyF7Nuh3jezHrl6Z+X+
         vacVmjj2AhJNFI1Uuyxu0qY1rfOXOf9ccLDzc=
Received: by 10.204.75.132 with SMTP id y4mr4652670bkj.130.1283289297254; Tue,
 31 Aug 2010 14:14:57 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Tue, 31 Aug 2010 14:14:57 -0700 (PDT)
In-Reply-To: <20100830143411.GH2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154983>

On Mon, Aug 30, 2010 at 10:34 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Chris Patti wrote:
>
>> (P.S. Is there a canonical 'example Git hooks' location I could
>> publish this to when it's working? I think there's a dearth of this
>> kind of example for people out there right now)
>
> Try the git wiki (git.wiki.kernel.org). =C2=A0There is a page for ali=
ases
> but no page for example hooks yet (though there are some examples
> under InterfacesFrontendsAndTools). =C2=A0You could be the trailblaze=
r.
>
> There are also a few examples in git templates/ and contrib/hooks,
> of course.
>

This is sub optimal.  We really need a central Git repo somewhere
where people can just contribute the hooks they've written.

I can certainly create a new page for my hook and paste the code in,
but all the hooks that are currently up there are links to hooks
hosted elsewhere, and I would rather not provide pointers to my
personal domain/hosting because that could change without notice.

Hrrm.

-Chris


--=20
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, =
Pixar
