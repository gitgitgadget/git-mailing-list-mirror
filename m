From: johnnyutahh <git.nabble.com@johnnyutahh.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Tue, 13 Dec 2011 20:54:52 -0800 (PST)
Message-ID: <1323838492627-7092383.post@n2.nabble.com>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com> <BANLkTimTszUC+4d3tMTP-cxG3AoWmr08HA@mail.gmail.com> <20110418004550.GA2529@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 05:54:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ragrq-0002pW-Lq
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 05:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714Ab1LNEyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 23:54:54 -0500
Received: from sam.nabble.com ([216.139.236.26]:57628 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753216Ab1LNEyx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 23:54:53 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <git.nabble.com@johnnyutahh.com>)
	id 1Ragrk-0003pg-LM
	for git@vger.kernel.org; Tue, 13 Dec 2011 20:54:52 -0800
In-Reply-To: <20110418004550.GA2529@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187093>

Following up on 
http://git.661346.n2.nabble.com/Tracking-file-metadata-in-git-fix-metastore-or-enhance-git-td6251248.html
this discussion re: git file-metadata-management , posted this:

http://superuser.com/questions/367729/how-to-reuse-extend-etckeepers-metadata-engine-for-git-control-of-non-etc-file

Any further movement on this topic?



Jonathan Nieder-2 wrote
> 
> Hi again,
> 
> Not sure if my thoughts will be useful here since you dropped me from
> the cc list.  But anyway:
> 
> Richard Hartmann wrote:
> 
>> here are the three options:
>>
>> 1) fix metastore
>> 2) default to gitperms
>> 3) extend git
>>
>> I still think 3) would be best, but someone would need to step up to
>> do this. Is anyone up for this task? If not, we will have to resort to
>> 1) or 2)
> 
> The usual practice in git development is
> 
>  (1) people make scripts wrapping plumbing commands (see git(1)) that
>      work well for themselves
>  (2) they tell the git list about it and publish it
>  (3) an idea emerges that this is suitable for inclusion, and it
>      gets included
> 
> In particular, git's design is not so monolithic --- "extend git" can
> mean "add a script" or "add a builtin" so it is not so involved as you
> seem to think.  See also contrib/README for a place to stop on the
> way.
> 
> Anyway, if you want something the just works, my suggestion is (4) use
> the hook scripts from etckeeper.  Last time I looked into this they
> worked better than metastore.
> 
> Hope that helps.
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@.kernel
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--
View this message in context: http://git.661346.n2.nabble.com/Tracking-file-metadata-in-git-fix-metastore-or-enhance-git-tp6251248p7092383.html
Sent from the git mailing list archive at Nabble.com.
