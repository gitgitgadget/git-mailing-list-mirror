From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Replace memcpy with hashcpy when dealing hash copy globally
Date: Sat, 1 Mar 2014 17:13:50 +0800
Message-ID: <CALUzUxo=5aUCjL0GDz=3JjuQqN4+9pTPbmNWO3Rda+UuLDOYhQ@mail.gmail.com>
References: <1393636024-17576-1-git-send-email-sunheehnus@gmail.com> <CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sun He <sunheehnus@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 10:15:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJg0t-0004id-RO
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 10:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbaCAJPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 04:15:13 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:50312 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbaCAJOM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 04:14:12 -0500
Received: by mail-lb0-f180.google.com with SMTP id 10so3346642lbg.39
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 01:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hvyByjUjdwnIsmdqFdME1P/7U4yVvpooi5BOaXJkifI=;
        b=IdYmTWLMHXIO06Ort4t89yC/06hGbL9FgDdpipa72GTNXLHXQ3tIcCg4jZwyAzL96T
         bYEKMMYnYWexofFyiVzyiiTq0/XYO9MfPRkAeipYIOtBp1kdhujOiTz1rR/LWgRzwTAW
         5UKFv3yekOseO9oS3NMRdmh0huiOOd80odWXFhLOB1w6hsDkGumlVq+vUpfgYfZTSAlc
         293+Bkrk6W1y8WtDm8LBkf/xzw85Yug4qaTjWLZYSP+MM2f6cscor/s+Cs7Ka8YldWo4
         8UGazezw3iLw7yYo5lfUV+CjLxnjEKn57TddZDC+IeVFy+EAVFKpUYrEizkfcO+0qpB7
         dbGg==
X-Received: by 10.112.175.43 with SMTP id bx11mr822318lbc.51.1393665250637;
 Sat, 01 Mar 2014 01:14:10 -0800 (PST)
Received: by 10.114.64.15 with HTTP; Sat, 1 Mar 2014 01:13:50 -0800 (PST)
In-Reply-To: <CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243055>

On Sat, Mar 1, 2014 at 10:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 1, 2014 at 8:07 AM, Sun He <sunheehnus@gmail.com> wrote:
>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>> ---
>>  Find the potential places with memcpy by the bash command:
>>    $ find . | xargs grep "memcpy.*\(.*20.*\)"
>>
>>  Helped-by: Michael Haggerty<mhagger@alum.mit.edu>
>
> You may want to put this Helped-by before "---" because it's supposed
> to end up in the final commit.

To elaborate further: anything below the three-dash is ignored when
the patch is applied. So it doesn't show up in the commit at all. I
don't really know the reason for this - probably a patch (1) thing.

You could put the patch the Helped-by before your Signed-off-by
(sometimes referred to as S-o-b).

-- 
Cheers,
Ray Chuan
