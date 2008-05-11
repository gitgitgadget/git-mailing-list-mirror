From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 22:13:36 +1000
Message-ID: <ee77f5c20805110513k4d34c8f8m83dd9d75a8ec47f4@mail.gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>
	 <4826DF6A.2070306@gmail.com>
	 <ee77f5c20805110506i58dc735fqb6f4258dbb67bf27@mail.gmail.com>
	 <4826E255.6030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dima Kagan" <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvARf-0007ZK-R7
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbYEKMNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 08:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbYEKMNj
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:13:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:15528 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbYEKMNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:13:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1436618fgg.17
        for <git@vger.kernel.org>; Sun, 11 May 2008 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GfcokjfxHVqViN3bfGTqpl1p/wyYc9cx31Ogw/gUE0Q=;
        b=YuRYR/xqHsdpAidM/GleKLWrPI1SrsR8+SMThA6A7QvSRmM8WhUcbLAh7jPrlR61zFmYssKGi66UVHsjOwD6te3zJ1lmx1p1VaJa3IcvV8KbRWlEYppdLN/FZJEB/G1mbmE2Yr9q32tD5CT8JEyyNkNnyle7BzGE8HPzN8jUmEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LUkO5ZRhzWkMvYgj06VXinG7KfdH7iGVmVkBMkQNgkJ5xobB/3GQ0qbuVPKPhdPK91sSczv20NvG2mrNg1ra+unIzKpD3FMNxkh7Xx9aM+PRNaDU1dEyGPOlVXFa68iP/kYAE28Zkw0CVI+EwFZK00U+ONhgG2LYhe9ImsFVHSk=
Received: by 10.86.97.7 with SMTP id u7mr12202633fgb.19.1210508016756;
        Sun, 11 May 2008 05:13:36 -0700 (PDT)
Received: by 10.86.96.12 with HTTP; Sun, 11 May 2008 05:13:36 -0700 (PDT)
In-Reply-To: <4826E255.6030005@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81763>

On Sun, May 11, 2008 at 10:11 PM, Dima Kagan <dima.kagan@gmail.com> wrote:
> David Symonds wrote:
>> On Sun, May 11, 2008 at 9:58 PM, Dima Kagan <dima.kagan@gmail.com> wrote:
>>
>>> That's a subjective point of view :) I'm coming from the SVN world and uncommitted changes on one branch don't affect other branches. Is there a way I can achieve this behavior with git?
>>
>> If you *really* want SVN's behaviour of "branches", just copy your
>> whole working tree (including the .git directory) and start making
>> changes in that. Then they'll be completely separate and you can just
>> 'cd' between them.
>>
>>
>> Dave.
>
> What's the point of using git then? :) I like the way branches are created and switched in git, but I would like each branch to preserve it's own history of modifications. Is that too much to ask? :)

Preserving history is called "committing", which is how git branches
preserve their own history. You said you don't want to commit changes.
You can't have it both ways.  :-P


Dave.
