From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: Tags
Date: Sun, 03 Jul 2005 18:34:57 -0400
Message-ID: <42C86811.9030906@qualitycode.com>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com> <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com> <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com> <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com> <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com> <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com> <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com> <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com> <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com> <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org> <42C70A5B.9070606@zytor.com> <Pine.LNX.4.58.0507021501450.8247@g5.osdl.org> <42C72B83.6030904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 00:35:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpD42-00047P-GC
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 00:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVGCWfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 18:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVGCWfa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 18:35:30 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:50240 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S261553AbVGCWfY
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 18:35:24 -0400
Received: from [192.168.15.101] (653221hfc195.tampabay.res.rr.com [65.32.21.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id C0B1D3C0F;
	Sun,  3 Jul 2005 22:35:16 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Dan Holmsand <holmsand@gmail.com>
In-Reply-To: <42C72B83.6030904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dan Holmsand wrote:
> So why not add tags to the branch itself?
> 
> It should be pretty straightforward: just make git look for tag refs in, 
> say, a .gittags tree in the current HEAD. The whole thing would pretty 
> much as if you've symlinked .git/refs/tags to .gittags in the current 
> working tree, except that tag refs would have to be read directly from 
> the repository.
> 
> That way, tag refs could be handled pretty much just like any other 
> git-managed file: they can be added, deleted, changed, merged, 
> committed, etc. We could track their history, and see who tagged what 
> and when.

Sounds like the way mercurial handles tags. It really seemed weird to me 
at first, but the more I think about it, the more it makes sense. Even 
more so after reading this thread :-)

   http://www.serpentine.com/mercurial/index.cgi?Tag

Kevin
