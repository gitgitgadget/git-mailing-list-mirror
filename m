From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 13:52:57 -0700
Message-ID: <AANLkTim4+_GWdnzEGsiqwbySN7uy+7MgwnCYXWiVgjqQ@mail.gmail.com>
References: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com>
 <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com>
 <201009102133.19427.jnareb@gmail.com> <201009102156.31439.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 22:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuAb4-0007Cq-4Y
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 22:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab0IJUxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 16:53:15 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53314 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab0IJUxP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 16:53:15 -0400
Received: by ywh1 with SMTP id 1so1325430ywh.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GXCnf/TadTvrSxRQEVq+/Qm8BOv4d+7FkEeCF+Zjwmk=;
        b=pDgyvpl6cOMQR5NNgUj3iCvSSorWSDSCJauxhu4dVbwr8cK2QhJ2CQZyN/dEIlL23t
         UWuyO9D/1BLrzuVW7kbmFRSq07Pha4JaAMtCcQejIkhhH9yXaUs/Qd/Bk5sZLAspKEMr
         f853vcAOGM3OETlgrdF5ef8DjsNrqr5ftLll0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SH2sERuSp+PW/FBag8qmqig/YY/Rz6iTM+zCJ1P9ckHnaJATPyFdU0JH875P8K19vR
         Vl/UCQh1hmLg7sRj+3bcBGvsTWgV83zTXBcuE8zL1g/nBIHHCQn9XQF0rcoDwML8xn21
         OQuCpcpjui0lhJiAl1/NUg1yRKsLSWiqLoWto=
Received: by 10.100.152.10 with SMTP id z10mr1315991and.41.1284151992587; Fri,
 10 Sep 2010 13:53:12 -0700 (PDT)
Received: by 10.231.182.11 with HTTP; Fri, 10 Sep 2010 13:52:57 -0700 (PDT)
In-Reply-To: <201009102156.31439.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155969>

On Fri, Sep 10, 2010 at 12:56 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Jakub Narebski wrote:
>
>> Something like this?

> diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> index 7dc2e8b..20abc20 100644
> --- a/Documentation/gitignore.txt

I think the prototype for info/exclude is a good idea, too.

>> /etc/fstab requires \octal escapes, and not \xFF.
>
> They are not escapes, but quoting of metacharacters (special characters).

./#
\#
"#"
\043
\x23
&35;

whatever you care to call it, however you spell it, the result is intended to be
the same:  This sequence of characters is to be interpreted as part of the token
and not special annotation (or token separator) characters.

Anyway, thanks for fixing the doc.  - Bruce
