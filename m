From: Christian Holtje <docwhat@gmail.com>
Subject: Re: [RFE] git rebase doesn't say it failed
Date: Mon, 10 Mar 2008 10:33:25 -0400
Message-ID: <5C9883C7-04F4-4786-980A-25958A4102F1@gmail.com>
References: <429AC7A2-511E-496F-9C1C-4627604EBBFB@gmail.com> <alpine.LSU.1.00.0803101207120.3975@racer.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:34:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYj4z-0001PA-Uc
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 15:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbYCJOdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYCJOdg
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 10:33:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:23399 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYCJOdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 10:33:36 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1718662fkz.5
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        bh=Dq49cCcnekAg+s+VfD6yslCwL5Nmpew0wHIV+pKTXVY=;
        b=a7eqE02Fosmdjy4/q3WKNQf2rmdjMxa71Xe12cpIwSqxrh5NNObkHrNIcan73zmBZdOfxgEUanmDKU30jIS3yK5yoWh2faXV1mUonpsnQpM4SQQAjpEip1Bu0V7wtbuHbykkpXilWkrtjUM3CQP26maIXnLyyru5A7D5cml4ud8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references:x-mailer;
        b=mR1DMnvIjBW8L4WilI2F6aTJskTpWyuAk+LfHLDXsO1k79dbhVboFb6G6rmBqhXsQwu9w3Zp7NxWC8Jps0NtdhvRtK0ai5IuNe5+U0Tup3GbtzZBRhmcwgtYWJeuFMSLjZ6xEwRwYwoTrRXfvVC7DYFqP7Ce5+IlvZDvqh/qshk=
Received: by 10.82.134.12 with SMTP id h12mr13201428bud.34.1205159614442;
        Mon, 10 Mar 2008 07:33:34 -0700 (PDT)
Received: from ?192.168.0.141? ( [206.210.75.84])
        by mx.google.com with ESMTPS id g11sm6828021gve.6.2008.03.10.07.33.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Mar 2008 07:33:33 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803101207120.3975@racer.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76729>


On Mar 10, 2008, at 7:10 AM, Johannes Schindelin wrote:

> On Sun, 9 Mar 2008, Christian Holtje wrote:
>
>> Hello!
>>
>> What happened:
>> I tried to do a rebase and got a message about files "needs update".
>> However, it didn't say it did a rebase nor did it say that it failed.
>
> It told you that a file is dirty.  Git kinda expects you to know  
> that it
> will not start a rebase on a dirty working directory.
>
> So there _was_ an (implicit) message saying that it failed.
>
>> Git was unable to rebase due to the files above.  Please commit  
>> them or move
>> them out of the way.
>> Hint: See "git reset --help" for a suggestion about saving work in  
>> progress.
>
> The same comment I gave last week applies here: people complained  
> that Git
> was too chatty.  I tend to agree, since the important information  
> was lost
> in the huge amount of text.  Now you say we should make it chatty  
> again?

I can see the problem with commands that execute correctly being too  
chatty, but here the command requested was not performed.  In the name  
of terseness, how about simply saying "rebase was not performed."

As a general rule, though, when I generate an error message I try to  
explain what happened and how the user should fix it, which is why I  
included the more verbose version above.

Ciao!
