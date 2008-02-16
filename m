From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: looking for example of following code across files
Date: Sat, 16 Feb 2008 12:10:11 -0500
Message-ID: <44F74AD0-CD8E-4715-BA88-4355F4513AB0@gmail.com>
References: <57E76010-D0F8-420C-A11D-8884832FD00D@gmail.com> <m3pruxb6rh.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 18:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQQZe-0001xy-Sg
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 18:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262AbYBPRKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 12:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbYBPRKr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 12:10:47 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:48004 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbYBPRKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 12:10:19 -0500
Received: by wx-out-0506.google.com with SMTP id h31so933144wxd.4
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 09:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=eBCZz/EmN7Y5gmR2SWJDU6vRMMOz2U8nFpjr6eMNbs8=;
        b=FBpSRhvFHprmxJGVYxv0JH06qQWJpaLoMs1e3YiuhyDCJ9Hmz0Za6zC4DYIKT11bEISLVOIlQ58K841in/kZKubJQS3eadR0iD1t27kNYL4xLh2k4p1VIvG0jeMPfJzi6W0bm9X9mEZ0jhHOB50ml6aEY1MhJncU41q3kKe3Tuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=Ma9KcSBTci9HYsor1Ln1xgqgWuDz7jc+X3ds6vYMVJtdCekP+PSb/n1TU8RuuE3lz2hv2GGuUQMF+z3vOY7f+B248+0fTGpBsUp3o2CdDfa2JDGSHEXxDujELWGTtA38I+ab1gIH+q7tK46nSQCoYxB/nAdwy27i6NhwU3uZSqI=
Received: by 10.70.43.10 with SMTP id q10mr2677692wxq.74.1203181816663;
        Sat, 16 Feb 2008 09:10:16 -0800 (PST)
Received: from ?192.168.1.103? ( [71.126.230.85])
        by mx.google.com with ESMTPS id h14sm2003194wxd.26.2008.02.16.09.10.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Feb 2008 09:10:15 -0800 (PST)
In-Reply-To: <m3pruxb6rh.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74048>


On Feb 16, 2008, at 4:16 AM, Jakub Narebski wrote:

> "Rhodes, Kate" <masukomi@gmail.com> writes:
>
>> I seem to remember that when Linus was giving the tech-talk to the
>> folks at Google he mentioned Git being able to follow a block of code
>> as it was moved from file to file, but I'm having a hard time finding
>> an actual example of how that plays out.
[snip]
>>
>> Can someone please point me to an example showing how to go about  
>> this?
>
> For example in git.git repository, try "git gui blame revision.c".
> The 9th fragment, the 'path_name' function, was moved there from the
> file "rev-list.c".
>
> This is the commit that added the code:
>
>  commit e646de0d14bac20ef6e156c1742b9e62fb0b9020
[snip]
>
> This is the commit that moved the code
>
>  commit ae563542bf10fa8c33abd2a354e4b28aca4264d7
[snip]
>
> You can check the commits using gitweb; unfortunately blame in gitweb
> is usually disabled, and it dies not have fancy "git gui blame"
> showing of code movements.
>
> P.S. Sorry, I've just noticed that the dates are in my locale...

Thank you Jakub. I really appreciate it.
In order to find the original commit of each block is the system  
looking up the commit for each block via it's SHA1, then following its  
parent commits until it finds another commit that affected the same  
block or runs out of commits?

I'm thinking that while this would be possible to do manually it would  
way too many lookups to be practical. Or, is there a simpler way to do  
it on the command line?

I'm just trying to get my head around how the pieces of git fit  
together.

-Kate=masukomi
