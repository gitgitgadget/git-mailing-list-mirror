From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/4] gitweb: show notes in commit(diff) view
Date: Sat, 6 Feb 2010 15:34:02 +0100
Message-ID: <201002061534.02972.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002061416.29481.jnareb@gmail.com> <cb7bb73a1002060615o261d974cnf347ba5af5ae324b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 15:38:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndlnt-0000E2-W7
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 15:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754407Ab0BFOeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 09:34:14 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:43979 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab0BFOeN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 09:34:13 -0500
Received: by fxm20 with SMTP id 20so124314fxm.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=e/lleOamRnhejSq4HUN6YgLtrnvJpUWS18/LRf1t2FI=;
        b=o4ynrd1KmVYRvHEUUTTXIFMtcXmDnR2ugdle5Bzysay41QT1elFI+seaQ2tswUw/jh
         /nzOcaiO9H7kS9/HpiCZz7XgJbv0SNt3+M2tHwt0dVFlEjpft3q5Se/tZfVBKPn23+/c
         y7wq1296drDdbn8YFBzruXUNh1KOPhLRsPe6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=gCHkwvKfSH84ajfTQotWETsAGBzbau1/cBGlVfaMmr5Mbjiwek7+LYyAnivElGpLtw
         6CfcuRvgMV6MF8SC8iPk7fkark8YFi+X4M4/VK8st2g4EaP/zjEal2wWLxSeoXzM7slm
         k5nKlezPm/vRxS39QSUgnafcSz5sfEZ7WcZp4=
Received: by 10.87.9.39 with SMTP id m39mr4992494fgi.73.1265466851213;
        Sat, 06 Feb 2010 06:34:11 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id d6sm1109654fga.4.2010.02.06.06.34.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 06:34:10 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002060615o261d974cnf347ba5af5ae324b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139170>

Giuseppe Bilotta wrote:
> 2010/2/6 Jakub Narebski <jnareb@gmail.com>:
>> On Thu, 4 Jan 2010, Giuseppe Bilotta wrote:

[...]
>>> =A0# return all refs matching refs/notes/<globspecs> where the glob=
specs
>>> =A0# are taken from the notes feature content.
>>> =A0sub get_note_refs {
>>> + =A0 =A0 local $/ =3D "";
>>> +
>>
>> Why it is needed here? =A0Why you want to use empty lines as termina=
tor
>> (which means reading whole paragraphs), while treating two or more
>> consecutive empty lines as a single empty line (according to
>> perlvar(1))?
>>
>> If you want to slurp whole file, this should be
>>
>> =A0 =A0 =A0 =A0local $/;
>>
>> or more explicit
>>
>> =A0 =A0 =A0 =A0local $/ =3D undef;
>=20
> Ah, sorry, for some reason I thought "" was the default.

If you wanted to use default value, why set it at all?

--=20
Jakub Narebski
Poland
