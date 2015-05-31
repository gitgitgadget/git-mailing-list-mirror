From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make
 them public
Date: Sun, 31 May 2015 14:47:38 +0530
Message-ID: <556AD1B2.3080502@gmail.com>
References: <5569EF77.4010300@gmail.com>	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>	<CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com> <CAP8UFD1TTMfruCE-+GT-LzhK5C9LorStPbn64tZ-hhAkC=8Bdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 11:17:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyzNL-00068A-MZ
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 11:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757878AbbEaJRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 05:17:44 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33446 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbbEaJRm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 05:17:42 -0400
Received: by pdbqa5 with SMTP id qa5so85925106pdb.0
        for <git@vger.kernel.org>; Sun, 31 May 2015 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Z9aJQEF4frgSfhxMQvlwy1cMH71XA4ibgG/0O2Afyog=;
        b=miXVdlrR0x1YFLPkxhiW65qt5banQ6hpX3g571V/a/JXZqH9nuVhhmuKjBUVs+iQ4g
         d+YxhJl3zTkmdKFoeePDlFrON5ZVnEjkFMMVGJDkMoYwcwH/b/W1stqcHofjhbUZOKKK
         hFtFMGSYDD4/m3zvRtZ3R8uNgS1UtnHdSf/x4W47tVAcJG1vN7jM3x+n6jsVyc/2fxba
         GJTgzCT1echCBQddiMfwXQrzsteyV/0I73HWbsJDp4N/6OHAkhwNSBoc31lQgYYYsqUT
         qsspMe49KY2JdZcYbkyaFTWOT1YJ/Vu1YQnV0XzV3qeAf58xAR7l++1g5xSZ3SXzrMiM
         U37Q==
X-Received: by 10.68.161.99 with SMTP id xr3mr30168398pbb.47.1433063861882;
        Sun, 31 May 2015 02:17:41 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id hk4sm1067760pbb.54.2015.05.31.02.17.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2015 02:17:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAP8UFD1TTMfruCE-+GT-LzhK5C9LorStPbn64tZ-hhAkC=8Bdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270328>

On 05/31/2015 01:41 PM, Christian Couder wrote:
> On Sun, May 31, 2015 at 10:04 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Sat, May 30, 2015 at 7:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>
>>> -static void sort_refs(struct ref_sort *sort, struct ref_array *array)
>>> +void sort_ref_array(struct ref_sort *sort, struct ref_array *array)
>>
>> It is probably better to call the above function ref_array_sort()...
>>
>> [...]
>>
>>> -static struct ref_sort *default_sort(void)
>>> +/*  If no sorting option is given, use refname to sort as default */
>>> +struct ref_sort *ref_default_sort(void)
>>
>> ... especially since you call the above ref_default_sort()...
>>
>>> -static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
>>> +int opt_parse_ref_sort(const struct option *opt, const char *arg, int unset)
>>
>> ... and the above opt_parse_sort().
>
> After saying that I realize that these two other functions are not
> doing the same thing.
> This might suggest that they are not named very well as well.
>

What do you mean by "not doing the same thing."

-- 
Regards,
Karthik
