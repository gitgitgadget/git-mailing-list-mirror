From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 0/3] Make httpd tests run
Date: Thu, 9 Apr 2015 06:14:49 -0700
Message-ID: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
References: <cover.1428505184.git.git@drmicha.warpmail.net> <3997B1B0-98C0-4408-B82E-85BBD78732FD@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 15:15:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgCIR-0007gq-9F
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 15:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbbDINOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 09:14:53 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34374 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbbDINOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 09:14:53 -0400
Received: by pacyx8 with SMTP id yx8so149270769pac.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2015 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=hd/zYEiYsokbNrI+8bNs0VvISki1iPZ+sZ1f4w4b4Rw=;
        b=kGQCf7J41QmfkvcURmgxd+LasvdyPynWchytrFat/zX246+M3VvLm6QlDrigY5NfsN
         Nh2yt7IUxl/AfI9+NPTSILkbgSaG5Qdn+QGUNy33tQBHTjmrj1IS7QaGvto4pD265e1T
         MPpUy82vpYj1XLS4a/jBg53moGDz4yTFwCmAZFu4Iw0SXZ4aZDnHWkq2dMpmQk1fIdHU
         iuu6Ay2TxuUztxZrA25zodAFNc5I47QlKuoyD+uS8sYJk22FhkGBOLMPgLn8tl/Acj/N
         HpP11XWon9RoZuzvNSc+2D208gBR6Z6B9oa7yUIJ/livcbjCgQXLx9MGpOP0BqrGqYKy
         WuWA==
X-Received: by 10.68.88.196 with SMTP id bi4mr55961575pbb.130.1428585292631;
        Thu, 09 Apr 2015 06:14:52 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id xm7sm14761736pac.28.2015.04.09.06.14.51
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Apr 2015 06:14:52 -0700 (PDT)
In-Reply-To: <3997B1B0-98C0-4408-B82E-85BBD78732FD@gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266993>

On Apr 9, 2015, at 06:04, Kyle J. McKay wrote:

> On Apr 8, 2015, at 08:05, Michael J Gruber wrote:
>
>> This series grew from an attempt at enlarging my personal test run  
>> coverage
>> on a standard Fedora 21 64bit box. Aka chain-lint fall-out.
>>
>> With 1/3, I get all httpd tests to run (when port is set, of course).
>>
>> 2/3 and 3/3 are an attempt at getting git-svn over http tests to run.
>> 2/3 is certainly correct but not sufficient.
>> 3/3 gets httpd to run but svn does not connect. This is WIP and RFH,
>> and maybe requires rewriting lib-git-svn to use a config which  
>> depends
>> on the apache version (like lib-hhtpd does), or to leverage lib- 
>> httpd.
>>
>> Michael J Gruber (3):
>> t/lib-httpd: load mod_unixd
>> t/lib-git-svn: check same httpd module dirs as lib-httpd
>> t/lib-git-svn: adjust config to apache 2.4
>
> The changes in this series appear to break compatibility with Apache  
> 2.2.
>
> Does that mean that Apache 2.2 is no longer supported for running  
> these tests?
>
> Or am I missing something here...

Never mind.  I see the <IfVersion...> they're wrapped in now.  Would  
have been nice if they were indented so there was a hint about that in  
the diff, or the diff included enough context to see that.  But that  
file formatting has nothing to do with your change.

Sorry for the noise.

-Kyle
