From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: lost again on syntax change - local repository?
Date: 28 Nov 2005 05:59:40 -0800
Message-ID: <86veyc6fg3.fsf@blue.stonehenge.com>
References: <861x118r9t.fsf@blue.stonehenge.com>
	<20051128104831.GN22159@pasky.or.cz>
	<86d5kk7wbv.fsf@blue.stonehenge.com>
	<20051128134111.GP22159@pasky.or.cz>
	<86zmno6g3v.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 15:02:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgjXl-00046Z-6G
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 14:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVK1N7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 08:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVK1N7m
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 08:59:42 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:3479 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751262AbVK1N7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 08:59:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id E4C8C8F75E;
	Mon, 28 Nov 2005 05:59:40 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29001-01-6; Mon, 28 Nov 2005 05:59:40 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 83DCF8F7AB; Mon, 28 Nov 2005 05:59:40 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.12.15.0; tzolkin = 11 Ahau; haab = 18 Ceh
In-Reply-To: <86zmno6g3v.fsf@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12881>

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal>     localhost:..Git/Play/local.git % cg-branch-add origin "$(cd ..; pwd)/remote.git#master"           
Randal>     localhost:..Git/Play/local.git % cg-push
Randal>     WARNING: I guessed the host:path syntax was used and fell back to the git+ssh protocol.
Randal>     WARNING: The host:path syntax is evil because it is implicit. Please just use a URI.
Randal>     ssh: \033]2;[zsh] localhost: No address associated with nodename
Randal>     fatal: unexpected EOF

Oh, and make sure ssh is *off* on your machine.  You might be getting
it to work by ssh'ing back to your own box.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
