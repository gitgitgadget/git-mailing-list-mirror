From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH v10 0/2] introduce --[no-]autostash command line flag
Date: Fri, 25 Mar 2016 23:31:39 +0530
Message-ID: <CA+DCAeT0PW6oCjO5QxcL+nJYneLUGgvieki9_44HQJK4bDHaUQ@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cTqnev_YpamaSi1tkvWydZHRadBzo_zLnF1Pd6FyWKiTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:01:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajW3P-00020V-9t
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbcCYSBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:01:43 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36482 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbcCYSBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:01:42 -0400
Received: by mail-qk0-f171.google.com with SMTP id s68so35593806qkh.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=I/wfiwXZZj+4k1jcCNUlmm0Oo4/RsAM/fBqsvVAs2jc=;
        b=URP/NNbbTRsF3UfZpAessfRdkwMaMY+TS+hQPX2OE4syEwyyuzYgK0pslvbUBUdlXl
         5uoozxqzs2FeKcPsnPyFf7tWJ6ggJYkmefnS4UAXrUAf0aBIW1CEguvedZUqBVOw6Wd6
         QUEHS4yjOq5PI4AmDJzvinuN0ofDzDwkziJ2XQsEMGAZEQJKdRWUx2wETAn+vDeXJIh8
         zRJYCs5TyXixExhvcQjVRd4TKFfi7rSYFLSbHLL374Qd/GYQSUVz1fk48eH+d52h+/+b
         YOCmPGyWqpx9RWAAhixFHLGapqnVKX1kB1qUrpBjAGmUioPOY/iRNe9WXVtn93dXmpxg
         u1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=I/wfiwXZZj+4k1jcCNUlmm0Oo4/RsAM/fBqsvVAs2jc=;
        b=VJXKr4qab4dPqcHjgJSwTFAr87h2cGTOFe/Yu0ICRJRtNfG6E2Et9ay2MH3uVvh4JJ
         X7G8dMw93GJl7Gajas6XenyV6nd205tKdzDD+Fo929y4tgrdvLORWmP5ffzQNINB9p65
         Xky3RrrEWo17UOYZLkVt24aPfkOHe/gYSDh0gcFwbo2qIW0D98Hk6AD05it1EGl1hlA6
         wnvZi/mSv0J6sAsd/A36VWe73aUE5NpqvPlvVZJwuCzjVxbkGVPVjhY7yeGxgpXjLnvo
         PKOZzp/cigEAsjXdQ/F0VUd2rvxmNNhAard5IMXCxI9VE2yboCRxUy4Jv8Ojfh/ayaBV
         AvgA==
X-Gm-Message-State: AD7BkJICCpwertLlMaGm4JA+Gb//lFlbnOgc8N83ReW/4PnnmIklonHgLilVxQjyevhTrdYf/SyBHywyx60Vbw==
X-Received: by 10.55.76.208 with SMTP id z199mr18626104qka.88.1458928899246;
 Fri, 25 Mar 2016 11:01:39 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Fri, 25 Mar 2016 11:01:39 -0700 (PDT)
In-Reply-To: <CAPig+cTqnev_YpamaSi1tkvWydZHRadBzo_zLnF1Pd6FyWKiTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289922>

On Fri, Mar 25, 2016 at 12:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Mar 21, 2016 at 2:18 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
>> Changes introduced w.r.t. previous patch:
>> [...]
>> * Two more tests are added to checkout for error when "git pull
>>   --[no-]autostash" is called. Here I'm forced to use "test_i18ncmp"
>>   instead of "test_i18ngrep" to compare the expected error message with
>>   the actual because grep was, unfortunately, reading "--[no-]autostash"
>>   as an option and thus leading to test failure.
>
> Pass -e to grep to treat the next argument as an expression (even if
> it happens to look like an option):
>
>     test_i18ngrep -e "--[no-]-autostash ..."
>
> You may also need to escape the [ and ] with backslash (\) to force
> grep to treat them as literal characters rather than as the character
> set "[no-]". Alternately, rather than escaping, also pass the -F flag
> to make it treat all characters as literals.

Thanks for this. I tried it out

    test_i18ngrep -F -e "--[no-]autostash ..." err

and worked fine.

Thanks,
Mehul
