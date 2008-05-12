From: Justin Leung <jleung@redback.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Mon, 12 May 2008 11:51:50 -0700
Message-ID: <482891C6.1050607@redback.com>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop>	 <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop> <46d6db660805110221y1207974dt3be709e1b67cf3d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, justin0927@hotmail.com
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 20:52:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvd8g-0000xm-6C
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927AbYELSv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbYELSv5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:51:57 -0400
Received: from prattle.redback.com ([155.53.12.9]:43723 "EHLO
	prattle.redback.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbYELSv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:51:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id 89B32BF3DC1;
	Mon, 12 May 2008 11:51:50 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26725-09; Mon, 12 May 2008 11:51:50 -0700 (PDT)
Received: from [155.53.72.61] (havant.redback.com [155.53.72.61])
	by prattle.redback.com (Postfix) with ESMTP id 6AB66BF3DC0;
	Mon, 12 May 2008 11:51:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <46d6db660805110221y1207974dt3be709e1b67cf3d6@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at redback.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81903>


Hi Christian,

 I personally have no problem dealing without revision numbers .
I merely used them directly .

However, I think I gotta admit that this is a world more than just us .

There's an obvious reason why Windows and MS are still standing, and IE 
is still the market holder :

we are the minority ..  a lot of people just care to get the work done .

surely i felt defeated, but one lesson to know is that the interface is 
very important for beginners ;

and a simplified numbering scheme is really what the managers/VPs are 
looking for to avoid rookie mistakes .

Thanks for the support tho =)
I know i m not alone

 Justin

Christian MICHON wrote:
> I'm an ASIC designer too.
> this is unimportant: if they want to track a specific release of a
> file, it's better to look at what was the file's content from this cut
> to that cut.
> just use gitk and git-gui: almost all can be done with these two
> graphical tools.
>
> for linear development, yes. but when we were requested to perform
> maintenance on a specific old cut, this was becoming a nightmare.
> gitk, git-gui: two commands (actually gitk can be called from git-gui)
> this is the wrong approach.
> use branches to reference the different ressources (rtl, simulation, layout).
> then track these branches between them for deliveries and work/flow.
>
> use tags to mark specific releases/cuts.
> you can create an alias: git-show-branch | tail -r
>   
>
> yes, I used to be scared by sha1 too: I even created numbered tags for
> each commit. Until I read more about git, and stopped expecting using
> git as svn/cvs.
>   
> no, it would kill the right approach: embrace the index, and never look back.
>   
>
> you have to adapt your methods instead: trust another ASIC designer :-)
>   
