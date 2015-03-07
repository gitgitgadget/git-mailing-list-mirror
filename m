From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4] git: treat "-C <treat>" as a no-op when <path> is
 empty
Date: Sat, 07 Mar 2015 16:19:59 +0530
Message-ID: <54FAD7D7.4030008@gmail.com>
References: <1425640688-26513-1-git-send-email-karthik.188@gmail.com> <CAPig+cTkC1Y1sWJLpG0iUHju3GOMnvOT-nsAU51GykeV2QB+vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 11:50:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUCJA-0002ip-E0
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 11:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbbCGKuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 05:50:05 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33059 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751607AbbCGKuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 05:50:03 -0500
Received: by pdev10 with SMTP id v10so35281366pde.0
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OBDkkZr+5p2TRGC2XCvNXYoxgT1/xq2MTaLfHqaOszY=;
        b=gsve1VqXsxqKrlraZF7k0Bwcb0nSoYrC8ZgxIZ1Q8Zn0/p9i4vf4sc4G4tAlAsfq7n
         kl0ZuJ4igxKWrhro6tJa9YvSv7O9bS0mxCyEUWFkzTdxx6g+DpoRuB7OFd0XaRhjCov3
         dUW+OHEJuvSILLgRyNw/LwYcDP2UH1zzNdjWV6ay/gJsoyCzHGvhz+bvN+DYXdYxYCoJ
         yN4KVgdnaglVDyXAeB12srg6kEw9gSVR9iLi0LyW+z3dobWf+5I/Gc9eHVe4fbihdQsc
         oLEjs5L+x5Xq1roUtfQaT416pfeNElx/vANm9pwC16u86JkB0upRVpqtLwYwVdRdkTw5
         XmxA==
X-Received: by 10.66.66.238 with SMTP id i14mr33550387pat.27.1425725403202;
        Sat, 07 Mar 2015 02:50:03 -0800 (PST)
Received: from [192.168.0.102] ([103.227.98.178])
        by mx.google.com with ESMTPSA id c9sm12036987pdo.13.2015.03.07.02.50.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 02:50:02 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cTkC1Y1sWJLpG0iUHju3GOMnvOT-nsAU51GykeV2QB+vA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264995>


 > This iteration looks sensible, except that the Subject reads
 > strange.  Will queue with minor tweaks to the log message,
 > and perhaps with a fix to unreadable *(*argv)[1] that was
 > mentioned elsewhere.
 >
 > Thanks.

Hey could you tell me what seems strange, so I can improve on
it the next time.
Also "*(*argv)[1]" seems more readable to me, maybe more of a perspective?

Thanks


On 03/07/2015 07:49 AM, Eric Sunshine wrote:
> On Fri, Mar 6, 2015 at 6:18 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> 'git -C ""' unhelpfully dies with error "Cannot change to ''",
>> whereas the shell treats `cd ""' as a no-op. Taking the shell's
>> behavior as a precedent, teach git to treat `-C ""' as a no-op, as
>> well.
>>
>> Test to check the no-op behaviour of "-C <path>" when <path> is
>> empty, written by Junio C Hamano.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Eric Sunchine <sunshine@sunshineco.com>
>
> s/Sunchine/Sunshine/
>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

Sorry Eric for the genuine mistake.
