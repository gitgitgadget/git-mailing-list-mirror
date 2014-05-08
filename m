From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Watchman support for git
Date: Thu, 08 May 2014 21:17:56 +0200
Message-ID: <536BD864.5090804@gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com> <536428224adfb_200c12912f010@nysa.notmuch> <1399083897.5310.0.camel@stross> <5364654088dc4_4d2010fb2ec7d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 08 21:18:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiTpZ-0005P2-58
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 21:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbaEHTSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 15:18:04 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:63468 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbaEHTSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 15:18:03 -0400
Received: by mail-ee0-f44.google.com with SMTP id c41so1985998eek.17
        for <git@vger.kernel.org>; Thu, 08 May 2014 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=W5Q2n9mjs1ItS+YfVr7kH+BHQKsEHcH4v42iH/ToekY=;
        b=xBks8y4qJC+4FaRlKvK89ee+LwkKMkMc+uceBCV0IxgSOV9hzhuek9b2WzyY2SmGCH
         VdIVovWWTQGozX05c+MD+mTz5aOUg70hPIAfuyLOjtFOQEaT7bHWb5N2paz+0fepoEhI
         tw5yahEDQqYyOudhWtKwmev01WTytJM2a5pfoCyQ8GEEbSaQ9bzyNvQ8acjrGlAkcumJ
         leiEDTJGkFtpCMtoevI8/vganDWn8iWMrgCzxMsSble0Icsw4nDhko7MaezspH3ezoOW
         YrpQQcZJjYjZnqiuDDQVvxxxFqyw9O2elCmNy67qVMx3RkhKMmEndfsDD9jvoIvyme/2
         piFg==
X-Received: by 10.15.75.197 with SMTP id l45mr7775200eey.89.1399576681711;
        Thu, 08 May 2014 12:18:01 -0700 (PDT)
Received: from [192.168.188.20] (p5B156FF0.dip0.t-ipconnect.de. [91.21.111.240])
        by mx.google.com with ESMTPSA id t4sm6156461eeb.29.2014.05.08.12.17.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 May 2014 12:17:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <5364654088dc4_4d2010fb2ec7d@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248433>

On 03.05.2014 05:40, Felipe Contreras wrote:

>>> That's very interesting. Do you get similar improvements when doing
>>> something similar in Merurial (watchman vs . no watchman).
>>
>> I have not tried it.  My understanding is that this is why Facebook
>> wrote Watchman and added support for it to Mercurial, so I would assume
>> that the improvements are at least this good.
> 
> Yeah, my bet is that they are actually much better (because Mercurial
> can't be so optimized as Git).
> 
> I'm interested in this number because if watchman in Git is improving it
> by 30%, but in Mercurial it's improving it by 100% (made up number),
> therefore it makes sens that you might want it more if you are using hg,
> but not so much if you are using git.
> 
> Also, if similar repositories with Mercurial+watchman are actually
> faster than Git+watchman, that means that there's room for improvement
> in your implementation. This is not a big issue at this point of the
> process, just something nice to know.

The article at [1] has some details, they claim "For our repository, enabling Watchman integration has made Mercurial's status command more than 5x faster than Git's status command".

[1] https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/

-- 
Sebastian Schuberth
