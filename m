From: Joshua Juran <jjuran@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 05:44:11 -0700
Message-ID: <5A9D499C-26AC-401E-B21A-1F8E03FBAC4B@gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com> <AANLkTi=7TNjLVrcJVppiULBnDdKCM_vqwhn1JqoW+DQo@mail.gmail.com> <AANLkTimsN40twLwOWXsQqbv0SVN7T9rEHSUpcVum8aFR@mail.gmail.com> <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 14:44:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4YHX-0007XU-Cb
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 14:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab1C2MoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 08:44:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39731 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab1C2MoP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 08:44:15 -0400
Received: by iwn34 with SMTP id 34so133448iwn.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=MpkpYXf+WCgFaDrcwBiKX9xZbUKyPn1CLitgtp9s/fs=;
        b=Pna2XFEvo6S4WqcLETTxW3LzcEszx3hRMJtkRGTWyQtrvOkvUjpHLzWgulriov5jD8
         zvhkpQtaYkGuD9wvtoFKCZAq+ja2CTSwxbHyN++ujPXcYqTwEOuVKFd7d3fhJMHxVaxG
         RMmPVwnBBjMWRh/m885+yp484SDaqQ5EC2qk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=IQrngeqOi9cAPZmKOADd92DQULqt61To/WReV9/O9v+xYv6hVh25nG44ateWVdaoPx
         ZvRvrDHo3slLDBW3EruCVRoQTQAnWvsLhk/t1X/Vx3/7gCBZbGN5dLPMOHrBgtcSpZjB
         /zrOYWSuWf4+RhVHnik8Vw9t2d9wVbo5jp/FE=
Received: by 10.231.118.99 with SMTP id u35mr172228ibq.56.1301402654927;
        Tue, 29 Mar 2011 05:44:14 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id i20sm3650059iby.65.2011.03.29.05.44.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Mar 2011 05:44:13 -0700 (PDT)
In-Reply-To: <AANLkTikX5YvMrooVi-7e-YDrCP_7QHqL6wR=1bY1cZ2L@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170263>

On Mar 29, 2011, at 3:58 AM, Alex Riesen wrote:

> On Tue, Mar 29, 2011 at 12:10, Lynn Lin <lynn.xin.lin@gmail.com>  
> wrote:
>> On Tue, Mar 29, 2011 at 5:38 PM, Alex Riesen <raa.lkml@gmail.com>  
>> wrote:
>>> On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com>  
>>> wrote:
>>>> All,
>>>>   I have only have two commits in repo,then I want to squash these
>>>> two commit into one through git rebase -i .However it fails
>>>>
>>>> $ git rebase -i HEAD^1
>>>> it only show up one commit so can't squash (can't squash without a
>>>> previous commit)
>>>
>>> $ git rebase -i HEAD~2
>>>
>> only have two commits
>
> Uh. That's unusual.
>
> Than yes, "git reset HEAD^; git commit --amend" seems the best  
> solution.

Actually, that should be:  `git reset --soft HEAD^; git commit --amend`.

Josh
