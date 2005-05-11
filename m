From: David Greaves <david@dgreaves.com>
Subject: Re: [RFC] Embedding asciidoc manpages in the cg scripts
Date: Wed, 11 May 2005 23:20:10 +0100
Message-ID: <4282851A.2010305@dgreaves.com>
References: <20050511014445.GA14377@diku.dk> <20050511213217.GG22686@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 00:13:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVzS0-0006vp-Kc
	for gcvg-git@gmane.org; Thu, 12 May 2005 00:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVEKWUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVEKWUi
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 18:20:38 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:10940 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261530AbVEKWUX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2005 18:20:23 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 04DA7E6DD3; Wed, 11 May 2005 23:19:06 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04135-19; Wed, 11 May 2005 23:19:05 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.189.224])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 39FA1E6DC6; Wed, 11 May 2005 23:19:05 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DVzYo-0003DB-W8; Wed, 11 May 2005 23:20:11 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050511213217.GG22686@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>> #
>>+# NAME
>>+# ----
>>+# cg-add - add files to a GIT repository
>>    
>>
>
>Half of this is useless, too.
>
>I think you should just keep the first paragraph of the files as it is
>now. Don't touch it, just parse it.
>  
>
A bit harsh Petr.

Isn't the idea of using an already written tool that you don't _have_ to
parse it?
Where, consistently, do the cg-files have a 1 line summary.

>>+#
>>+# SYNOPSIS
>>+# --------
>>    
>>
>No need for this heading either.
>  
>
Actually there is :)
asciidoc won't produce a manpage without it.

>>+USAGE="cg-add FILE..."
>>+#
>>+# DESCRIPTION
>>+# -----------
>> # Takes a list of file names at the command line, and schedules them
>> # for addition to the GIT repository at the next commit.
>>+#
>>+# The command will fail if one of the given files does not exist.
>>+#
>>+# cg-add is part of Cogito, an SCM-like toolkit for managing GIT trees.
>>    
>>
>
>Useless.
>  
>
Yes - if you happen to have written and breathed the code - not so
useless if you're a normal user.

It cogito is ever installed as part of a distro (maybe even by default)
then it would be nice if "man cg-add" actually mentioned it was part of
cogito and git...

>>+#
>>+# OPTIONS
>>+# -------
>>+# No options.
>>    
>>
>
>The rest of DESCRIPTION and OPTIONS looks fine.
>
>I'd just expect you to be much less intrusive in the in-file comments
>and do more work when processing the stuff. I'm commenting on how it
>looks inside of the sources - do whatever is necessary when processing
>it to generate a proper-looking manpage from it.
>  
>
Having worked hard on being consistent throughout the git docs I'd say
that a little excess verbiage in the comments is a worthwhile price. I
don't think you can worry about performance or anything - these _are_
shell scripts!


Maybe you'd be happier if they were moved to the bottom of the file and
preceded with:

#asciidoc follows

Or if you don't like that then maybe keep them external.

David

-- 

