From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: htonll, ntohll
Date: Tue, 12 Nov 2013 15:44:33 +0100
Message-ID: <52823ED1.1020306@gmail.com>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de> <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com> <52713E67.3000202@web.de> <527158AF.3070204@ramsay1.demon.co.uk> <52716C58.3090507@web.de> <5271750D.5010801@ramsay1.demon.co.uk> <52725A05.1050805@web.de> <52783518.1030908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	=?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Nov 12 15:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgFCu-0000kU-JN
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 15:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab3KLOol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Nov 2013 09:44:41 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54199 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3KLOoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 09:44:39 -0500
Received: by mail-ee0-f46.google.com with SMTP id b57so3184286eek.19
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 06:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Xbrkj2f80OR4GvdCjYdi2LgAUIQmUbbb21IqggekYnQ=;
        b=i2PLH0iXTtICj2+UzxhgbHi5Kmk9WtGkqndwQDZxL8gcFwD4yvSgc7TJa/yUsmrTAO
         g+yX3pQAnsNhYo9pxnz8wafMP/g7Rz9ghtro2D4+u7i01ZWqWw0zGKAAmMQlipJLVjWZ
         oc3drWusvBN4D6B3fjgEKnt7M9MoGaHR78gKeIcPc4GG3zyT5EeXd2xFRZKROsJ/HW+V
         e+MqKu1cSZw0fAoiRY5XMgg0xIA97ShYKdTELGUSGt8duoHeoAMs3ZLyaz5hbkKBdTv9
         7pBPoeIP/wlTFFinAVDmD30U5lT75lRbCameHYkt/TA5GULR6KLRWXjz4g2IH/H84uOS
         C4UQ==
X-Received: by 10.14.149.13 with SMTP id w13mr340100eej.134.1384267478811;
        Tue, 12 Nov 2013 06:44:38 -0800 (PST)
Received: from [158.75.2.83] ([158.75.2.83])
        by mx.google.com with ESMTPSA id z2sm76710728eee.7.2013.11.12.06.44.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Nov 2013 06:44:38 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <52783518.1030908@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237712>

W dniu 2013-11-05 01:00, Ramsay Jones pisze:

> [Note: I have never particularly liked htons, htonl et.al., so adding
> these htonll/ntohll functions doesn't thrill me! :-D For example see
> this post[1], which echo's my sentiments exactly.]
>
> HTH
>
> ATB,
> Ramsay Jones
>
> [1] http://commandcenter.blogspot.co.uk/2012/04/byte-order-fallacy.ht=
ml

Errr... htonl is about host to network order, and not about big- or
little-endianness of architecture.  The macros are good, its their
implementation that might fail [1].

--=20
Jakub Nar=C4=99bski
