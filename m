From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] use starts_with() instead of !memcmp()
Date: Fri, 21 Mar 2014 14:05:07 -0400
Message-ID: <CAPig+cQeVYhndNEmiKFVxfGv=p2vZWmoP_nwwc+NTPLGQfbeng@mail.gmail.com>
References: <1395191883-42409-1-git-send-email-quintus.public@gmail.com>
	<CAPig+cTWV0PWOh88u+rbMPvnn3O+OhTJATEtXXi4oLKUN25Ezw@mail.gmail.com>
	<xmqqzjkjv6gx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Quint Guvernator <quintus.public@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:05:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3of-0007D2-I2
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 19:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbaCUSFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 14:05:10 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34487 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbaCUSFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 14:05:08 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so2740844yho.18
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OxTQIVOuLhp9h4d0JH2VFYA2TitZBYiHJeEod6aDniM=;
        b=XyIH7zsPcFdeIdQhglpeiTGOp9TI/od35nbyI2CnLhOJUNa6j8kr9Xxv4btqn23/EJ
         lE2jfHKNnl03215dOGUSUI0tHwIqK/xy0QrWQtmg3tgl7PLjrrFIacaNBh9y3Edh4CBa
         bzPFY99StSd8i6BhbTKlPV2vupY3sAeVX5sYJIvQec6Yja7avgqmWOx6wJO728Z3xcfa
         MAlBU3xZ6KLjq8CL94O0kgCHQ68frizUf5I++45Jt5WLU7jaGA3z0FyGiilgivDRCP5Y
         y0vL0cnP32WlonEpX7KwSu01Wll/pM5eRMdpuehEXeQl24b6xgRgom2amkfuOYxh0to0
         yHsQ==
X-Received: by 10.236.127.68 with SMTP id c44mr41908822yhi.1.1395425107967;
 Fri, 21 Mar 2014 11:05:07 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 21 Mar 2014 11:05:07 -0700 (PDT)
In-Reply-To: <xmqqzjkjv6gx.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: my5TNJLnVMztPcsUzCqCdUQ9RuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244714>

On Fri, Mar 21, 2014 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Mar 18, 2014 at 9:18 PM, Quint Guvernator
>> <quintus.public@gmail.com> wrote:
>>> Another version, this time very in line with the review and commentary of
>>> Junio, Eric, and Michael.  This version boasts a revamped commit message and
>>> fewer but surer hunks changed.
>>
>> Explaining what changed in this version is indeed a courtesy to
>> reviewers. Thanks.
>
> So, is that a "reviewed-by: Eric"?

No, sorry. You and Peff were actively reviewing Quint's submissions,
so I merely scanned them quickly without making a careful examination.
I've been commenting upon so many GSoC submissions that it's hard to
remember which is which, and upon reading "Another version, this time
very in line with the review and commentary Junio, Eric, and Michael",
I had to search the list archive to figure out why my name was listed.
Hence, the suggestion from me that providing a link to the previous
attempt is a welcome courtesy.
