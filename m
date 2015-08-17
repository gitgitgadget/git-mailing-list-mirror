From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 08/13] ref-filter: add support to sort by version
Date: Mon, 17 Aug 2015 20:35:49 +0530
Message-ID: <CAOLa=ZR=xxbgeaqke6iA37cij8HMygOSzeHOD2jPYbXhmV2noQ@mail.gmail.com>
References: <1439661643-16094-9-git-send-email-Karthik.188@gmail.com> <CAPig+cRs3EbO1HmHmfNTaXXiiDjyqgeiUqv2_XGJL1=Ogb6a2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 17:06:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRLzT-0005IS-LE
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 17:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbbHQPGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 11:06:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35410 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbbHQPGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 11:06:19 -0400
Received: by obbop1 with SMTP id op1so115293944obb.2
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iAEkMoNtgR6fCDFloXN73jkKs8eSn51OtEihFrhDMN4=;
        b=HHuoGqVDuKu5pOi9tD3/0Ka+w9UXoetDAAbYi+tm6UJDjORuaz87in/BO6hnXxnJW6
         U8KYvaysiYUl25oHuc0Mn/8SymGyxWjICmGxNl36nKP6toMklmLiQU0uDrJFvQlE0o9E
         ZkWLJxT5g18XbFxHKy74CD4akvCwjXmYFuVFdoVa6wY3NvmKMUHGxFx+aJldPuRrlXvz
         t8BNj4npwBHNuqpDA8GoMQldNF4lmXLatKgaLmBz7Zb1kK0ibr4pgbyNCxD4HbOIr/h+
         b8MsCyXr1zEpl7p9iBle7IyEHqTUIuI3t2gX8l6AnKT0riPBPubdLtG4YaOqNn254z3V
         lwiQ==
X-Received: by 10.60.62.105 with SMTP id x9mr1565896oer.1.1439823978357; Mon,
 17 Aug 2015 08:06:18 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 08:05:49 -0700 (PDT)
In-Reply-To: <CAPig+cRs3EbO1HmHmfNTaXXiiDjyqgeiUqv2_XGJL1=Ogb6a2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276055>

On Mon, Aug 17, 2015 at 10:23 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Add support to sort by version using the "v:refname" and
>> "version:refname" option. This is achieved by using the 'versioncmp()'
>> function as the comparing function for qsort.
>>
>> This option is included to support sorting by versions in `git tag -l`
>> which will eventaully be ported to use ref-filter APIs.
>
> s/eventaully/eventually/
>

Will change thanks :)

>> Add documentation and tests for the same.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>



-- 
Regards,
Karthik Nayak
