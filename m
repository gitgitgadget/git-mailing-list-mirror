From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: vc in emacs problem with git
Date: Sun, 30 Aug 2009 14:24:07 +0530
Message-ID: <f46c52560908300154k7496167l552348075cb52537@mail.gmail.com>
References: <f46c52560908270828o574c0de6s17189a7326a1376d@mail.gmail.com>
	 <f46c52560908270914o7027dc0bo873544dc0687cc48@mail.gmail.com>
	 <7viqg65up7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: help-gnu-emacs@gnu.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 30 10:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhgB9-00027x-5t
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 10:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbZH3IyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 04:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbZH3IyH
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 04:54:07 -0400
Received: from mail-vw0-f195.google.com ([209.85.212.195]:53975 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbZH3IyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 04:54:05 -0400
Received: by vws33 with SMTP id 33so2252723vws.33
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 01:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=a3/DNg6t/4q4b2NtRMxAJuDOm6utuNVhqKyldervO2Q=;
        b=YNyxiYKlonL5lMBru5D2xe1fp7XDaScizVhWVihxM4BmXGlAw/w+jRdWLn0Kxl+WQt
         /BstkYFPFNp092JYyJ2KZxiXGWBE0iKYx1rAZcVgKsrXfwNEEKMiO+TMniPvAXELxtzh
         kr8v7S0WiruPJR1z+xEPEDzyIZzmE27Zf3RFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=FODjugOnxM/LSqi0VpjhIN57bPLSUgantj/du5Cu0e4z9BQcLZs3GXVYfHDfRkA8yl
         1NBbnAJOxvMEZap0jnGI/DoluQP0VHi6+n89i4L/kwpkyVN6vEIyunf36nyIotXLj5/I
         69ZsfxuJ/8OFHoWZ/ntnyMDGybWnCFHHa3GtU=
Received: by 10.220.69.15 with SMTP id x15mr4048337vci.73.1251622447059; Sun, 
	30 Aug 2009 01:54:07 -0700 (PDT)
In-Reply-To: <7viqg65up7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127400>

On Sun, Aug 30, 2009 at 12:11 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Rustom Mody <rustompmody@gmail.com> writes:
>
>> Just updating my own question:
>> when I do a C-x v v (vc-next-action)
>> which is supposed to be the most basic operation for checking in a f=
ile I get
>>
>> =A0Wrong type argument: stringp, nil
>>
>> So vc can be assumed to be a broken I guess?
>
> Have you checked contrib/emacs/README?
> --

Sorry Junio I should have checked.

Actually I had earlier checked.
Then I tried many emacs-git options, none of which worked.
Then I upgraded my emacs to 23 in which the vc is upgraded for dvses li=
ke git.
Time passed and I forgot what I had found, made worse by the fact that
sometimes I'm on windows and sometimes on linux and the 'working'
status of different things is quite different.

However the point is that I was not loading the older vc-git.el at
all. emacs was getting the wrong one.
It may be better if vc were hardened so that it gets its own vc-*.els
in preference to random stuff lying on the load-path.
