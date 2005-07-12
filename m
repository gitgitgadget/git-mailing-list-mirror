From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 20:39:47 -0600
Message-ID: <m11x647nnw.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
	<m1eka574c8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
	<m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 04:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsAjs-0007i5-68
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 04:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVGLCm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 22:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVGLCmP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 22:42:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33938 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261899AbVGLCj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 22:39:58 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6C2dlFh021680;
	Mon, 11 Jul 2005 20:39:47 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6C2dlvl021679;
	Mon, 11 Jul 2005 20:39:47 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507111815180.17536@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 11 Jul 2005 18:15:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 11 Jul 2005, Eric W. Biederman wrote:
>> 
>> Actually I was looking at doing a git-ident thing that will
>> just compute who git thinks you are.  And then git-commit-tree can
>> just popen it to share code.  That looks like how the logic has
>> been accomplished in other places.
>
> I hate popen() if there's a reasonable functional interface in a library.
> popen() is damn inefficient for doing something like this that is all C 
> anyway.

Ok two new files then.  The new library function, and then
the utility that calls it.

Eric
