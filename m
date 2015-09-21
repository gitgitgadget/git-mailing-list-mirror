From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: git-p4: nicodeDecodeError in ./t9822-git-p4-path-encoding.sh
Date: Mon, 21 Sep 2015 10:22:28 +0200
Message-ID: <9B298E43-50B1-4BCF-8D58-1923BD2D89F1@gmail.com>
References: <55FFAB62.8050106@diamand.org> <55FFB741.4080304@diamand.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 10:22:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdwMv-0002o2-9M
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 10:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbbIUIWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 04:22:33 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34250 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbbIUIWc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 04:22:32 -0400
Received: by wicfx3 with SMTP id fx3so134138660wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=r4zwzZ6sDN3Jg2WwRxoj1gJu13TDDxHNxhXUVIWGV9U=;
        b=watYUD8wwPWhqvxOi3tQthZvPDgNE4cqwVBO7hE/rLDFC+R9InU970kWvPRGSXekv5
         Tk5MrXhd0FDzJMMHT50aqDGd7VEYbIincYFko+QG2sE1qKwi5wO4ve+m5AoBnL7T8ucx
         fwTAs16ZKBNEAB057xjNT/ofYV1njFQQFwbIGjPowoRsg26pJC95qwWSW7KmFWDMCG25
         KTAZQOc+5w2ecmUGmiGvVHoJxt9eDg3YnevCI/w+azuEnd+EDM/d+n4eWoBxhqJHQOO3
         hwV3X2lM4lxdYUnQ3jQY++Jy7x3ry88QkbJCcdkV1ngTI9pQF2dhoVvLpZ2gb3J7C8AI
         1MPA==
X-Received: by 10.194.238.168 with SMTP id vl8mr23421715wjc.128.1442823751484;
        Mon, 21 Sep 2015 01:22:31 -0700 (PDT)
Received: from [10.146.248.71] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id az6sm12159505wib.12.2015.09.21.01.22.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 01:22:30 -0700 (PDT)
In-Reply-To: <55FFB741.4080304@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278287>


On 21 Sep 2015, at 09:52, Luke Diamand <luke@diamand.org> wrote:

> On 21/09/15 08:01, Luke Diamand wrote:
>> Lars,
>>=20
>> When I run t9822-git-p4-path-encoding.sh, the last test fails (it's
>> supposed to pass) with the following backtrace.
>>=20
>> This is with 'next' at 3dd15c02a81a280c83c8d5e32c6cb71a64177ca6.
>>=20
>> Any ideas as to what I'm doing wrong?
>>=20
>=20
> I think this is probably user error!
>=20
> Luke
>=20

No user error. It=92s is a bug :-(
I will provide a fix shortly!

Thanks a lot,
Lars