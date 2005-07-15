From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] tagger id
Date: Thu, 14 Jul 2005 18:36:33 -0600
Message-ID: <m14qawzyzy.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
	<m1slyk63k2.fsf_-_@ebiederm.dsl.xmission.com>
	<m18y0c1prv.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507121152260.17536@g5.osdl.org>
	<m1pstnzn5j.fsf@ebiederm.dsl.xmission.com>
	<loom.20050713T011619-369@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 02:37:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtECH-0000pL-7Q
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 02:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVGOAgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 20:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVGOAgx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 20:36:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64188 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262872AbVGOAgw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 20:36:52 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F0aciQ020245;
	Thu, 14 Jul 2005 18:36:38 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F0aXJ5020244;
	Thu, 14 Jul 2005 18:36:33 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@twinsun.com>
In-Reply-To: <loom.20050713T011619-369@post.gmane.org> (Junio C. Hamano's
 message of "Tue, 12 Jul 2005 23:42:13 +0000 (UTC)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@twinsun.com> writes:

> I am afraid I do not follow you.  

I was confused.  My big problem was that we don't really have
an in tree user, and there wasn't a good explanation anywhere.  So it
was hard to track this down. 

I'm going to lobby for a script to import patches from email being
in the git tree just so people can see how this is done, and probably
because there are a lot of people who have been reinventing this
script :)

> The intent of "tags" (especially the signed kind) is to express "trust":
> "This commit is called v2.6.12 and *I* vouch for it."
>
> COMMITTER is the only sensible thing to use there, because (as you said)
> what you care is "who I am", not "for whom I am doing this"

Sounds good.

Eric
