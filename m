From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 05/11] ref-filter: add parse_opt_merge_filter()
Date: Thu, 2 Jul 2015 22:51:19 +0530
Message-ID: <CAOLa=ZTSs5y4gvS1ELWfL-_kSTrGHAt1exCxdL_0p7EE6FQD1Q@mail.gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com> <1435850470-5175-5-git-send-email-karthik.188@gmail.com>
 <vpq7fqi8p69.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:21:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAiBP-00027Z-7h
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 19:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbbGBRVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 13:21:50 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35988 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753220AbbGBRVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 13:21:49 -0400
Received: by oiaf66 with SMTP id f66so29292776oia.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 10:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7/xGCZtdYKU8n6Yp7tb910Bmt7K74Tg4XmJ7e96seCg=;
        b=ExeIJXS44HN4zW+vO3Sk1jlWPKkZNV5Eb/USsn6kvFLck4d+m1OkSxEJjlFbCtfRPE
         bflVQ4O2fpBqJF5Ln4nYVrjOek03TkwFzFsyZpE4DVE5+WSg6A+PuFWX8m++zw6aS2iM
         hRafwICn2Z/m1788IupCLcKEDWE7qxI1he59+13yyQRns8S2gAvilWolySr+JDVsdwvz
         ZUPcptpUVDDVVYXggfpUQeWQ1i8yLboxeJh6uzGkqJ2ugtevEl1UGuSOWox4mViW3SvB
         /fEr4EbY85SQiriRzUClJOE3jhwPSRLPYUu0e6r35omrLS5eZr920opITwN0+Ty3VLoe
         qMEw==
X-Received: by 10.202.200.11 with SMTP id y11mr30098320oif.111.1435857708965;
 Thu, 02 Jul 2015 10:21:48 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Thu, 2 Jul 2015 10:21:19 -0700 (PDT)
In-Reply-To: <vpq7fqi8p69.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273251>

On Thu, Jul 2, 2015 at 10:36 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +/*  Macros for checking --merged and --no-merged options */
>> +#define _OPT_MERGED_NO_MERGED(option, filter, h)                             \
>
> Detail: there's a weird large space before \. Is it an attempt to align
> the \ with a non-standard tab-width?
>

I'm not sure how this came to be, anyways will fix :)


-- 
Regards,
Karthik Nayak
