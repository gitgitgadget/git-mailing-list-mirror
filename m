From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: import the ctypes module
Date: Wed, 21 Oct 2015 00:00:44 +0100
Message-ID: <5626C79C.8060503@diamand.org>
References: <CAJA=mv5Kdsn1YEo4sUAwpTv=0Jc8Xg5V2WPMoCmsxNL4Hnk=kg@mail.gmail.com>	<CAE5ih793+YDd30rpMSyTHjUNZS+-BLY9D-kJkF9RAogjdctPFw@mail.gmail.com>	<xmqqy4ex8r8k.fsf@gitster.mtv.corp.google.com>	<1445369506.8543.10.camel@kaarsemaker.net> <xmqqwpuh72ot.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Etienne Girard <etienne.g.girard@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 01:01:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoftt-0001Ns-CS
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 01:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbbJTXA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 19:00:57 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35643 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbJTXA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 19:00:56 -0400
Received: by wicll6 with SMTP id ll6so66695261wic.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8GEfuNVTYiv2f4gMlucqaoBqkYRz7HejacCLaM2XZos=;
        b=WqaPedA6Q54w2qNfbxHzrPRw8AJJ9PUfkarZfOYk1r9DedoY0YQyx0hFB5xh5NaEo6
         bCFMVPR7g11ufvk+T+To7QXjheVhnybOJyPabmN0EPFm4SUlxoIhZRnmqVKUVMlnTYjP
         Ill+1bf9ZcjPIcA4pPFSkqzS+HMTV3sMunD1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8GEfuNVTYiv2f4gMlucqaoBqkYRz7HejacCLaM2XZos=;
        b=R6UwItHNgOItUeQ9clzDvDlIXcutI3zM8pKaLf/FE7HXCZY4Hsb4QS8K0vOdc9vgJ7
         nbLmFnZ3jg40i1jzAFWbgR6ReDWtsNjUvNgBmkAfQQHqgPzVcbucg9CQulm1ZRIJFd3I
         m+pYdFtvGCQM19261GJLKaKu6dMNWl/p0Ia3jp0uxhRkhkGiwO6sqm61BBttrsGM0F3y
         cMJ39cbQbQzx7HJotN9pD501TFlxhSS5UYPCwLnNRMucVlDant98WpnOLj28okXD3OXM
         Tne+3Jo/pnMAIc5Bzanx+9aeELsW5CczhasKJIpshJFejkzIB24LgNfsiPdbPg5uXGC8
         cn1w==
X-Gm-Message-State: ALoCoQkUSFbr4jYhMgEMktxA+VjCWU3m1jzG9lo4TmV9GlNuSBXJEVc486P5hyecCW6plyHB0OzH
X-Received: by 10.180.12.241 with SMTP id b17mr7732130wic.55.1445382055064;
        Tue, 20 Oct 2015 16:00:55 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id ee5sm6517183wjd.17.2015.10.20.16.00.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Oct 2015 16:00:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqwpuh72ot.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279956>

On 20/10/15 20:36, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>
>>> I do not follow Python development, but does the above mean that
>>> with recent 2.x you can say ctypes without first saying "import
>>> ctypes"?  It feels somewhat non-pythonesque that identifiers like
>>> this is given to you without you asking with an explicit 'import',
>>> so I am puzzled.
>>
>> No, you cannot do that. The reason others may not have noticed this bug is that
>> in git-p4.py, ctypes is only used on windows.
>>
>>   111     if platform.system() == 'Windows':
>>   112         free_bytes = ctypes.c_ulonglong(0)
>>   113         ctypes.windll.kernel32.GetDiskFreeSpaceExW(ctypes.c_wchar_p(os.getcwd()), None, None, ctypes.pointer(free_bytes))
>>
>> The fact that it works for the OP with 2.7.10 is puzzling (assuming that it's
>> on the same system).
>
> Exactly.  That is where my "I am puzzled" comes from.
>
> The patch looks obviously the right thing to do.  Luke?  Lars?

It looks sensible to me, and works fine on Linux, thanks. ack.

I can't test on Windows today but I can't see why it wouldn't work.

Luke
