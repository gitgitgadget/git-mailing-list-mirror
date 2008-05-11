From: Dima Kagan <dima.kagan@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 15:17:34 +0300
Message-ID: <4826E3DE.5020506@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>	 <4826DF6A.2070306@gmail.com>	 <ee77f5c20805110506i58dc735fqb6f4258dbb67bf27@mail.gmail.com>	 <4826E255.6030005@gmail.com> <ee77f5c20805110513k4d34c8f8m83dd9d75a8ec47f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:18:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvAVY-000062-3A
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbYEKMRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 08:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbYEKMRj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:17:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:46074 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbYEKMRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:17:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so505493ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=r2T18dg82t387IWzI6JOpWkrfXn/FyPcrSKjcRm0IEo=;
        b=dBokpU6Y8H4RlJaptO5lSqpIV0puVy5uQjvu1lQYXf/9WE/V6VzPUTiAQfrDxzKyYxCpkT5Mpf+c4tCJ3K/uM7MWxtQbKXR9BTvSIDenG7aYfEBhyOeecqqh847t3I5WCTQnONjeaPs7eQsK8+O1Rl20bN+lcwZQDBABbWhZrlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=TbpOEk92Xc4CPcXi/8hKUCVLqhBhZUauz9Ga5cANsF8nPEW/vTC4Xiy/CwEMJ6/1OkGseh/3H7mDjMcvdSnrc2ftNfkjxpFdz/uYnRJW/ws0f2jhhvuFAlBSH281n01l992A6Fr8m2/OPY6XCXSKD744ov44JIdksOPRsf1uIEs=
Received: by 10.67.115.15 with SMTP id s15mr4011978ugm.63.1210508256129;
        Sun, 11 May 2008 05:17:36 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id t2sm12968120gve.9.2008.05.11.05.17.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 05:17:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <ee77f5c20805110513k4d34c8f8m83dd9d75a8ec47f4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81764>

> On Sun, May 11, 2008 at 10:11 PM, Dima Kagan <dima.kagan@gmail.com> wrote:
>> David Symonds wrote:
>>> On Sun, May 11, 2008 at 9:58 PM, Dima Kagan <dima.kagan@gmail.com> wrote:
>>>
>>>> That's a subjective point of view :) I'm coming from the SVN world and uncommitted changes on one branch don't affect other branches. Is there a way I can achieve this behavior with git?
>>> If you *really* want SVN's behaviour of "branches", just copy your
>>> whole working tree (including the .git directory) and start making
>>> changes in that. Then they'll be completely separate and you can just
>>> 'cd' between them.
>>>
>>>
>>> Dave.
>> What's the point of using git then? :) I like the way branches are created and switched in git, but I would like each branch to preserve it's own history of modifications. Is that too much to ask? :)
> 
> Preserving history is called "committing", which is how git branches
> preserve their own history. You said you don't want to commit changes.
> You can't have it both ways.  :-P
> 
> 
> Dave.

Not quite. :) The current branch knows what files have been modified without committing the changes.
Why should other branches be aware of these changes until I commit them?
