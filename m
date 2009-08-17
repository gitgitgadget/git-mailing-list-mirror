From: Joe D'Abbraccio <dajoe13@gmail.com>
Subject: Re: How-to checkin git hook
Date: Mon, 17 Aug 2009 16:46:10 -0400
Message-ID: <4A89C192.1010205@gmail.com>
References: <4A89BA5D.1000608@gmail.com> <81b0412b0908171327l1dd1a36n5e58828d70b18bfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:46:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md960-0002Wo-Q1
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbZHQUqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 16:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbZHQUqP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:46:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:50186 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbZHQUqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 16:46:15 -0400
Received: by wa-out-1112.google.com with SMTP id j5so537270wah.21
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=JZH6heKSPdiK2Np3rcODPat1KlPHtDur3GxJ0EbOcng=;
        b=CkIbfC8XXhv0knqXb/iQuw30hCwyPGMg2P+P7Q2eAp23Fd04KdW+K4ceKyBRlOqYGc
         xYDT1giCDObP6jyvXHCgBaAbZTi5q9zn0ct91EC0swrTBn1YtCz4bGtR6+8lvzYI0EdB
         WNBSyyImkb08Pq5Ak33hcqUCzRddBlmvde7Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=a0XdlzpkgMb0UUdwKt2bLXdTs37fkmKWBNYt0U8f2pRzTtY5V6+8HJ6mRpq8enNhFu
         iI65iBRAP/JySnJLMtRxyqSs1nSttni65mgxlMVyF52lMHv4XXcHKFdASt7uKtdW4BeA
         5yO29I53SvtOr7zCfF0KTBC0UY5jZcx6xYzoA=
Received: by 10.114.32.18 with SMTP id f18mr3667753waf.198.1250541976709;
        Mon, 17 Aug 2009 13:46:16 -0700 (PDT)
Received: from ?192.168.1.153? (CPE0004e29484b9-CM00111ae69cb4.cpe.net.cable.rogers.com [174.112.146.49])
        by mx.google.com with ESMTPS id j15sm11082320waf.51.2009.08.17.13.46.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 13:46:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <81b0412b0908171327l1dd1a36n5e58828d70b18bfe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126276>

Thanks for the info.

How do people typically manage the hooks for their projects?  These may 
change over the life of the project and may be project version 
dependent.  Is the best way to place them into another subdir within 
your project with instructions on updating the hooks files?  Looks like 
a step that would be prone to errors though.

And how about the fact that post-checkout.sample is missing in the 
release I am using.  Is this the only one missing or are there others?

It would also be a good idea if the githooks man page explains this. 
Maybe when I better understand how hooks are best managed, I will 
provide my thoughts on the man page.

Regards,
Joe

Alex Riesen wrote:
> On Mon, Aug 17, 2009 at 22:15, Joe D'Abbraccio<dajoe13@gmail.com> wrote:
>> I have not been able to find out how to commit and push a hook to my git
>> server archive for everyone's benefit. The githooks man page does not
>> describe this and I have not turned up any fruitful google searches on the
>> topic.
>>
>> I am trying to add a post-checkout hook. I also noticed that the
>> post-checkout sample does not exist when I init a new archive. Is this a
>> bug?  I am running git version 1.6.0.2.
> 
> No. It didn't occurred to anyone before to push repository's configuration
> and service files (the hooks). Everybody just copied them into the server
> repositories or edited them in place.
> 
> If the server is a public place like github, it is not very likely they allow
> you to run anything you like on their servers (and hooks are programs).
> 
