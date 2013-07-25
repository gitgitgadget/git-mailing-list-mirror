From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: git tag usability issue: Lightweight vs Annotated confusion for
 the end user (ex. git describe default)
Date: Thu, 25 Jul 2013 15:48:02 +0200
Message-ID: <51F12C92.6060200@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 25 15:48:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Lu4-0001FU-6c
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 15:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab3GYNsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 09:48:19 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38607 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab3GYNsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 09:48:19 -0400
Received: by mail-wi0-f176.google.com with SMTP id ey16so5641963wid.3
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pJlwUTHgPt59weRjPOSuCP5/VzLoxTFKa5bN4KmaVuo=;
        b=SLR9LlBVT6jNHQFIKFsUqPwulSGFPjJuoH3a83G+O66YgWyVn1ypmAieajyWJkBC84
         1EP1W2Z8a0Wvjm8jIFrLLRJ1Vf1zXKRHu8Sn6vsBH5Kf7WQ0j+kurhhIFISwPF7O2vSU
         9eU0fJJ6Ke4wtg69zmkJ/TelE1/ovGXRsQ+p44GEwZXhsP2lztSmFhdZSZ565esll4iH
         OiU2bxbpPnEFp7kVqNxCDsRrmmE9phhzNSE5DnM08N83hS/77MV4Ad7E3kujtPSzcA9/
         tnOVFinqzHFlQonhI9AmYH8aopNxFr4XIsDgjK2iPGHLAa4xlOxCDV9BBIc5Mj21YR3t
         FRGw==
X-Received: by 10.180.9.212 with SMTP id c20mr2113704wib.55.1374760086256;
        Thu, 25 Jul 2013 06:48:06 -0700 (PDT)
Received: from [192.168.88.89] (2-229-44-241.ip195.fastwebnet.it. [2.229.44.241])
        by mx.google.com with ESMTPSA id s19sm3867110wik.11.2013.07.25.06.48.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 06:48:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vtxjj66kn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231135>

On 07/24/2013 10:34 PM, Junio C Hamano wrote:
> Daniele Segato <daniele.segato@gmail.com> writes:
>
>> Annotated and Lightweight tags are not the same thing
>> for git and you shouldn't mix them up. Annotated tags are meant for
>> release while lightweight tags are meant to tag random commits.
>
> Nicely explained.
>
> This is one of those "we who worked on Git (not worked "with" Git)
> for a long time _know_ it and do not need it to be explained, and we
> didn't spot that it is not explained in the documentation for new
> people."

Good!

Any change in adding an option to filter tags list by annotated only?


>
> Care to roll a documentation patch (and get a commit count for
> yourself ;-)?

I tried, just sent the patch, hopefully I managed to follow the guide I 
found here: 
http://repo.or.cz/w/git.git?a=blob;f=Documentation/SubmittingPatches;hb=HEAD

As you suggested I removed the "title" line and the reference to git 
describe default.

If I did something wrong please explain me what and I'll fix it

>
> Thanks.

You're Welcome :-)

Cheers,
Daniele Segato
