From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: Re: [PATCH v2 1/2] Teach reset the same short-hand as checkout
Date: Tue, 10 Mar 2015 13:07:31 +0530
Message-ID: <CAODo60pDGeX+VtuhvByduBzvmFabH4GVH-xe-dcMou_Zz=C7vg@mail.gmail.com>
References: <1425888936-23370-1-git-send-email-sudshekhar02@gmail.com> <xmqq385d60o3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	davvid <davvid@gmail.com>, sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 08:38:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVEjo-0005Uu-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 08:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbbCJHh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 03:37:56 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:45260 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbCJHhz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 03:37:55 -0400
Received: by lamq1 with SMTP id q1so12273179lam.12
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 00:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vV0/sY6zFhxLRbuzPxvBuceYu97BST4rEhXs4lhvdUM=;
        b=KTtkmp1M8VBqJuE3TEcurn/5Q6sFg77jsuPX6SzfMObQ/dt+Ua0xPvpoepXUD0bzCG
         JxswzjHL7Ze64hm8txAmJjUFBDtFPaCP0HwXLP+8kkW6Chkf4/jpvxb4du+OWoDHe2z/
         ioCrQQ+VuBYZAbJJqBfdaxhOK0TKKfqtEq+4m/Jn1g62ekWOvQhMwbZoYfgpH1VcuSuY
         DqMa7kPDcZd4uIejo6DHVZp6z0sLQePWYFYp8opApObIHHLELZz5VafLi4pOBGQdGgvR
         YsHq3hGeZ84AjMIFwWqQ2xPiFAqhVhKFFbIUThAtxqTmLfL/x/98jf4aEFQ1ASGoTVLl
         R+LQ==
X-Received: by 10.152.23.233 with SMTP id p9mr29376754laf.123.1425973073575;
 Tue, 10 Mar 2015 00:37:53 -0700 (PDT)
Received: by 10.152.43.138 with HTTP; Tue, 10 Mar 2015 00:37:31 -0700 (PDT)
In-Reply-To: <xmqq385d60o3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265214>

Hi,

On Tue, Mar 10, 2015 at 8:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:
>
>> "-" now means the previous branch.
>>
>> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
>> Thanks-to: Eric Sunshine, Junio C Hamano, Matthieu Moy
>> ---
>
>
> These look unusual for a few reasons: your S-o-b should be at the
> end, we usually say Helped-by: instead, and we do not use these with
> multiple names on a single line.
>
> Please do not try to be original without a good reason.  We may
> start counting the number of times people appear on these footers to
> see how much contribution those who do not directly author commits
> (read: those who mentor others) are making.

Thank you for telling me this. I will it keep it in mind from next
time onwards.

>
>>  builtin/reset.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> The comment I gave in the thread that ends at $gmane/265112 would
> apply equally to this patch, I think.
>
> cf. http://thread.gmane.org/gmane.comp.version-control.git/264986/focus=265112
I have rectified this in my new patch and will send it soon.
Kindly do let me know if there are any other changes required.

Thank you.
Regards,
Sudhanshu
