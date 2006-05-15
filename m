From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 09:54:36 -0600
Message-ID: <m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
	<7v64k7wzzf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:55:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FffPl-0002so-1o
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWEOPzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWEOPzO
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:55:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46046 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751567AbWEOPzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 11:55:12 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4FFsbpA009102;
	Mon, 15 May 2006 09:54:37 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4FFsaqV009101;
	Mon, 15 May 2006 09:54:36 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64k7wzzf.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 14 May 2006 23:42:28 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20059>

Junio C Hamano <junkio@cox.net> writes:

> "Brown, Len" <len.brown@intel.com> writes:
>
>>  
>>>	git whatchanged A
>>
>> thanks.  I've used this on entire repos before, but
>> for some reason didn't think of this command name
>> when looking for individual file history.
>
> Probably with recent enough git, one of
>
> 	git log --stat -- A
> 	git log -p -- A
> 	git log -p --full-diff -- A
>
> might be more pleasant, depending on what you are trying to look
> for.
>
> "A" can be a single file, more than one files, a directory,...

So that it has a chance of being remembered, and eventually fixed
the man pages of git-whatchanged and git-log only sort of tell you
that this is even possible.  git-whatchanged is certainly worse,
but I don't think if I didn't know to look for it I could see the
fact that these commands take path names from looking at their
man pages.

Eric
