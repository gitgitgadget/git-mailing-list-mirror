From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git mac 10.7.x
Date: Fri, 20 Feb 2015 14:54:14 -0800
Message-ID: <004039F7-C541-429F-B15C-13865427834E@gmail.com>
References: <24CFF4AD-D1EE-40EA-A5F1-9109F29800BE@gmail.com> <1768B135-0FC3-49FE-AD9A-D33E39F822B6@gmail.com> <0596CAEE-2F31-4D61-A3A8-9C8AF2A287C6@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sojourner <sojournerh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 23:54:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOwSk-0008KP-PF
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 23:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbbBTWyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 17:54:18 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35383 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbBTWyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 17:54:17 -0500
Received: by pdbfl12 with SMTP id fl12so10772669pdb.2
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 14:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=t2v3M1w1M+9YEoAXWZtC11Nx5bYWifpAYoTskOcoUs4=;
        b=jOypr2RH9FKAVqHlU1imjg2VmeqAWUrZbHlWDHG5626M305BcdTyo1YFGxlqobnyng
         9ROoEG2k1p2IVg+fR8rI0YIPfMQ3HCRuT4RwlfEVgT4PC3/P3mVvpwuR8YeKjGWjLQyw
         pU4cwyCVFn1Tqmefr7FzL0s30U23I8GfwiBNoTG/gd5KvyBRy4QofRc7XXY3FHvYFYQA
         wHRZjrYbN/RCiORgNcdxg0BoK+PNdxzM+VZi6ywBTkOdy54BNhT/heH+iBQ+DjX2/Qbi
         W1Lf4kafJNH8n1zazY5374AABC8ujN6/vdhtgIwOVYx8H7ATGmLrma4+2jo7M1zp7Rzf
         LgGA==
X-Received: by 10.66.132.6 with SMTP id oq6mr10pab.29.1424472857169;
        Fri, 20 Feb 2015 14:54:17 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qo4sm13518091pdb.71.2015.02.20.14.54.15
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Feb 2015 14:54:16 -0800 (PST)
In-Reply-To: <0596CAEE-2F31-4D61-A3A8-9C8AF2A287C6@gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264192>

On Feb 20, 2015, at 12:01, sojourner wrote:
> What's the difference between this installer and the other one? Why  
> is this installer going to work?

See the website for a description.  It was built to work with 10.4.8  
or later.  It was built using Apple's older GCC specifically to be  
compatible so does not contain any "illegal instructions" that only  
work on 10.8.x or later.  Besides, I've actually run it on the older  
systems without problem so I'm pretty confident you won't have an  
issue with it.

-Kyle

> On 20 Feb 2015, at 13:32, Kyle J. McKay wrote:
>
>> On Feb 20, 2015, at 02:38, sojourner wrote:
>>> Installed Git via installer. Updated path in .bash_profile. Get  
>>> error Illegal instruction: 4 when trying to run Git.
>>>
>>> Built Git from source. Searches for the compiled source  
>>> unsuccessful. Which is nice: there's nothing to uninstall.
>>>
>>> Searching online has a lot of suggestions and ideas. Anybody have  
>>> anything that actually works?--
>>
>> You can get a working installer from <http://mackyle.github.io/git-osx-installer/ 
>> > that should work for you on 10.7.x just fine.
>>
>> -Kyle
>
