From: Dima Kagan <dima.kagan@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 15:21:14 +0300
Message-ID: <4826E4BA.9080506@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>	 <4826DF6A.2070306@gmail.com> <f35478f50805110513h15aa462bs9ee35ed4738d3009@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steve <nudrema@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:22:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvAZ5-000171-HZ
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbYEKMVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 08:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbYEKMVS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:21:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:49649 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYEKMVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:21:18 -0400
Received: by ug-out-1314.google.com with SMTP id h2so505876ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=pfpOsGJy4Od08lLsm6ipwpUWJrQqAcm5rAVAo8tTDO0=;
        b=Q6Ms4aX0SM1u5hhnbyTQSOiPPuVrOmMJUB0DR5cENRukpN/r2ydsu7wADZ04pS4d8fiXgOPj7PRV54z0M3gi1ehQdUBOACpeaigkuOAsvf89fHCGDVqyiQoYYTMhWdiSm9PmZAPHjmxCPOqOkPpO6xx2ivzGVtq48VhrNj26ypU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=J29QrTVlAsU1g/zw5VQ9NaWXEBps/kN88aS/o56egbS4FtigwK42Wxy4LZoztIHXSLhstY+D6ttj+M4AgoeWZUXG1UkFeYVmyNlPJdz8uEf6Hnchg2xaECpF28QO0NX6umEgRHRyRwrDelv+hbsmJE9ZoFabR+sUZaX/TVvGRxI=
Received: by 10.67.121.2 with SMTP id y2mr4011941ugm.78.1210508476134;
        Sun, 11 May 2008 05:21:16 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id g9sm12976220gvc.0.2008.05.11.05.21.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 05:21:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <f35478f50805110513h15aa462bs9ee35ed4738d3009@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81766>

> On Sun, May 11, 2008 at 1:58 PM, Dima Kagan <dima.kagan@gmail.com> wrote:
> 
>>  >> Basically I see that the same file I edited on the 'test_branch'
>>  >> branch appears to be modified on the 'master' branch as well. This
>>  >> behavior is unwanted, of course.
>>  >>
>>  >> Can someone please tell me, what am doing wrong? Or is this git's
>>  >> normal behavior?
>>  >
>>  > This is normal, and wanted, behavior.
>>  >
>>
>>  That's a subjective point of view :) I'm coming from the SVN world and uncommitted changes on one branch don't affect other branches. Is there a way I can achieve this behavior with git?
> 
> There are several ways, actually.
> 
> The one I prefer to use is to commit the modifications. Then, you can
> use git-reset HEAD^ to drop that temporary commit when you come back
> to this branch, or git-commit --amend to modify it.
> 
> Always keep in mind that in git's world, history is not set in stone,
> you can always modify previous commits, reorder them or merge them, as
> long as you have not pushed them to your public repository (in your
> case, the SVN one).

Hi!
Thanks for these little tips.

I understand that git is very powerful, however some things are hard to grasp when switching from SVN. Perhaps I should overview my workflow to see how it can benefit from git, despite these differences.
