From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] wording fixes in the user manual and glossary
Date: Mon, 26 May 2014 19:50:15 +1200
Message-ID: <5382F237.8070909@gmail.com>
References: <1400989841-2845-1-git-send-email-jmmahler@gmail.com> <5381A239.2060809@gmail.com> <20140525083720.GA28739@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 09:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wopfy-0003TI-7O
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 09:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbaEZHuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 03:50:23 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:47729 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaEZHuT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 03:50:19 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so7390437pbc.10
        for <git@vger.kernel.org>; Mon, 26 May 2014 00:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Z8gU0prUFOLp0PbiUtjN9uwHUTY0q3Izd7CzdI9Nqng=;
        b=Zgih6GtoFWJycYrlZImgxSwSnAmX0PvfKrHrH0N8MFejhyJPKYCWs1MhSMpTzECG5+
         p/Y66SYbWMyfR0Xi91lFPtmUK2ju+mjSyl3AYSQCN2ydJ4zE0fTn4roNE6xJeXOU0tuS
         NfXvjoS7XCGf0fdNQJX2ilwVNSyUOkoS1LQj+yo3YC/fAc4qPFGTZ5t1TqvofpQV+mCi
         XhceFqHNaR8YDGMFtSSynifo/NnWCqFXa7ZaRFbjZb8DylycwhRIXqFq1etWCdwhiHN0
         xF9BsDwrtyavHj5SvMccJtjorYlEwcPnutzEd/rZWK2GYO/SVpGpyw7AYrRiB+VlMPqN
         zy1Q==
X-Received: by 10.66.142.73 with SMTP id ru9mr25500076pab.41.1401090619255;
        Mon, 26 May 2014 00:50:19 -0700 (PDT)
Received: from linux.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id pl10sm16796055pbb.56.2014.05.26.00.50.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 May 2014 00:50:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140525083720.GA28739@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250089>

On 25/05/14 20:37, Jeremiah Mahler wrote:
> On Sun, May 25, 2014 at 07:56:41PM +1200, Chris Packham wrote:
>> On 25/05/14 15:50, Jeremiah Mahler wrote:
>>> Some minor wording fixes in the user manual and glossary.
> ...
>>>  
>>> -Eventually the developer cloned from will do additional work in her
>>> +Eventually the developer will do additional work in her cloned
>>>  repository, creating new commits and advancing the branches to point
>>>  at the new commits.
>>
>> I agree that the original wording isn't clear but I'm not sure the new
>> wording is any clearer. The paragraph is trying to explain how to fetch
>> upstream changes when they happen. My initial thought was to say
>> "Eventually the developer will do additional work in the upstream
>> repository" but perhaps it is to early to start throwing around terms
>> like upstream. Perhaps just saying "her repository" would be clearest.
>>
> 
> The "developer cloned from will do" didn't sound right to me.
> But it sounds like my interpretation is not what you were trying to
> convey.  I do like the "upstream" term, it helps describe the
> local/remote aspect.
> 
> How about this:
> 
>   Eventually the upstream developer will do additional work in their
>   repository.  Creating new commits and advancing the branches to point
>   at the new commits.

Sounds good to me.

> 
> Then in the next paragraph it will discuss how to use `git fetch`
> to get these remote changes in to the local repository.
> 
