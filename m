Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDF6FAA
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E9C9
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 03:30:18 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id C175223FE5;
	Sun, 22 Oct 2023 06:30:16 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1quViq-KxP-00; Sun, 22 Oct 2023 12:30:16 +0200
Date: Sun, 22 Oct 2023 12:30:16 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTT5uI5Hm1+n0Agx@ugly>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5fac8607a3c270e06fd610551d7403c7@manjaro.org>

On Sun, Oct 22, 2023 at 08:38:19AM +0200, Dragan Simic wrote:
>True, but I still think that having git put its thoughts into tables is 
>actually not helpful.
>
i'm not convinced that the proposed feature specifically would have 
helped me, either (i found the index a rather obvious concept once i 
knew that it's there), but i'm making a general argument here. so:

>To be precise, it actually might be helpful, but only to the first 
>category of users, who will never reach it.  I mean, never say never, 
>but in this case I'm pretty sure it's safe to say it.  
>
well, and i think that you're wrong about that.
your categorization is simply wrong, because it assumes an incorrect 
static model.

while for the last decade i've been as much of a git expert as one can 
reasonably be without being literally obsessed with it or having written 
much of it, i absolutely *did* start out in your first category (as in, 
it was forced upon me, while i couldn't have cared less about the 
specifics - p4 was working well enough (or so i thought)). and i hated 
this stupid git (it was 2009, and it was much more of a pita for noobs 
than it is now). i certainly could have used more sensible 
visualizations at every step - on the command line, because that's where 
i mostly "live".

the second major error in the thinking is that "expert" and "gui user" 
are mutually exclusive categories. while i do most things on the command 
line, i would never voluntarily use "add -p" - why should i inflict that 
pain upon me, when i can simply use git-gui to do the job in a much more 
visual and freely navigable way? the same goes for "log --graph" vs.  
gitk, and git's "blame" function vs. qt creator's (or git-gui's, but i 
don't use it for that).

regards
