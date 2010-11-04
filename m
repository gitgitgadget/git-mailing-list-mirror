From: Kevin Ballard <kevin@sb.org>
Subject: Re: can subversion 1.6 be made "just as distributed as git"?
Date: Wed, 3 Nov 2010 17:58:29 -0700
Message-ID: <BF8EE51A-AFE4-4EBA-82E8-4A8B32678FBF@sb.org>
References: <loom.20101104T014408-903@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: MDellerus <mdellerus@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 01:58:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDoA3-0008HB-JN
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 01:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab0KDA6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 20:58:33 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37781 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0KDA6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 20:58:32 -0400
Received: by pxi15 with SMTP id 15so71317pxi.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 17:58:31 -0700 (PDT)
Received: by 10.142.233.2 with SMTP id f2mr8164896wfh.395.1288832311628;
        Wed, 03 Nov 2010 17:58:31 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm14500329wfg.8.2010.11.03.17.58.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 17:58:30 -0700 (PDT)
In-Reply-To: <loom.20101104T014408-903@post.gmane.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160658>

Using "svnadmin hotcopy" you could certainly get your own local repo, but I fail to
see how you could easily join your history up with someone else's history using this
mechanism. If you really want to use SVN in a distributed manner, I would recommend
you simply use SVK.

-Kevin Ballard

On Nov 3, 2010, at 5:45 PM, MDellerus wrote:

> I have a co-worker who has suggested that, using "svnadmin hotcopy", subversion 
> can be
>    just as "distributed" a system as Git
> 
> While I see how this can be done, it hardly seems to me to qualify as "just as", 
> making this "plausible" at best.
> 
> Can anyone give me a quick confirmation of this?  Confirmed? Plausible? Busted?
> 
> If this is confirmed or plausible, could someone give me a quick run-down?
> 
> (I would appreciate a response, no matter how long it takes, but I do have a 
> meeting with this co-worker in another 16 hours... (10am Pacific).)
> 
> Thanks in advance!
> 
> (FYI - I have cross-posted this, just once, to an SVN forum, in the event they 
> might have a different opinion.)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
