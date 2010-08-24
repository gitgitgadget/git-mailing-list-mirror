From: Wes James <comptekki@gmail.com>
Subject: Re: coding process
Date: Tue, 24 Aug 2010 11:53:10 -0600
Message-ID: <AANLkTikXNGfFV9Bd+G4kixEzqwHLDBH0RXFHUZo5LwEu@mail.gmail.com>
References: <AANLkTi=Aei+-nbNFqY4CNjx5E+nNaOSp7-j+ruuK4kMN@mail.gmail.com>
	<20100824172800.GA4347@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 19:53:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onxgc-0007s8-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 19:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217Ab0HXRxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 13:53:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60238 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab0HXRxL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 13:53:11 -0400
Received: by vws3 with SMTP id 3so694244vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=HMb5agtHYOAPCWXpDIokkzlgupqjnVbQNxrm8iatv7g=;
        b=bfOSsbZLfrge4HsK0/bUTPXww49XrzQRSOU2pjEgHPuPq2+7DiShw1n2o314eoA/0s
         KhD7Wt1fUQzUJJoCLeC6uc+GTm1SCLDMqvPtSehZRw4gCN7VikZQu9cU+cYNbUAxRo2h
         q6VpRWoivvOXZh817Y+LpeIYx23612Z8mSehY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=uQLa8sTNdyja5qYquErmQMQ5WIYv0EfUqKKrExYm4D9Vjvx+RqnUesr08d2gsa4MuK
         mO/qPRgy9PkQsFr5o2/azXnUx6sswO8X2JNVDvukRGffSo01pJqIq5iKvPXg1JASKUlH
         lxgBDHVpsyNZ3mf2Nh35/X0vYX2SqjdOHgiRc=
Received: by 10.220.125.83 with SMTP id x19mr4482024vcr.71.1282672390553; Tue,
 24 Aug 2010 10:53:10 -0700 (PDT)
Received: by 10.220.94.21 with HTTP; Tue, 24 Aug 2010 10:53:10 -0700 (PDT)
In-Reply-To: <20100824172800.GA4347@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154330>

On Tue, Aug 24, 2010 at 11:28 AM, Jared Hance <jaredhance@gmail.com> wrote:
> On Tue, Aug 24, 2010 at 09:31:21AM -0600, Wes James wrote:
>> I am working with git and I'm wondering if coding like the following
>> is a good way to manage code:
>>
>> create code then commit
>> when a good set up code is ready push to master
>> create a branch
>> create code then commit
>> when code is good, merge and push to master
>> go back to create branch
>>
>> Anyone else have a procedure they go through when managing code?
>>
>> thx,
>>
>> -wes
>
> From what you say, it sounds like you are using topic branches, which
> are always a good way to manage code. You might want to consider using
> release branches (like how git.git has "master", "next", and "maint").
>
> I'm not sure what you mean by "push to master". You don't push to a
> branch. You push to a repository. I guess you mean pushing to the
> "official" or "blessed" repository?

I meant when I do "git push origin master" - yes push to repo

> Also, sending patches to an email before merging to master is a
> good idea to get code review.

Ok.

Thx for the input.

-wes
