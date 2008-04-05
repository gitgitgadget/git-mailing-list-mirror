From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git repository size vs. subversion repository size
Date: Fri, 4 Apr 2008 20:01:41 -0400
Message-ID: <20080405000141.GA23633@dervierte>
References: <1086fb5f0804041502s7ab12202y3b0ec3640425eff@mail.gmail.com> <20080404221728.GA30728@atjola.homenet> <p06240810c41c6e0993c1@[63.138.152.125]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 02:02:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhvrq-0004GJ-8m
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 02:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbYDEACD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 20:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYDEACD
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 20:02:03 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:11876 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbYDEACA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 20:02:00 -0400
Received: by py-out-1112.google.com with SMTP id u52so462554pyb.10
        for <git@vger.kernel.org>; Fri, 04 Apr 2008 17:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=q/3qE7L8jB6tb2KnzjrSOV5H90P8f9SRsW12YCw7bnw=;
        b=X6DseffvyZQxG1poZK1H5VxE4L5K9X8ZIqooZETa7T0dZmn5O7V0v9n5RUDmMqf5L3br38TkVGohbZABJj9DpxplC/NjHy2+8obaNbieCKKTKqv8kuf55OqsPRL2K28MUukGn6gBNleMBqetA1WIIMvD0+ueXXGIBKE0hiFTQKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=HLzBp3QKwUUpQbjQSwmoI9gkWyG1O1tOiQ/zaFv2FH64MmShh6h4eoc+mr3bGq5Vk7RtU8BFF2V1/9OZoaKuDmE2umDuqAszaTtvylu3+tVXbbKIv3aQh/CGhC5nE5lwGtodREZOYTwPnQgNCkgn9Ln3iIeGMZVbHSsbrdDRabc=
Received: by 10.65.242.7 with SMTP id u7mr3027294qbr.65.1207353704098;
        Fri, 04 Apr 2008 17:01:44 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.32.143])
        by mx.google.com with ESMTPS id 6sm6273436ywn.4.2008.04.04.17.01.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Apr 2008 17:01:43 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id E0C3B35C7; Fri,  4 Apr 2008 20:01:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <p06240810c41c6e0993c1@[63.138.152.125]>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78826>

On Fri, Apr 04, 2008 at 07:49:24PM -0400, Stephen Bannasch wrote:
> I'm just fooling around with git so far but I found a huge space savings 
> after running git gc. Here are the rough numbers:
>
> svn repo on server:        1GB
> svn repo checked out:      2GB
> git svn clone after gc:  384MB
>
> That's saving the full history in git -- about 13000 revisions.

git-gc is such an important step in importing a repository from svn.
Why doesn't git-svn take this vital step automatically?
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
