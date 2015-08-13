From: Matthieu Moy <matthieu.moy@imag.fr>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Thu, 13 Aug 2015 18:52:11 +0200
Message-ID: <FC0BD660-1476-430A-9F71-E9D0E6681780@imag.fr>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com> <1438693282-15516-1-git-send-email-Karthik.188@gmail.com> <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com> <CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com> <CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:53:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPvkh-000723-BL
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbbHMQxG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2015 12:53:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38137 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbbHMQxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:53:03 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7DGqsOA019443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 13 Aug 2015 18:52:55 +0200
Received: from [10.181.21.44] ([37.163.150.109])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id t7DGqcZ4014979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 13 Aug 2015 18:52:51 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 13 Aug 2015 18:52:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7DGqsOA019443
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1440089575.25008@jxKT9TgCiMUdXknu/Yd3Bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275863>



Le 13 ao=C3=BBt 2015 13:35:21 GMT+02:00, Karthik Nayak <karthik.188@gma=
il.com> a =C3=A9crit :
>On Thu, Aug 13, 2015 at 4:21 PM, Karthik Nayak <karthik.188@gmail.com>
>wrote:
>>
>> This was taken from branch.c, I thought of using an enum instead but
>that
>> would again require most of branch.c, hence it's been carried over
>> without changing
>> I'm thinking of changing it, any suggestions?
>>
>
>What I was thinking was of having:
>
>#define FILTER_REFS_INCLUDE_BROKEN 0x1
>#define FILTER_REFS_TAGS 0x2
>#define FILTER_REFS_BRANCHES 0x4
>#define FILTER_REFS_REMOTES 0x8
>#define FILTER_REFS_DETACHED_HEAD 0x16

You meant 0x10, not 0x16 I guess.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
