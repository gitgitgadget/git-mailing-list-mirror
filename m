From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: Clone a repo and checkout a specifc remote branch
Date: Sun, 8 Mar 2009 00:25:15 +0100
Message-ID: <4d8e3fd30903071525g27960764rbc1cee77e4334a6e@mail.gmail.com>
References: <4d8e3fd30903070342q584315cjcd059dcfe558dcfd@mail.gmail.com>
	 <1cd1989b0903071053l3f7aa35bu8e8e6b7e56cfc34f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Patrick Notz <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 00:26:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg5uq-0001Aw-UQ
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 00:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZCGXZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 18:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbZCGXZT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 18:25:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:60263 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZCGXZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 18:25:18 -0500
Received: by fg-out-1718.google.com with SMTP id 16so676128fgg.17
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FA8EnfjHqiJ3s8k8UmDiAQE4PTIdyB0IAjTnPo6EqNk=;
        b=xqUk+jBJET7ZGdg2YDLCdZs1zAgM15xS0fvifxhcxiLQ/CpBf2FtgBTm0+IWIJLvK2
         JvDhNAs13XF5wtFIwMkgfm85oIFalvbz+xZ1vWRwtiVpxlQDvRGF7J+/Dd0spDEQpfYE
         JWhyEd8exFLifyxmHqE4xqpsH4ZEtHGMpRH/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bji3lwFSSspji+mJhKY01J+7Q8jrteV9DRHMJkEZewlxY4rP8KmhaDfaaQuRWGhcm8
         WylY8zydD7xk0qVyiRa9RyeIfkIjFLsuylgZzSmkJF/fE4pLykbinzmX2ZGrC6zvGHRH
         QSf0mcqSQ174x84gDHFbNlMSZYTzGYM0aa/+A=
Received: by 10.86.70.3 with SMTP id s3mr2930996fga.48.1236468315562; Sat, 07 
	Mar 2009 15:25:15 -0800 (PST)
In-Reply-To: <1cd1989b0903071053l3f7aa35bu8e8e6b7e56cfc34f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112595>

On 3/7/09, Patrick Notz <patnotz@gmail.com> wrote:

>> Something like:
>> $ git clone git://uri_of_the_repo:coolbranch localdir
>> to get a clone of the whole repository and to check out the
>> origin/coolbranch remote branch?
>>
>
> Here's a link to a recent thread on this topic (that started with a
> proposed patch)
>
> http://thread.gmane.org/gmane.comp.version-control.git/111967
>
> You can read the arguments there.  Johannes Schindelin noted that the
> normal way to do this is like this:
>
> <quote>
> Besides, the common way to check out something different than the remote's
> HEAD is like this:
>
> $ git clone -n $URL
> $ cd $DIR
> $ git checkout -t origin/$BRANCH
> </quote>

Thank you, very appreciated, I missed that discussion.

I'll add my comments to that thread.

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
