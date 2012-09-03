From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Mon, 3 Sep 2012 16:40:22 -0400
Message-ID: <CAFuPQ1LrousHH9uK7zSeVvNrYwBBBpZwbM-fwgM_iDwWuqTMXg@mail.gmail.com>
References: <504272F0.3070701@web.de> <4eab55d2-b504-4c66-84be-c1ffe4edf94c@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Mon Sep 03 22:41:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8dS5-0001d0-P6
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921Ab2ICUkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 16:40:45 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47159 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab2ICUko (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 16:40:44 -0400
Received: by qcro28 with SMTP id o28so3589784qcr.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 13:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=eyv5aiCvmdmeqwyhnc7mm+vr5Zecb73K4ex8XiSb3l4=;
        b=TqsjZM5dWdEuqULLpeAMABcFAXrGdYj4JJ/hq0urnTqtJpMd8dyArJKt2muEvSYPlm
         7UfRKVDzKgRkNHZPjZ3Cj9WYlU/MoUsTAL8E7FquxFEwDGPYmpuZbKtb+KrByMCOSQPn
         /DGSKnAy5aIQIMfIld1VFRp84aIeEjCEvpa06XuW3x9bSaDziM5Loj5cgy9FzqX735Lx
         dcnGlzwLSzoFktnx83xMd4mL4PkY1B6+3siLrBl2pceHve5QEuaMHL3SSMex7mAzHLSx
         a+FaKfk0EQLzZ99vEw7JcxZnCpxOkmnpSQEc8uqO4Z7GCZFM8ijOjPBFf6Dhv1VCDocJ
         HRjg==
Received: by 10.229.136.74 with SMTP id q10mr10063460qct.148.1346704843550;
 Mon, 03 Sep 2012 13:40:43 -0700 (PDT)
Received: by 10.49.82.75 with HTTP; Mon, 3 Sep 2012 13:40:22 -0700 (PDT)
In-Reply-To: <4eab55d2-b504-4c66-84be-c1ffe4edf94c@zcs>
X-Google-Sender-Auth: y18UvrfUG9A5LxXWeEleSElW8f0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204712>

On Sun, Sep 2, 2012 at 5:07 PM, Enrico Weigelt <enrico.weigelt@vnc.biz> wrote:
> Hi,
>
>> Would that help ?
>> git help diff
>> [snip]
>>      --ignore-space-at-eol
>>            Ignore changes in whitespace at EOL.
>>
>>        -b, --ignore-space-change
>>            Ignore changes in amount of whitespace. This ignores
>>            whitespace at
>>            line end, and considers all other sequences of one or more
>>            whitespace characters to be equivalent.
>>
>>        -w, --ignore-all-space
>>            Ignore whitespace when comparing lines. This ignores
>>            differences
>>            even if one line has whitespace where the other line has
>>            none.
>
> Now I yet need to find out how to configure tig for it.

Try: echo "set ignore-space = all" >> ~/.tigrc
And use 'W' to toggle between the different modes.

-- 
Jonas Fonseca
