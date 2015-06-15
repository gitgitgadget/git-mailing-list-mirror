From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 0/11] Create ref-filter from for-each-ref
Date: Tue, 16 Jun 2015 02:17:43 +0530
Message-ID: <CAOLa=ZQxOXj=XWrYxkATJCoFvq2b0Oi9200YUgTniPoStTad7A@mail.gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <xmqqmw00958r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:48:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4bIq-0004z0-9S
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbFOUsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 16:48:16 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34359 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbFOUsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:48:14 -0400
Received: by obbsn1 with SMTP id sn1so72736572obb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gUrhLHHnzy967nPsm4c4K9QtLHG3XZlMPA4acoMvB/A=;
        b=mztGQYNMsVYrFm7qymL2dn+Ii4xaqGKmOsYBMWpK45jIaO99ZZVIQTdXXVnH0JA4cf
         6sQjm8D9yf3Mebojhm+WarHUA3Qy4xrSYeFEXch13JTfTqGT8iJU1Zu7jkiIZGzesdxb
         M7zpSpWuHs+Gw6PlotYdxBcrQ53rJBZf5bToB8N9ZFCg6jE2tAxB7OSdKRpyEifWsDV2
         g8rajDBVdXzvZ39St5lEoAZlSDxQOFGX1lkgKYSKyf1jKN6+wp/Shwb2f35Gfey1VNR4
         v2qsie8Bdiyw6XcZbP+dU6JQVg5LUh03r56TeDhMUqGyLtTRTrtDtc3ZzJklPTd4t4fh
         yy7Q==
X-Received: by 10.182.213.37 with SMTP id np5mr25538062obc.42.1434401293751;
 Mon, 15 Jun 2015 13:48:13 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 15 Jun 2015 13:47:43 -0700 (PDT)
In-Reply-To: <xmqqmw00958r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271725>

On Tue, Jun 16, 2015 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> karthik nayak <karthik.188@gmail.com> writes:
>
>> The previous version of the patch can be found at :
>> http://thread.gmane.org/gmane.comp.version-control.git/271423
>>
>> Changes :
>> * Removed an unnecessary commit (v7 3/12)
>> * Change a comment in 01/11 (v8)
>>
>> Total changes :
>>
>>  Makefile               |    1 +
>>  builtin/for-each-ref.c | 1108
>> +++-------------------------------------------------------------------------------------------------------------------
>>  ref-filter.c           | 1101
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  ref-filter.h           |   74 ++++++++
>>  4 files changed, 1195 insertions(+), 1089 deletions(-)
>
> This round looks good enough to build on top by merging more
> interesting bits from tags and branches ;-)  Let's conclude
> this series at this round and then incrementally fix if there
> is any remaining nits discovered later.
>
> Thanks all.

Sounds good, thanks for all the suggestions everyone.

-- 
Regards,
Karthik Nayak
