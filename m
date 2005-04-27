From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: git add / update-cache --add fails.
Date: Wed, 27 Apr 2005 13:38:31 -0400
Message-ID: <87r7gwf7c8.fsf@coraid.com>
References: <200504260726.04908.rhys@rhyshardwick.co.uk>
	<E1DQcOc-00054l-00@gondolin.me.apana.org.au>
	<87ll74go7o.fsf@coraid.com> <20050427173059.GE22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 19:40:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQqV3-0002uu-6z
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 19:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVD0RnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 13:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVD0Rm7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 13:42:59 -0400
Received: from ns1.coraid.com ([65.14.39.133]:5037 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261856AbVD0Rme (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 13:42:34 -0400
Received: from coraid.com ([205.185.197.207]) by coraid.com; Wed Apr 27 13:39:56 EDT 2005
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427173059.GE22956@pasky.ji.cz> (Petr Baudis's message of
 "Wed, 27 Apr 2005 19:30:59 +0200")
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> writes:

...
>> +		fprintf(stderr, "update-cache Error: %s\n", strerror(errno));
...
> FWIW, I have this in my tree for some time already. :-)

OK, nice.

...
>
>> By the way, I created that patch with "git diff" in my git-pasky
>> working directory.  Strangely, I had to redirect standard error to the
>> same place as standard output in order to get the filename in the diff
>> output.  I didn't check why the filename is on standard error,
>> though.
>
> Interesting. Anyway, you are apparently using some quite antique
> git-pasky version.

It wasn't on purpose!  :)

Thinking back, my "git pull" probably didn't merge correctly because
it was too old.  I'll just blow away the old one and start over.

-- 
  Ed L Cashin <ecashin@coraid.com>

