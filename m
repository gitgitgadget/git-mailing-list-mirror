From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/10] ref-filter: add option to filter only branches
Date: Fri, 14 Aug 2015 01:43:47 +0530
Message-ID: <CAOLa=ZRyL4PLKQiw1ie5e4NN21BTy3KPVxCvf_eUeW-C5wSU2w@mail.gmail.com>
References: <CAOLa=ZSnn19DR_Y5MqUXHed0g5MSk_dwFc48dk8GoPYvL5DQ=Q@mail.gmail.com>
 <1438693282-15516-1-git-send-email-Karthik.188@gmail.com> <xmqqpp2tspb6.fsf@gitster.dls.corp.google.com>
 <CAOLa=ZRRU4htKgB46g0FAGVEGGFN+1N1250AOYJh7H5apv=RJQ@mail.gmail.com>
 <CAOLa=ZQic2=z6bJ0Ykhn2x8mE86w4HwBrJP7pb_RaemGKCZzmQ@mail.gmail.com> <FC0BD660-1476-430A-9F71-E9D0E6681780@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Matthieu Moy <matthieu.moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 13 22:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPytQ-0003q8-1u
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 22:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbbHMUOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2015 16:14:18 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:32994 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbbHMUOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2015 16:14:18 -0400
Received: by obbhe7 with SMTP id he7so46019182obb.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9KBmHBl1DsmHPgg2ejC+ancSMKXCgC5c1FYLo1PcHKw=;
        b=lbtKQ6pYdTuxQ19hvlGGKU4aLjrluommzq3jTl5JxlRfvjZoKg7wf/l/FX+Ri1htIW
         pmx7D7VJDSIu50kHYFZSVK7zJcvZOj1+vuu1IXUfQQB3NjLhYM1kH1aC3gW9DG1FtD7B
         vFgknatkwQqpXr//HUDSEGurKz87gsFJWgroQzClrKfn9E8gsZkWSx1Td7fcFZpAKfo8
         kpBQlBgWrkelwnp5B9SWEpsoOePmhX9kccMXrPGsvodCt0ZtO9giferzQwpDWmvrqTaY
         vhS5vnjPPWXgpR0/pIpE3Vvmf48IuLMZqewHOUjY+bQ/G27KIy2scjkkT0T9je48Y1Mq
         lLRQ==
X-Received: by 10.182.29.68 with SMTP id i4mr35752913obh.57.1439496857265;
 Thu, 13 Aug 2015 13:14:17 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 13 Aug 2015 13:13:47 -0700 (PDT)
In-Reply-To: <FC0BD660-1476-430A-9F71-E9D0E6681780@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275890>

On Thu, Aug 13, 2015 at 10:22 PM, Matthieu Moy <matthieu.moy@imag.fr> w=
rote:
>
>
> Le 13 ao=C3=BBt 2015 13:35:21 GMT+02:00, Karthik Nayak <karthik.188@g=
mail.com> a =C3=A9crit :
>>On Thu, Aug 13, 2015 at 4:21 PM, Karthik Nayak <karthik.188@gmail.com=
>
>>wrote:
>>>
>>> This was taken from branch.c, I thought of using an enum instead bu=
t
>>that
>>> would again require most of branch.c, hence it's been carried over
>>> without changing
>>> I'm thinking of changing it, any suggestions?
>>>
>>
>>What I was thinking was of having:
>>
>>#define FILTER_REFS_INCLUDE_BROKEN 0x1
>>#define FILTER_REFS_TAGS 0x2
>>#define FILTER_REFS_BRANCHES 0x4
>>#define FILTER_REFS_REMOTES 0x8
>>#define FILTER_REFS_DETACHED_HEAD 0x16
>
> You meant 0x10, not 0x16 I guess.
>

Yea! Of course, was randomly typing out an example :)


--=20
Regards,
Karthik Nayak
