From: Tim Ottinger <tottinge@progeny.com>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Tue, 13 Sep 2005 14:06:56 -0500
Message-ID: <43272350.3060801@progeny.com>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <4325A0D9.2000806@gmail.com> <4325AED6.8050401@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 21:11:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFG8h-0006tW-IX
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 21:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965070AbVIMTH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 15:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVIMTH7
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 15:07:59 -0400
Received: from zealot.progeny.com ([216.37.46.162]:35003 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S965070AbVIMTH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2005 15:07:58 -0400
Received: from [192.168.0.101] (pcp961871pcs.brnsbg01.in.comcast.net [68.58.143.126])
	by morimoto.progeny.com (Postfix) with ESMTP
	id 7209D6389E; Tue, 13 Sep 2005 14:07:53 -0500 (EST)
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: cel@citi.umich.edu
In-Reply-To: <4325AED6.8050401@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8480>

I know it's a little picky, but can we be consistently noun-verb-noun 
with these?
I'm not meaning to be a jerk (it just happens unbidden).

My reasons
1) My editor has word completion, which is handy.
2) However unimportant, I'm an old OO guy and object_cmd looks like 
object.command to me.
3) I'm so stupid I need consistent naming to help me learn the git guts.
4) I'm generally a butt about naming anyway 
(http://tottinge.blogsome.com/naming-rules/)
5) I work with a guy who is a stickler for lexicon, and he revived the 
passion for consistency.

> which describes a position in the cache.
>
> +  init_cc

cc_init?

>
> +  next_cc, prev_cc, cache_eof

cc_next, cc_previous

Which is that, cc_to_end or cc_at_end?

> +  next_name

cc_next_name?

>
> +  walk_cache

cache_walk?

The rest of those looked great.  I only listed the ones I was unsure about.


-- 
                             ><>
... either 'way ahead of the game, or 'way out in left field.
