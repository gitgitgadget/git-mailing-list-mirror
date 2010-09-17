From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/7] gitweb: group styling
Date: Fri, 17 Sep 2010 19:22:53 +0200
Message-ID: <201009171922.53396.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <201009171826.15454.jnareb@gmail.com> <AANLkTi=8x4JuK99W5BOfUBVUza1sUXE3e_mDOq9-wF_z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 19:23:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OweeL-00037n-4q
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 19:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132Ab0IQRW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 13:22:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab0IQRWz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 13:22:55 -0400
Received: by bwz11 with SMTP id 11so2835537bwz.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GJ+zhGfKAK99onaJv5+atqhuoklnvoQZJ/W7HU7gCeo=;
        b=TtKYOyM4ItNlAZmaM4rJV8L58Um3+jSw4QUSTis2sr50Q2c75M7GiCuRwgtF+o2ma3
         YUg8phKVqAoy/82LmdSKqYMB2yT0A19ZSGzGn+AMW36KrNoDcdp73MoLqrTKcugBVFx1
         2NPgmiI6/IQlJyITZ3SqfthlyzXOcb12MurVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mlV6AlIaSKi4w85Zdai7wLdXnh6RK97bZUujdrfBeS7Vo996R9ewCySueR6J1zDX79
         tD/1SyO1ECEDa3bzkMZurMZwmfJ35y5ye/TBWxWPs8ASrB9+xrj/W77IZirMR0wCPdW6
         o1roYuyd/6cO7BkZE4rJAr2jNbJDp3KeitP+c=
Received: by 10.204.123.137 with SMTP id p9mr3767879bkr.206.1284744174078;
        Fri, 17 Sep 2010 10:22:54 -0700 (PDT)
Received: from [192.168.1.13] (abvo68.neoplus.adsl.tpnet.pl [83.8.212.68])
        by mx.google.com with ESMTPS id y2sm3843140bkx.20.2010.09.17.10.22.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 10:22:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=8x4JuK99W5BOfUBVUza1sUXE3e_mDOq9-wF_z@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156402>

Giuseppe Bilotta wrote:
> 2010/9/17 Jakub Narebski <jnareb@gmail.com>:
>> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>>
>>> +div.group {
>>> + =A0 =A0 margin: .5em;
>>> + =A0 =A0 border: 1px solid #d9d8d1;
>>> + =A0 =A0 display: inline-block;
>>
>> Is this 'display: inline-block;' really necessary? =A0I think we can=
 do
>> without it (and I've heard that there are problems with it, but thos=
e
>> might not matter in layout used by gitweb).
>>
>> Otherwise nice.
>=20
> I'm not aware of problems with inline-block (I can check
> quirksmode.org though if necessary), but without it the divs will be
> as large as the _containing_ block, meaning that each div will be
> ultimately as large as the page. By using inline-block, instead, they
> become as large as the _contained_ stuff, thus fitting the inner
> table.

Errr... I am using old web browser that doesn't support 'inline-block',
so I don't know what it should look like.  I'll check later.

But graceful degradation to 'block' doesn't look too bad.
--=20
Jakub Narebski
Poland
