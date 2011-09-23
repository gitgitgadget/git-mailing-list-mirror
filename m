From: Jon Forrest <nobozo@gmail.com>
Subject: Re: What's The Right Way to Do This?
Date: Fri, 23 Sep 2011 06:45:27 -0700
Message-ID: <4E7C8D77.4020707@gmail.com>
References: <loom.20110923T064720-366@post.gmane.org> <4E7C27A0.9030900@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Sep 23 15:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R764O-0007Z5-M5
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 15:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466Ab1IWNp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 09:45:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45953 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1IWNp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 09:45:27 -0400
Received: by mail-iy0-f174.google.com with SMTP id q3so3923793iaq.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Bdbhf0RYDH472medP97JzFcMB7r/b/3LThix4OmeQNo=;
        b=oJ/2+s0at5X++b4Jk2gq8DUcyLEAH7/P2PFQ++aq1/24jY/DUBWeg+gPEaEHW8d9rV
         KWnHnqrUvYUR1oNhyVxHT3QMbOt6tQsAFR2lT8Pkt4JGIx6aqF0cLGVnqD8GAy5JLPUP
         cZTIsCn8SWDE1mwJGm2LNV1z/avcTFaSDBKek=
Received: by 10.42.28.2 with SMTP id l2mr4334720icc.79.1316785526686;
        Fri, 23 Sep 2011 06:45:26 -0700 (PDT)
Received: from [192.168.0.104] (c-98-248-228-150.hsd1.ca.comcast.net. [98.248.228.150])
        by mx.google.com with ESMTPS id el2sm15759058ibb.10.2011.09.23.06.45.25
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Sep 2011 06:45:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <4E7C27A0.9030900@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181967>

On 9/22/2011 11:30 PM, Luke Diamand wrote:

> Someone will be along soon to correct me, but I think you should have
> rebased against the master branch rather than merged. Something like:
>
> % git rebase origin
>
> That way your changes would remain appended to the tip of the master
> branch. That will in general make your life much easier for all sorts of
> reasons.

In considering this, I'm having trouble understanding when to do a merge
as opposed to a rebase. Let's say that other people weren't putting
changed back in the remote master. So, my changes would always be at the
tip. Is that when I should merge? If so, then this suggest that knowing
what to do depends on knowing what other people are doing. But, doesn't
this go against the philosophy of a distributed SCM?

> At a guess, git revert created a commit that undid your _merge_, rather
> than your commit. The merge included all those other changes....
>
> It's a good idea to take a look at what a commit does before pushing it
> - "git show HEAD" is your friend.

IIRC, I did this and I saw the collection of the changes I had
made plus what other people had made. I didn't know how to revert
only my changes.

> Use git rebase (*) to keep your changes nicely arranged at the top of
> the main branch.

Thanks. I'll study up on this.

> I think you could award yourself a nice cup of tea after an experience
> like that though, having been on both sides of it, I can imagine you
> need it :-P

It certainly wasn't my finest hour!

Jon
