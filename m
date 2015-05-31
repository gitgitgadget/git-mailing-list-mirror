From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Sun, 31 May 2015 13:49:24 +0530
Message-ID: <556AC40C.5020205@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-8-git-send-email-karthik.188@gmail.com> <CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:19:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyyT0-0000fb-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 10:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757996AbbEaITa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 04:19:30 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34998 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571AbbEaIT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 04:19:28 -0400
Received: by padjw17 with SMTP id jw17so15828653pad.2
        for <git@vger.kernel.org>; Sun, 31 May 2015 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jq+GUo+S9kdGsTIPYAhgAZwDokGyZxpOeRCtS5xsQHE=;
        b=lH9OAZWwvM/vE8y6JUVChQmG2eAlwXokQEM9g3SHgmU3UkZNxHgCwBAilvfBhJZP2m
         vNNoTS43awiuIKbsvB/NN2FMpIFTljIzYMBCIfvtS6uqFoDMARiU0qLg2g23z7EBGKDz
         LMArAj4DhNKxU5VL43NI3sxwuzzXQzVAdWyX2KVCSNITOhRS2F9dJXwtRtsW/4vz9q2b
         cbe0kP/bf/Tu73vrTYR2vWPn9ISo4wNmPEiHKwMeLppViYw4n9/17dAYDQ4ip2gaD8BU
         dcftq3vZPRPwDuURyS0n3iBTWxa52zq8EAZRimcSzuqDi2I28kmU3plGx61rv79im+xA
         WAKA==
X-Received: by 10.66.101.9 with SMTP id fc9mr29612326pab.37.1433060367861;
        Sun, 31 May 2015 01:19:27 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id fm3sm10685842pdb.28.2015.05.31.01.19.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 01:19:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270322>

On 05/31/2015 09:13 AM, Eric Sunshine wrote:
> On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Create 'ref-filter.h', also add ref-filter to the Makefile.
>> This completes movement of creation of 'ref-filter' from
>> 'for-each-ref'.
>
> It's important that the project can be built successfully and function
> correctly at each stage of a patch series. Unfortunately, the way this
> series is organized, the build breaks after application of patch 7/8
> since for-each-ref.c is trying to access functionality which was moved
> to ref-filter.c, but there is no header at that stage which advertises
> the functionality. Fixing this may be as simple as swapping patches
> 7/8 and 8/8, along with whatever minor adjustments they might need to
> keep them sane. (The alternative would be to combine patches 7/8 and
> 8/8, however, Matthieu didn't seem to favor that approach[1].)
>
> Overall, this round has been a more pleasant read than previous rounds.
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/270192
>

That is kind of a problem, If I need to swap those commits also, I'd 
have to add the part where ref-filter is added to the Makefile with the 
code movement from for-each-ref to ref-filter. This again will not just 
be Code movement.

But I guess thats a fair trade-off, will change it. Thanks

-- 
Regards,
Karthik
