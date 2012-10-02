From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Tue, 2 Oct 2012 13:54:42 +0530
Message-ID: <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com>
 <506A9EA6.9010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 10:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIxnW-0001SS-63
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 10:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab2JBIZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 04:25:08 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48025 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab2JBIZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 04:25:03 -0400
Received: by qchd3 with SMTP id d3so4389477qch.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rbClATGsry4EDchi08sDuytpcyBDvtVBkTEtGwurxD8=;
        b=ji0NgCKX+YqljVEkUT25MDfM+tif+pwflnhzBI2edcbfSPfkE35lqu5mneK4SRw2zR
         29/25KA5B5DSozdH2GhqgWkyV/1aLsedoPO1ic79Mwadl6dUXr6HsbhWymufyOUc5I3m
         Dv/qRY59wGUNgejdMj0es02FwzvQ9Ty2uGYlCKjq0/H2xn0PtWFEg3IkvzDdohMiCA1e
         hJ9kaQLGWQKc04xA3C4eH0lR2tATOWXc67BC1Wuj7OUL8KMF/EnmqpDtDWonmT8dmT9y
         keMsvF4nH8m0c7Z7jiLFfa2ZU9IGVXiXpqTN19EtILKMszyACu9yhyGGuGgpQI2dQkY1
         FHXg==
Received: by 10.224.192.66 with SMTP id dp2mr1102160qab.95.1349166302533; Tue,
 02 Oct 2012 01:25:02 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Tue, 2 Oct 2012 01:24:42 -0700 (PDT)
In-Reply-To: <506A9EA6.9010303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206791>

Stefano Lattarini wrote:
> On 10/02/2012 09:21 AM, Ramkumar Ramachandra wrote:
>> Hi,
>>
>> I've often found the '**' (extended) shell glob useful for matching
>> any string crossing directory boundaries: it's especially useful if
>> you only have a toplevel .gitignore, as opposed to a per-directory
>> .gitignore.  Unfortunately, .gitignore currently uses fnmatch(3), and
>> doesn't recognize '**'.  Would extending the .gitignore format to
>> accept this be a useful feature?  Would it involve re-implementing and
>> extending fnmatch, or is there some other way?
>>
> I think there is a topic in flight about this:
>
>     <http://thread.gmane.org/gmane.comp.version-control.git/206406>

Ah, yes.  Thanks.

Ram
