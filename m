From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 7/7] rebase -i: write better reflog messages
Date: Wed, 19 Jun 2013 09:37:52 +0530
Message-ID: <CALkWK0nfMax6SmybNunob=3+MtJhXQ3_X=34dq+cMV+hA8cKQw@mail.gmail.com>
References: <1371581737-10013-1-git-send-email-artagnon@gmail.com>
 <1371581737-10013-8-git-send-email-artagnon@gmail.com> <7v38sf40my.fsf@alter.siamese.dyndns.org>
 <CALkWK0==+Zs-Ej92VsHnF60_=RTigkKo+3xLew3JdavC3fbzoA@mail.gmail.com> <7vsj0f2l6z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 06:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up9hF-0006CH-6V
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 06:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab3FSEId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 00:08:33 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36529 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab3FSEIc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 00:08:32 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so12253095iec.22
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 21:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ynIQYvtQZmpZnpOrCNexJFdAFvRbOH+FkTXzyl4JmMs=;
        b=s4Qc25sSaZWvefOjI8o5GWzfs9clUpK1KoJu0UACHcYTJ8BQUmb8MAzalOB8tQkfbU
         soGcBIDEI72g0C3MbG5p3HnZE8RAZufNvtvMkyj8IsBdKKlGvJ+UL80NnDUwm1KRl1NB
         vsNaKuPBAHbQTHa7HleijqWPbxDAxZPx1jDp6e4iK6hcKr6g4jU5hLc6in6pQSZKhrhG
         ux4TYjIe4S7bGzajBIBwY9q92N/IEYIipdq9D2ThJdsyJf/DNgBDCRk1GfZpq0KtXKqk
         SkZwxzQKLMAuhbIcKIfb9a3dWHw9C+ro271MC1cldFG+sKUe/QTiTVl4ZnJMKH16LzIt
         8QCw==
X-Received: by 10.50.98.104 with SMTP id eh8mr9005447igb.111.1371614912311;
 Tue, 18 Jun 2013 21:08:32 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 21:07:52 -0700 (PDT)
In-Reply-To: <7vsj0f2l6z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228335>

Junio C Hamano wrote:
>> Oh, okay.  Then just tweak before applying, if you don't mind?
>
> Sorry, you've already used my time allotment for this week.

No worries, I'll re-roll.
