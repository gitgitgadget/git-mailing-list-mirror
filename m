From: Misha Koshelev <mk144210@bcm.edu>
Subject: Re: Recover broken git index?
Date: Thu, 28 May 2009 07:43:03 -0500
Message-ID: <4A1E86D7.3060401@bcm.edu>
References: <4A1DB700.4080705@bcm.edu> <4A1E52FD.6090801@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu May 28 15:14:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9fQr-0004CI-E8
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 15:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760866AbZE1NNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 09:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759977AbZE1NNx
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 09:13:53 -0400
Received: from mog.corp.bcm.tmc.edu ([128.249.159.98]:38168 "EHLO
	mog.corp.bcm.tmc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265AbZE1NNw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 09:13:52 -0400
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2009 09:13:52 EDT
Received: from [192.168.2.50] (bcm229-249.vpn.dhcp.bcm.edu [128.249.229.249])
	by mog.corp.bcm.tmc.edu (8.13.6/8.13.6) with SMTP id n4SCea0S002425;
	Thu, 28 May 2009 07:40:37 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <4A1E52FD.6090801@op5.se>
X-Scanned-By: MIMEDefang 2.56 on 128.249.159.98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120188>

OS: Ubuntu 8.04
Git: 1.5.4.3
I tried you checkout master && git reset --hard and it worked. I guess
the problem is when I try to make a commit:
 git commit -a -n
error: invalid object 5e35b75e062c7688636a19334bd85e9e8a408b76
fatal: Error building trees

I first noticed this after my computer was acting sluggish (I was
running processor intensive tasks) and I restarted it.

Thank you
Misha

Andreas Ericsson wrote:
> Misha Koshelev wrote:
>> Hi, I seem to have an unrecoverable git index. I have attached the
>> output of git-fsck --full. There seem to be a lot of missing trees and
>> blobs. Any good way to recover?
>>
>
> Start by copying the repository somewhere safe so you don't accidentally
> delete things in it.
>
> If it's really the index that's broken, a simple
>
>  git checkout master && git reset --hard
>
> should do the trick.
>
> If it doesn't, it's not the index that's at fault.
>
>
> Have you done history surgery on this repository (extensive rebasing
> or filter-branch'ing)?
>
>
> Answers to the questions below really should have been in your original
> post. Please include them if we're to be able to understand what's going
> on:
> What OS and platform are you using?
> What git version are you using?
> How did you first notice this?
> What were you doing when you first noticed this?
> Is your repository working correctly otherwise (ie, do you only spot
> these errors when you run "git fsck --full")?
>


-- 
Misha Koshelev
MD/PhD Student

Human Neuroimaging Laboratory
One Baylor Plaza
S104
Baylor College of Medicine
Houston, TX 77030
