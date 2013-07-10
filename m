From: Kyle McKay <mackyle@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Wed, 10 Jul 2013 00:00:00 -0700
Message-ID: <D0E044B4-7252-41CB-A478-BCAC9EAE4AD5@gmail.com>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	David Rothenberger <daveroth@acm.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 09:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwoNp-0003k1-Fl
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 09:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345Ab3GJHAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 03:00:06 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:62956 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3GJHAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 03:00:05 -0400
Received: by mail-pa0-f52.google.com with SMTP id kq13so6358378pab.11
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 00:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=9mKd+JMCQlzyYpZNq/G10puXAO7v0kzCPK69JdQkIxU=;
        b=E/I+qIfkSIUBNnRYxg4egcliFHHIPM+I0UxMnIcRMefEbHsnkvot7WqyNNT8rsWMSH
         odlJQC3W6rmtslbdJ354e99elY6kPktNHM1rKBViiMboQDDuX0KUe6unrVLj9MaAdHDP
         BDMBGJ4PSoHU4gcPppvJOro/myUbtt8GyUEA1kv/SWXlBnc7o0mHX+V8YqdOwUTlE/Xv
         YD4z5Wmy5RmbKWPWQg4v/og7LQ3oBJIpk9L1LI4+4mqFn9x+MwiE2RYj0Bu3Reyi/D2q
         g4esQSNI8I5HvgzDYka/kP6mc2BEPjZK2o/wO8163f5DpotQBjUYEL9XtGNduc47dyzg
         A/+Q==
X-Received: by 10.66.150.9 with SMTP id ue9mr27930480pab.88.1373439604473;
        Wed, 10 Jul 2013 00:00:04 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ix3sm32314626pbc.37.2013.07.10.00.00.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jul 2013 00:00:03 -0700 (PDT)
In-Reply-To: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230030>

On Jul 9, 2013, at 16:09, Junio C Hamano wrote:
> * km/svn-1.8-serf-only (2013-07-07) 2 commits
> - git-svn: allow git-svn fetching to work using serf
> - Git.pm: add new temp_is_locked function
>
> Comments?


Since neither David nor Jonathan have piped in here (they were the two  
primarily involved in the discussion).

On Jul 8, 2013, at 09:22, Junio C Hamano wrote:
> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> From: "Kyle J. McKay" <mackyle@gmail.com>
>> Subject: Re: [PATCH v3 0/2] allow git-svn fetching to work using serf
>>
>> This patch allows git-svn to fetch successfully using the
>> serf library when given an https?: url to fetch from.
>>
>> [...]
>
> Thanks; I've queued this version to 'pu' at least tentatively.
>
> Is everybody who discussed the issue happy with the direction of
> this patch?

I will add that David previously indicated this patch works for him:

On Jul 6, 2013, at 00:17, David Rothenberger wrote:
> On 7/5/2013 8:41 PM, Kyle McKay wrote:
>> This patch allows git-svn to fetch successfully using the
>> serf library when given an https?: url to fetch from.
>
> Thanks, Kyle. I confirm this is working for my problem cases as
> well.

Subversion 1.8.0 was released less than a month ago on 2013-06-18 so  
there probably aren't too many git-svn users affected by this just yet.

Kyle
