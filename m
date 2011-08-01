From: Jon Forrest <nobozo@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Mon, 01 Aug 2011 07:32:04 -0700
Message-ID: <4E36B8E4.5080900@gmail.com>
References: <4E362F8E.1050105@gmail.com> <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Aug 01 16:32:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QntXr-0001kO-GK
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 16:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab1HAOcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 10:32:35 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36905 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab1HAOce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 10:32:34 -0400
Received: by pzk37 with SMTP id 37so11597933pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=93x81XURNrety6El/uNAQ6X6BDmoMpxOPBrHbVS9oPc=;
        b=LyJ87q/AEDVoxSLSywR/Rg22QO5Fq1h1VEopTFox5E9UpjNlQodJ1IHmztCU7zbtuo
         J+rnViHqFHLjCWc4XZrXTj3bcoGSKXZQAXVl1zruRq+BJQK+zj2sVXW1l14K6IMLtaxA
         GA8RxX9Y6ecRPki2TU1Ku3JS15w+OJ//G9I28=
Received: by 10.68.30.2 with SMTP id o2mr8472809pbh.414.1312209153664;
        Mon, 01 Aug 2011 07:32:33 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-150.hsd1.ca.comcast.net [98.248.228.150])
        by mx.google.com with ESMTPS id b4sm3793130pba.27.2011.08.01.07.32.32
        (version=SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 07:32:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178345>

On 8/1/2011 2:58 AM, Sverre Rabbelier wrote:
> Heya,
>
> On Mon, Aug 1, 2011 at 06:46, Jon Forrest<nobozo@gmail.com>  wrote:
>>         fprintf(options->file, "%s", line_prefix);
>>         fprintf(options->file,
>> -              " %d files changed, %d insertions(+), %d deletions(-)\n",
>> -              total_files, adds, dels);
>> +              " %d file%s changed, %d insertion%s(+), %d deletion%s(-)\n",
>> +              total_files, total_files == 1 ? "" : "s", adds, adds == 1 ?
>> "" : "s", dels,
>> +               dels == 1 ? "" : "s");
>>   }
>
> Also, this is rather detrimental to the i18n effort methinks?

If the goal if the i18n effort is also to produce grammatically
correct output in all the supported languages then the
tests that my patch would break would have to be rewritten
anyway.

Jon
