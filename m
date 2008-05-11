From: Dima Kagan <dima.kagan@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 15:11:01 +0300
Message-ID: <4826E255.6030005@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain>	 <4826DF6A.2070306@gmail.com> <ee77f5c20805110506i58dc735fqb6f4258dbb67bf27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 14:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvAPQ-0006uW-TT
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 14:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbYEKMLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 08:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbYEKMLH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 08:11:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:39483 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbYEKMLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 08:11:06 -0400
Received: by ug-out-1314.google.com with SMTP id h2so504741ugf.16
        for <git@vger.kernel.org>; Sun, 11 May 2008 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=AuA3W7MsRl4g7bPnyBm99ooymN2cjnNW3CF/6fZG3Ow=;
        b=LZidf5TOJUmiAmZegzA+5dIsxYHvFTnF2+zJGqdZrJD/tTJ5hPyX7ctGtnJmMEwX8hVYBM5gOT79qDWPqTI8CK/xPDHB03ZT/pXo61UK7yXINp4sHVTyLMaJFARIFf+BP+y5w7Jjl1mkPyb8b96AkMEK2YT15d4gni9FMr9dPeA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bSJgGbtmDUtXySZug6pH+f3nfUc/EhuGBYXnSi5tANH4cMZFZdpZRS6qQbxDV9KqCIePfPVJYbqy0bdQGK+salKKMkOuspvlOSYvDjfShTYG7kSPZo8DXTMbljopPUEZyJGr3y5LMne4h4JXjugpSxN1Q2dmX4eqps95fJweQYY=
Received: by 10.67.119.15 with SMTP id w15mr4004389ugm.73.1210507863203;
        Sun, 11 May 2008 05:11:03 -0700 (PDT)
Received: from ?192.168.1.60? ( [82.166.58.226])
        by mx.google.com with ESMTPS id u14sm12939856gvf.6.2008.05.11.05.11.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 05:11:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <ee77f5c20805110506i58dc735fqb6f4258dbb67bf27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81762>

David Symonds wrote:
> On Sun, May 11, 2008 at 9:58 PM, Dima Kagan <dima.kagan@gmail.com> wrote:
> 
>> That's a subjective point of view :) I'm coming from the SVN world and uncommitted changes on one branch don't affect other branches. Is there a way I can achieve this behavior with git?
> 
> If you *really* want SVN's behaviour of "branches", just copy your
> whole working tree (including the .git directory) and start making
> changes in that. Then they'll be completely separate and you can just
> 'cd' between them.
> 
> 
> Dave.

What's the point of using git then? :) I like the way branches are created and switched in git, but I would like each branch to preserve it's own history of modifications. Is that too much to ask? :)
