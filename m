From: Andreas Ericsson <ae@op5.se>
Subject: Re: Index area concept and blowing it up
Date: Thu, 29 Mar 2012 12:42:56 +0200
Message-ID: <4F743CB0.8050603@op5.se>
References: <1332987064083-7416124.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: anjibman <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 12:43:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDCov-0006xM-8b
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 12:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112Ab2C2KnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 06:43:05 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48752 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2C2KnB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 06:43:01 -0400
Received: by bkcik5 with SMTP id ik5so1796767bkc.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 03:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=pGaWRGmSBBypXg4TCuxKnl/6w0nduBuJFZBjzoJ55gI=;
        b=nlzt0Uq40ypw0vz3lQhYOsny58YC27F+c2hmjt0nJoOQCZbLJjBTUZrfI1GNT25rhL
         v4xOsHHPKHUd4q5f2ldWTtNr9HYesM4ETFC/9cAHEt6et8T7x2O6zKPiYRTxlTCDUyam
         iHJROHYvaGrUSe4lqrgsXye8iup+4RjKQDZXYXQkbiWuASuSSLbfOeFJf0nkAXsiWIWn
         YUnNfOugdqMkG6BbKDWNx0yophFP7BDPBXEkD7yBRfwEq0uWtJna80kjyieSd7gA21Rh
         Ey4B2jnaR1N0t5led/37A1HVYmfz/czuUYUNgdypF+DpGHTQz5Z/Q5GqgENTabvDq18T
         dykA==
Received: by 10.204.130.81 with SMTP id r17mr13913094bks.118.1333017779700;
        Thu, 29 Mar 2012 03:42:59 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id r14sm12711360bkv.11.2012.03.29.03.42.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 03:42:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120316 Thunderbird/11.0
In-Reply-To: <1332987064083-7416124.post@n2.nabble.com>
X-Gm-Message-State: ALoCoQmS3lj7MMZldgVv5D2zwFf6UAerZ5xlbCSKR3z4FK7S5MtOj5ydOXAZctb3BGyxFmFyXYha
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194246>

On 03/29/2012 04:11 AM, anjibman wrote:
> Hi All,
> 
> My first question is where is this index actually in Git. Is that a some
> folder or some location?
> 
> Second, how really Git keep information about index?
> 
> Third, in git community book it says " If you blow the index away entirely,
> you generally haven't lost any information as long as you have the name of
> the tree that it described". I didn't get this statement can any one explain
> this in simple words.
> 
> And finally why git add is used for both adding untrack file as well as to
> move file to stage area? Is there any particular reason for this?
> 

index = staging area.
committing = creating a commit object out of the staging area.

When a book talks about "move file to staging area", it really means
"add to the set of files we're about to create a commit object from".

That might help clear things up. 

However; Your questions all seem rather technical, but you don't strike
me as a programmer yourself. If you give us the reason behind your
questions, it'll almost certainly be easier for us to answer them in a
way that's useful to you while wasting the minimum amount of our time.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
