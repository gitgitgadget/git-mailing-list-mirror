From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 21:41:29 +0200
Message-ID: <201009102141.30416.jnareb@gmail.com>
References: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com> <AANLkTimw5pzdGjiPps-CE1PJS1sBXYw3dE4vhdwm1CYP@mail.gmail.com> <AANLkTi=D2M-QrbLodunphy+KJYt7eyfWsgzbwcBSZNyS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?iso-8859-1?q?=C6var_Arnfj=F6r=F0?= Bjarmason" <avarab@gmail.com>,
	git@vger.kernel.org
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 21:41:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9Tj-0000lq-Rw
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab0IJTlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:41:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58353 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab0IJTli (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:41:38 -0400
Received: by bwz11 with SMTP id 11so2541513bwz.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Uvgea/WfU+bwLbddoGgzgyLDDhzrDVxxxhvoysjeI/4=;
        b=am1wDSWWzGMMNiTINkJCwA23XyUeC/gxACpfOncnRBNi3ZtC22qNE11hHyMRx/GQg5
         LJ8up+eiJAAihpkLbxPOHfrXMWT/Z/1CL9sCMvrrDBi9s7fv1bIuuobI1TaBX0atT/Bh
         EeJLeMSrRFzpvTDahm7MSqP3ANiu0Z5tRTib4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wFH6qO5VnMV3moB0gbcO+tu89odCwSfpJw+ztlwwCazxHlCHGLm+fG4Y4ZzxvHf9Is
         e4pMOMLawvEZ1lQRyVCm66y1oS+R1Su4P9uQ5kCnt3uOu8ZDyJ20CqiQVjfiT3JiFiYK
         YHRmEZG4raq9doQ+jLL4N8sIstytG90CqFIsk=
Received: by 10.204.126.92 with SMTP id b28mr880047bks.47.1284147696951;
        Fri, 10 Sep 2010 12:41:36 -0700 (PDT)
Received: from [192.168.1.13] (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id f18sm2253019bkf.15.2010.09.10.12.41.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:41:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=D2M-QrbLodunphy+KJYt7eyfWsgzbwcBSZNyS@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155966>

Bruce Korb wrote:
> On Fri, Sep 10, 2010 at 11:59 AM, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Fri, Sep 10, 2010 at 18:52, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>> Bruce Korb <bruce.korb@gmail.com> writes:
>>>
>>>> After trying lots of variations, I found it to be:
>>>>
>>>> \#*
>>>>
>>>> Not obvious and not easy to look up. =A0Please add it to your
>>>> .git/info/exclude sample text. =A0Thanks!
>>>
>>> Well, it is quite obvious to me, as escaping special characters usi=
ng
>>> backslash is typical in Unix tools.
>=20
> Like cscope, for example?
>=20
>   "#what ever"
>=20
> Others use:
>=20
>    ./#whatever

Actually "/#whatever" would also work, but it would have different mean=
ing,
anchoring filename so only files in given directory matches.

>=20
> /etc/fstab requires \octal escapes, and not \xFF.

They are not escapes, but quoting of metacharacters (special characters=
).

>=20
> There are many unix standards to choose from, hence my suggestion. :)
> That backslashes are sometimes used meant I found it before  pressing
> "send".

:-)

--=20
Jakub Narebski
Poland
