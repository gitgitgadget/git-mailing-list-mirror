From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 22:16:17 -0800
Message-ID: <7vabayynda.fsf@gitster.siamese.dyndns.org>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
 <m3prjvdngm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 07:17:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC6lz-0004dD-2N
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 07:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbYLOGQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 01:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbYLOGQZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 01:16:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbYLOGQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 01:16:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E34D187D2;
	Mon, 15 Dec 2008 01:16:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E01AD18818; Mon,
 15 Dec 2008 01:16:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E58368B0-CA6F-11DD-A3CC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103132>

Jakub Narebski <jnareb@gmail.com> writes:

>> [New Topics]
>> 
>> * jn/gitweb-blame (Thu Dec 11 01:33:29 2008 +0100) 3 commits
>>  - gitweb: cache $parent_commit info in git_blame()
>>  - gitweb: A bit of code cleanup in git_blame()
>>  - gitweb: Move 'lineno' id from link to row element in git_blame
>
> I wonder if it should made into 1.6.1 for the performance improvements
> in 'blame' view...

Does is addresses a grave bug?  I thought not.

>> [Post 1.6.1 items]
>> 
>> * gb/gitweb-patch (Sat Dec 6 16:02:35 2008 +0100) 3 commits
>> Updated series.  Reviews and Acks?
>
> I'll try to find time to review (and most probably Ack) later today.

Thanks.

>> * jn/gitweb-utf8 (Mon Dec 1 19:01:42 2008 +0100) 1 commit
>>  + gitweb: Fix handling of non-ASCII characters in inserted HTML
>>    files.
>> 
>> A bugfix.
>
> What about
>
>    + gitweb: Fix bug in insert_file() subroutine

It already is part of 'master' for some time, isn't it?.

>> * jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
> ...
> What happened to this series to be so stale^Wstalled?

Mostly lack of positive feedbacks which is the same thing as "nobody but
the author is interested'.
