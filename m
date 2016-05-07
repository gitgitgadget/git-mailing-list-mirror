From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH] t: fix duplicate words of "output"
Date: Fri, 6 May 2016 17:15:52 -0700
Message-ID: <d20429f9-993a-b348-3bbd-0577fbf4688d@gmail.com>
References: <1462537363-17962-1-git-send-email-lip@dtdream.com>
 <xmqqshxv3xno.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Li Peng <lip@dtdream.com>
X-From: git-owner@vger.kernel.org Sat May 07 02:15:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aypu5-0007Ke-7e
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 02:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773AbcEGAPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 20:15:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36368 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbcEGAPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 20:15:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id p185so13377489pfb.3
        for <git@vger.kernel.org>; Fri, 06 May 2016 17:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=5XFUUnaJuP6GmOoJf02qHLRgqFElS3h95FFEctXfH5o=;
        b=cM7cMAWuwEo7HDS31gj4g1IZP+vcce+j3VEB5CM53rZdIu15Nsd01JXMVkupUweYlj
         VDPZxAAlkFWDUtkhj/fNsbt/SZROSOIJxxQx9yQquO+1rV/lFILdo5mCERNGvelcyfnl
         /zTQv7WW01xiS5hkNGMfi/qNlKhPvgW2R6SzapYkgbZvFhyplEDsaDj/ZWV+EI9gW/O4
         g/PHsc9odeMhiFZ4evxpXn9jWzfDTrlCUKrFevtXnk8g2Z4dZAv5ZGdfbDrnJzEpvdmi
         GlRPSMLhQ9OevD8NWBJaTqVjyzZ5pFp8Zr0ILtrbeXYTUyVpTyWFueX3Wywp8QSQ8ChG
         3y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5XFUUnaJuP6GmOoJf02qHLRgqFElS3h95FFEctXfH5o=;
        b=k2g2L1N3YukjrreTWrayciKcBCVF80ZOKsTTn+X5sZzU0e9tzBy89w3sNvobcvJlM8
         gbmmId4yZjbec5zfPcxFgJ7iidRt8f7Egnc1mmD0PBSUTyEjfknKErHYMBjw0eAp3qDf
         csNjQL7e5XM5u2FvW9o/Ww9flqEYhi6RP+iwTqtl5DPHXA7r75hb4Zm/o7+x9UK5g3vG
         pQBmiHPRpWavOi2Xv3kPR4Lnk/fJZ6Oyme7xaGyBz2JfideczdyMNyxfwvNiaGvJkwln
         MlJ997MWbhe2OUh//CCyzQd10N2D36i4b/J1lTDj9ZtlAZqazCjbVvLhBSkZeANYUWQ1
         Fg1Q==
X-Gm-Message-State: AOPr4FXIHDIEr6rTRaLtu/ub+/o6pTTFRkyJdAV3paraZkxbsFns+6ce7LROhe3uOelSqw==
X-Received: by 10.98.109.198 with SMTP id i189mr32336555pfc.106.1462580124188;
        Fri, 06 May 2016 17:15:24 -0700 (PDT)
Received: from [10.0.0.2] (c-50-156-82-222.hsd1.ca.comcast.net. [50.156.82.222])
        by smtp.gmail.com with ESMTPSA id 133sm23553297pfw.35.2016.05.06.17.15.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2016 17:15:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1
In-Reply-To: <xmqqshxv3xno.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293871>

On 5/6/2016 10:26 AM, Junio C Hamano wrote:
> Li Peng <lip@dtdream.com> writes:
>
>> Fix duplicate words of "output" in comment.
>>
>> Signed-off-by: Li Peng <lip@dtdream.com>
>> ---
>>  t/t0000-basic.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index 79b9074..60811a3 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -98,7 +98,7 @@ check_sub_test_lib_test () {
>>  }
>>  
>>  check_sub_test_lib_test_err () {
>> -	name="$1" # stdin is the expected output output from the test
>> +	name="$1" # stdin is the expected output from the test
> The original is marginally correct.  The first "output" is a noun,
> "expected output", the second one is a pp of verb "to output",
> i.e. "to produce".
>
> I would have written it as "the expected output produced by the
> test", though.

Right, the original form is quite hard to understand %)
