From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git commit behaving strangely
Date: Thu, 22 Jul 2010 11:28:55 -0500
Message-ID: <20100722162855.GA2206@burratino>
References: <4C465B34.2040407@zqureshi.in>
 <20100721030608.GA25992@burratino>
 <AANLkTikYoNEQpotpfdVci4WSUc1GMNnM9y0OqXJb7Fzu@mail.gmail.com>
 <20100721050558.GA15273@burratino>
 <AANLkTimbeDz_9PPOXBg2FU05Mnba2an-BkK99ye1glDL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zeeshan Qureshi <zeeshan@zqureshi.in>
X-From: git-owner@vger.kernel.org Thu Jul 22 18:30:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obyen-00024F-N3
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 18:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab0GVQ35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 12:29:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35551 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0GVQ34 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 12:29:56 -0400
Received: by pvc7 with SMTP id 7so3102707pvc.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6su+gGtc4fHdzSec9IGFhuYRhDe9zMhAU00EJ6la1FY=;
        b=EGr6g9ZYTprrLwaKqz8t/aqxonuclrvSkGsw6AXptS0zaTKszEZhIyQ6SpqkLVXQHv
         3Pzgu0uUO/fSJ+6CGGyUrgGpojF1wcHZFDVEmw7f9Ju9Beal3aaZGC6P98IJ7FYC/4QV
         CslAfOtYitRNOaej5VQnFHC84XMK6a7o5/LcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tRsFyFl2zXGND77VOH6aCxuQL2EcwmlB9/k50h0xKnoWQyhAJR+OqB6ZFIxh7gvAG6
         0YMn55wdbgLnQSBKK8oSkKe/+rne1Pvj3RqQP05Vaw1pgZV2oCwynl/CKzWfozIa6iEF
         cJd1CoZd1hR/Z+AIgm7pU8wmxBI6PveYrImEw=
Received: by 10.142.233.10 with SMTP id f10mr2578301wfh.215.1279816195826;
        Thu, 22 Jul 2010 09:29:55 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g33sm30635069qcq.16.2010.07.22.09.29.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 09:29:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimbeDz_9PPOXBg2FU05Mnba2an-BkK99ye1glDL@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151459>

Zeeshan Qureshi wrote:
>>>> Zeeshan Qureshi wrote:

>>>>> 3. then i added 1 new line to both closing.txt and file.txt
>>>>> 4. i added the file closing.txt to the staging are by running 'git
>>>>> add closing.txt'
>>>>> 5. now i ran 'git checkout' (by mistake)
[...]
>>>>> 7. Now when i run 'git commit -m "closing again"', the change is not
>>>>> committed even though i get a new commit id.
>>>>> 
>>>>> The output of 'git log -p' is this (as you can clearly see, there
>>>>> are new commits but no change has been recorded)
[...]
> I did the test again on the Solaris machine, and encountered the same problem.
> 
> I am on a Sun Blade 1500 machine running Solaris 10.

Since this seems to be hard to replicate without blastwave, I would suggest
reporting it through the blastwave forum.

Thanks, and good luck.
