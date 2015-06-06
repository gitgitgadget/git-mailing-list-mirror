From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v5 0/10] create ref-filter from for-each-ref
Date: Sat, 06 Jun 2015 16:23:27 +0530
Message-ID: <5572D127.6010006@gmail.com>
References: <55729B78.1070207@gmail.com> <CAP8UFD0nv8asRtViTgN6QPtupYF-r7KB=3+FMDtCzh7h+asjmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 12:59:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Bot-0001Cw-BI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 12:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbbFFKxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 06:53:33 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35450 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbbFFKxb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 06:53:31 -0400
Received: by pacyx8 with SMTP id yx8so27920176pac.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 03:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8yuxAFIZD5aJyWSvkUqkXgXjeDzRoyi3suIpZDRLajQ=;
        b=aHURWZgkQaVKTeXvtmVuQUh8I4SQz/GIK3TIWbEk/Wkqn4Gb9TwoDndlw4pASEdvEF
         BfuQr5eI6kUJYzhZHRaX/gMf8w9R4hExJXwPifVp218426xBZ38IUvz1OwobjaYj/bjK
         hcQH0ry/+6X33Za1+owcvgVVgXDZK4SWtwzaWQYEm8pVhOoLh243YMA+EECK9yUhMqae
         DmksL5hruycZS1D/Z9UmH7yyun7aINDoN30IbseC/ewyDRSVezwgvRyYSq1mS70K+Qoo
         22NeSenQ+FfqgzCzhiRFJw5t9iwwYGvGOb0dhbn22yNpLncOmfxDBvxg3iRG2KCoy4Ow
         lW6A==
X-Received: by 10.68.252.38 with SMTP id zp6mr13263794pbc.159.1433588011335;
        Sat, 06 Jun 2015 03:53:31 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id v5sm9314488pdo.29.2015.06.06.03.53.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 03:53:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAP8UFD0nv8asRtViTgN6QPtupYF-r7KB=3+FMDtCzh7h+asjmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270913>

On 06/06/2015 03:10 PM, Christian Couder wrote:
> On Sat, Jun 6, 2015 at 9:04 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > Version for of this patch can be found here :
> > http://www.mail-archive.com/git@vger.kernel.org/msg70280.html
> >
> > Changes in this version:
> > *       Rename functions to better suit the code.
> > *       implement filter_refs()
> > *       use FLEX_ARRAY for refname
> > *       other small changes
>
> Now that the patch series starts to be in a good shape you might want
> to use [PATCH ...] instead of [WIP/PATCH ...].
>
> Thanks,
> Christian.
>
Good point! I should have done that.

-- 
Regards,
Karthik
