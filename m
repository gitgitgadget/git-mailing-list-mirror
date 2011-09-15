From: Scott Chacon <schacon@gmail.com>
Subject: Re: Anybody home?
Date: Thu, 15 Sep 2011 08:04:10 -0700
Message-ID: <CAP2yMaJcKnghtxxDNVYk=00KQ-ZOGEwACHRTU15tGnOuk3R4Hw@mail.gmail.com>
References: <CAOZxsTq1crC0zeMpFGMafG8HXu168gkK2-KDnpwLoamRLJshjg@mail.gmail.com>
	<4E71A5FF.5040807@viscovery.net>
	<CAOZxsTqGt=gYr3t7e5Ma4z6W9wt_JxrgsNSGFGVbtk2rc3LZ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:04:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4DU9-0006w4-9u
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933979Ab1IOPEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 11:04:12 -0400
Received: from mail-gw0-f52.google.com ([74.125.83.52]:42662 "EHLO
	mail-gw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933899Ab1IOPEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 11:04:11 -0400
Received: by gwb1 with SMTP id 1so1403418gwb.11
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G4IUApI+rEAWzTBsKOfEanJ/7z1TZGMLOikceZKQMFM=;
        b=Q2icYZwCF6vwFAdRG4jI0RpQ3VxeKVf7NIr8akpExyapgrliVRWHGCeaUlPdtSPH5E
         6977yYMpNPAsoCch7kj3wvRCnlF8rjyT+d1nB6lxS0E0VX0IO4Rx7w4OjCp1DS66ev1Z
         su36gVc+NpZrOsu7z9YO/BONQK7/kzz+VXaZM=
Received: by 10.150.157.19 with SMTP id f19mr1300833ybe.324.1316099050393;
 Thu, 15 Sep 2011 08:04:10 -0700 (PDT)
Received: by 10.151.154.18 with HTTP; Thu, 15 Sep 2011 08:04:10 -0700 (PDT)
In-Reply-To: <CAOZxsTqGt=gYr3t7e5Ma4z6W9wt_JxrgsNSGFGVbtk2rc3LZ9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181469>

Hey,

On Thu, Sep 15, 2011 at 2:01 AM, Joshua Stoutenburg
<jehoshua02@gmail.com> wrote:
>> Reading your exchanges elsewhere in this thread, I think you missed that
>> you don't need a git server at all just to *use* git.
>>
>> Even when you want to exchange your commits between two or three machines,
>> all you need is ssh access. There is no *git server* necessary. git is not
>> svn. ;-)
>>
>> I thought I'd just mention this to help you streamline your search.
>>
>> -- Hannes
>>
>
> I read the first four and a half chapters from the Pro Git book pdf.
> So I think I understood that much.
>
> But in my situation, I do need a server so that other developers can
> access anytime over the internet.
>
> I should have mentioned that.

I guess I'm confused.  The fourth chapter of the Pro Git book is
entirely about setting up your own Git server, including basically
step by step instructions on Gitolite and Gitosis, in addition to
simply running your own ssh-based server plus gitweb.  It is like 20
pages long - how is this not exactly what you're asking for?

Scott
