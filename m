From: Luke Lu <git@vicaya.com>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 03:03:46 -0700
Message-ID: <A73C6BE2-F990-4634-B996-02CB9B129155@vicaya.com>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 17 12:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii5lQ-0001zE-S7
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 12:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420AbXJQKEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 06:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbXJQKEW
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 06:04:22 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:61908 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293AbXJQKEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 06:04:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1694802rvb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=LSXZh5OJaa9c5pCVqdiC+I3gdW/W11X2qEjF5omh6L0=;
        b=l6u1ZkdSimgkx43C7L4yBBqB6VVIjvG24CgFPZcUyeMRnlY3WHJYjqwvC7gDRwr8RsgLx1L0UNOtfB/ZR1jKjlswpnHhyFJTA/SO3Z8RUdCGb3Q92lCwvFmEgEXVHO9tT4y7aPoHmMa6s+KBLBYEQ5ch8mQx3FsoD829Cv4gkIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=a9Fu6IYv1clZQuln9NHMVzUWVllXsnGS45nNrnZqVC+i9gSfhCpQFA+CMxIMzWsLFwqY0OaKavpaVXN8EdYmw/SdAV0GXpbXWfFo9fQ5OGNZMR+goBCJ3QhGDDJXx7FXkxWPBLM+4kdNg9E1YTd21F1Yytj3hEYFb33leimj7yc=
Received: by 10.141.185.3 with SMTP id m3mr4054718rvp.1192615460908;
        Wed, 17 Oct 2007 03:04:20 -0700 (PDT)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id b39sm8458091rvf.2007.10.17.03.04.16
        (version=SSLv3 cipher=OTHER);
        Wed, 17 Oct 2007 03:04:17 -0700 (PDT)
In-Reply-To: <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61361>


On Oct 17, 2007, at 2:09 AM, Michael Witten wrote:
>
> On 17 Oct 2007, at 3:17:08 AM, Luke Lu wrote:
>
>> But I still haven't seen any compelling arguments against the "all  
>> space" case
>
> Overhead!
>
> If you use 8 spaces instead of one tab,
> that's using up 7x more space!
>
> Consider:
>
>     # calculates the extra space required to
>     # use the given number of spaces/tab.
>     size()
>     {
>         count=`grep -RIo "\`printf \"\t\"\`" . | wc -l`;
>         perl -e "print $count*$(($1-1))/1024/1024 . \" MB\n\"";
>     }
>
>     Then in in a git working tree:
>
>         size 8; # 1.28701210021973 MB
>         size 4; # 0.551576614379883 MB

First, the overhead is not a simple x4 or x8 conversion in size, but  
it's the upper bound. Given that, let's look at the percentage of the  
overhead: my git working tree is 56MB after gc, so the overhead is  
2.3% max for size 8 and 0.98% for size 4. That's not significant at all.

>
>     In a linux kernel working tree:
>
>         size 8; # 61.4902725219727 MB
>         size 4; # 26.3529739379883 MB
>
> Conclusion:
>
>     Yikes!

Now, compile the kernel, do a du in the tree and report back  
percentages of the overhead.

Disk is cheap (1GB costs less than half a dollar), people's  
productivity/time is not. The overhead argument is compelling, not!

__Luke
  
