From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Promoting Git developers
Date: Thu, 12 Mar 2015 09:15:43 +0700
Message-ID: <CACsJy8D38Lx5zvpOGPvnYVNXh4EYbF+rLL8kwb9pwP7EqCqfxQ@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
 <54FDA6B5.8050505@drmicha.warpmail.net> <CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
 <xmqqk2yo22ce.fsf@gitster.dls.corp.google.com> <CAEjxke-6DuTW0-ZyDtUUdCWhEtuw6x3X6LuM_Fj22QztUvFfjQ@mail.gmail.com>
 <CACsJy8CHmdSRTfspKfSqtg7VXT7D6uxqr49KQQe8dhE5popakg@mail.gmail.com> <xmqqd24g6uf1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Jason St. John" <jstjohn@purdue.edu>,
	Christian Couder <christian.couder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 03:16:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVsff-0001W5-T3
	for gcvg-git-2@plane.gmane.org; Thu, 12 Mar 2015 03:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbbCLCQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 22:16:18 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36816 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbbCLCQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 22:16:16 -0400
Received: by iegc3 with SMTP id c3so10484562ieg.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2015 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E3HPMUiUOWE3qHh/t+B4xVdZ+HOQINY4Dostx/fjyhc=;
        b=SbCR5Oxb5cl5Td8Dja+2IE4o16oHkSZXZVstyYmc7IfO8oia3/cVsygdeHM2x5O3YJ
         pEx09XLo+V8vIBuvKYvwvHQVttCDy4vFflQeR2PIfWrIAFI4wr4M8hAhtdoQnWN4W2oH
         BTa9Hn12D1mKbyD38CnZxCHkTT27RDBJMiGbDW7KrzuTZPktHcgREqhR41snDJHoejs1
         0jBffZgUDncJ6yrRYlQX2CMEWVMK3hLwdW5D6XhHZulu7JQWLtZc8jG1/9Y3Rm9DHuzN
         kViTr3/PzG4GFs0EN1W0oszo5XEOhsRiwS+twjjtzPde9hNvM2lrXkQLa1/wiKQX9fit
         oWHg==
X-Received: by 10.107.15.155 with SMTP id 27mr52065261iop.49.1426126573522;
 Wed, 11 Mar 2015 19:16:13 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 11 Mar 2015 19:15:43 -0700 (PDT)
In-Reply-To: <xmqqd24g6uf1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265351>

On Wed, Mar 11, 2015 at 11:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> ... We may want to acknowledge review efforts as well, by
>> grepping Helped-by:, Reviewed-by:...
>
> Agreed. Something along the lines of
>
>     $ git shortlog --no-merges -s -n -t Helped-by -t Reviewed-by v2.3.0..

A quick grep/uniq/sort gives this

   1512     Acked-by
    537     Reviewed-by
    389     Reported-by
    317     Helped-by
    147     Tested-by
    143     Suggested-by
     97     Noticed-by
     78     Improved-by
     49     Thanks-to
     40     Mentored-by
     23     Requested-by
     21     Acked-By
     20     Inspired-by
     18     Based-on-patch-by
      9     Explained-by
      9     Contributions-by

It looks like people are quite creative. I think all these "*-by" (so
-t supports wildcards) and Thanks-to: could be also considered as
contribution.
-- 
Duy
