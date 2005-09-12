From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 13:30:22 -0700
Message-ID: <7vwtlm9ggx.fsf@assigned-by-dhcp.cox.net>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
	<7vaciiawrm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509121614140.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chuck Lever <cel@citi.umich.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 22:33:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEuwk-0002Md-BT
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 22:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVILUa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 16:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVILUa1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 16:30:27 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:65255 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932218AbVILUa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 16:30:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912203024.QOOE24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 16:30:24 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509121614140.23242@iabervon.org> (Daniel
	Barkalow's message of "Mon, 12 Sep 2005 16:22:44 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8424>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> * It may make sense to give another param to describe which
>>   cache the caller is talking about so that we can later have
>>   more than one cache at the same time:
>> 
> Wouldn't it be better to only take it in cc_init(), and have the cursor 
> remember what it's iterating through?

Yes.

> I'm actually particularly interested in having a pair of caches for 
> read-tree, because it would actually like to keep the old index separate 
> from the index it's building.

Yes.
