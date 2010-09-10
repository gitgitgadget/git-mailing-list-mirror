From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 12:11:22 -0700
Message-ID: <AANLkTi=D2M-QrbLodunphy+KJYt7eyfWsgzbwcBSZNyS@mail.gmail.com>
References: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com>
 <m38w39mnyd.fsf@localhost.localdomain> <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 21:11:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou90h-0000E7-O4
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab0IJTLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:11:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36134 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab0IJTLi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 15:11:38 -0400
Received: by ywh1 with SMTP id 1so1286694ywh.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Ikya1MY+LRMtbFUo6l30i7baoFtTLaS5Wb952Oz9Ij0=;
        b=Xa3G/Ya6JRB9+BYdUfylLXxCAoQJbgfvbKF4AlM+enm5YWtElyr35vjfVUoErj6RJt
         30jn69dvSCUAH6FmDWw9/bTcZSS302AzdXzPtUI9lpAWHYnWqgxy8fDghAxP+jeQQEhQ
         KfLTgHHXfmvKK1azMxoEwb+kucUq6I/qqsLiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B8w2Fb1qg093n8bvlBBK0JPVlpqou3GsnFOTLho+ySUHCSdB6C59bjm1k4oF8FIrEb
         rw7jls3Jadcz0SJXOy4AChhdTSrGxGJGsUGYW77blVvLucFj5T1uhXz0EErQYaLEU2D3
         eMQEmp/8m8l22C7RXPwtmuTLWWeGbPgmZeysI=
Received: by 10.151.6.10 with SMTP id j10mr463153ybi.382.1284145897314; Fri,
 10 Sep 2010 12:11:37 -0700 (PDT)
Received: by 10.231.182.11 with HTTP; Fri, 10 Sep 2010 12:11:22 -0700 (PDT)
In-Reply-To: <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155956>

On Fri, Sep 10, 2010 at 11:59 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Sep 10, 2010 at 18:52, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> Bruce Korb <bruce.korb@gmail.com> writes:
>>
>>> After trying lots of variations, I found it to be:
>>>
>>> \#*
>>>
>>> Not obvious and not easy to look up. =A0Please add it to your
>>> .git/info/exclude sample text. =A0Thanks!
>>
>> Well, it is quite obvious to me, as escaping special characters usin=
g
>> backslash is typical in Unix tools.

Like cscope, for example?

  "#what ever"

Others use:

   ./#whatever

/etc/fstab requires \octal escapes, and not \xFF.

There are many unix standards to choose from, hence my suggestion. :)
That backslashes are sometimes used meant I found it before  pressing
"send".
