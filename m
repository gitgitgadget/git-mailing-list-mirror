From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Sun, 31 May 2015 14:46:05 +0530
Message-ID: <556AD155.8010108@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-8-git-send-email-karthik.188@gmail.com> <CAP8UFD0hpUo5iooforU82c2BcFDYSbt7Gqn49qFW+LiwcVQJ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 11:16:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyzLs-0005Ks-Nw
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 11:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730AbbEaJQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 05:16:12 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36427 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbbEaJQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 05:16:09 -0400
Received: by pdjm12 with SMTP id m12so2976961pdj.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VhgGvn2yJeFOFHFN7fiO/W1twMUOHlSUad5aE7dS54g=;
        b=Pa/jJKHV4mNa+YcZN96oPW9n7i9I2t/VMoCbqgMvog+DsetumqdgNpOb2IARLRK1+1
         pkF3eVB7/aYTWdrQoYbWOJYmZG2OVVwSeJj9UjGI5PwuP/WJGuoCWfzFYNI2we7/FxPn
         PyfQ1cQkKBr85VAuOnbpO9z/Nq/w88YLYpoHUvsRRYDs9wE4CXsbATezLKsGeqJJx6qT
         UEdVJoCIz/II4YRV+acSqj03clfISmZJfK1cAWy8AYvvR3uO7ts6BEnI6GNFqrKVDAFK
         KACj+ZHznQE5A0KA8SyBeqqUUH5qbgVnDnqqY/siErnRMAzi2TpIvja0y9qXPqN/bVL+
         2qfg==
X-Received: by 10.68.139.225 with SMTP id rb1mr29855436pbb.68.1433063768977;
        Sun, 31 May 2015 02:16:08 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id eu5sm10782405pbb.44.2015.05.31.02.16.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 02:16:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAP8UFD0hpUo5iooforU82c2BcFDYSbt7Gqn49qFW+LiwcVQJ_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270327>

On 05/31/2015 01:50 PM, Christian Couder wrote:
> On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> -struct ref_sort {
>> -       struct ref_sort *next;
>> -       int atom; /* index into used_atom array */
>
> Where is this used_atom array?
> I searched but couldn't find it in the same file.
>
>> -       unsigned reverse : 1;
>> -};


It has been carried over since 9f613ddd, after which used_atom was 
removed, I will remove that comment, just causes confusion

-- 
Regards,
Karthik
