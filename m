From: Justin Mattock <justinmattock@gmail.com>
Subject: Re: gitk with the latest branch makes the system unusable for some time
Date: Thu, 24 Feb 2011 10:20:12 -0800
Message-ID: <C89C2D5B-9DD7-42FD-8CB5-E33EDC919DEE@gmail.com>
References: <AANLkTim3MW0PmD5_tra4nmRapfgHJ9K_usJWGVK3AOUC@mail.gmail.com> <20110224164551.GD888@home.goodmis.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
X-From: linux-kernel-owner@vger.kernel.org Thu Feb 24 19:20:26 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Psfnd-0004jP-Kj
	for glk-linux-kernel-3@lo.gmane.org; Thu, 24 Feb 2011 19:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab1BXSUU (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 24 Feb 2011 13:20:20 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:59774 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab1BXSUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2011 13:20:14 -0500
Received: by pxi15 with SMTP id 15so126416pxi.19
        for <multiple recipients>; Thu, 24 Feb 2011 10:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=S7c1auyzutDJHZtB+NhEYrgS97GlIbZpD5C636qiTX0=;
        b=fM2uKcKlGTIV8x98d+rS7axFOLEx04G/Y/sh9vom4rXkHFpKcvcJr0pXIj8YW69SR0
         aEeuNUh8HN0ht17eDmx99ssidRQr+dz07B9t62LExEfQ7dzu3bEWt9FhiEsLhv1vlMRI
         zmNqDKj3Gsi4uKZoRZuFJWecFH8QcDx5tQaWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=raRhcMQAfzlIJp0+rpyWaKswnwkmdA7gJmqZP+fuyXs8fqk+4J9/isrllPypEPjzze
         opmFlnshdzfxr3KgzBBIoRo8WZfTQ9wTS4vYQhZtmgvQnuTItyXqNkCPr6hYmReI0bsC
         RVzGo8ColriAUI4lpyFi96R8fx2yonyjQNXYs=
Received: by 10.142.239.14 with SMTP id m14mr922114wfh.12.1298571614063;
        Thu, 24 Feb 2011 10:20:14 -0800 (PST)
Received: from [172.29.71.32] (cpe-76-94-2-152.socal.res.rr.com [76.94.2.152])
        by mx.google.com with ESMTPS id s41sm7945119wfc.3.2011.02.24.10.20.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 10:20:12 -0800 (PST)
In-Reply-To: <20110224164551.GD888@home.goodmis.org>
X-Mailer: Apple Mail (2.936)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167844>


On Feb 24, 2011, at 8:45 AM, Steven Rostedt wrote:

> Hi Justin,
>
> On Tue, Feb 22, 2011 at 03:53:08PM -0800, Justin Mattock wrote:
>> not sure if there is any reports of this or not, basically using gitk
>> on my macbookpro2,2 makes the system extremely slow and unusable
>> (after a while can finally use the system)
>>
>> in dmesg I am seeing this:
>>
>
>
>> [ 6089.367430] [ 2593]  1000  2593    26616        1   1       0
>>      0 bash
>> [ 6089.367435] [ 2717]  1000  2717   326078   204267   0       0
>>      0 wish
>> [ 6089.367439] [ 2729]  1000  2729   141207     7349   0       0
>>      0 git
>> [ 6089.367444] Out of memory: Kill process 2717 (wish) score 802 or
>> sacrifice child
>
> Looks like a memory leak in gitk and nothing to do with the kernel. I
> would take this up with them.
>
> -- Steve
>


cool... I haven't had a chance yet to upgrade git(external things in  
life)
but once I get to it I will, and see.

Thanks

Justin P. Mattock
