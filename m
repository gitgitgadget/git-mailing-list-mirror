From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting started contributing.
Date: Sat, 02 Feb 2013 23:49:58 -0800
Message-ID: <7vd2whalax.fsf@alter.siamese.dyndns.org>
References: <1359872508519-7576834.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: adamfraser <adamfraser0@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 08:50:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1uLb-0004FN-P4
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 08:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab3BCHuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 02:50:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab3BCHuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 02:50:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 644515497;
	Sun,  3 Feb 2013 02:50:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zvey7zf+YGnHZtbW+bQBSP00+S8=; b=nDtxG8
	R1kuteYKXenwUTTQmSQgOhoNUxjBUewciXHnKlOaEaCNxLUy+HxZ9XV8oKAaKfeg
	qTkX/MN41Jb1cUmUdr98+mleSXtumVFd3OnrZkLtDDT/tWgYFyBq6HduWMqf18B2
	AAhs+H/b92kjXG7O3/NISPht63Y6OKLB8Umj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=umwsXI4i5Uedhs8/zROyE+31xs7Khp1P
	KKllOlcBIaDQd4mTQJW8WVf26EnbQLrz6YEgrukd6I/HIpUBRNi4CAG6Q9hUQxrI
	pVoc2Vt+fKS5nM9cX6CP5Th8SMes2iDbEg+6yjVNicxLOoI9yeNW7R2Mb6EZ9KUU
	oAEB/+28C10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 545875492;
	Sun,  3 Feb 2013 02:50:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 276CD5491; Sun,  3 Feb 2013
 02:50:02 -0500 (EST)
In-Reply-To: <1359872508519-7576834.post@n2.nabble.com> (adamfraser's message
 of "Sat, 2 Feb 2013 22:21:48 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51769354-6DD6-11E2-8127-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215304>

adamfraser <adamfraser0@gmail.com> writes:

> I've done a little searching and
> haven't been able to find an official bug tracker for git is there somewhere
> I can find some bugs to help fix?

You came to the right place.  A new bug or regression is reported to
this list, and it often is fixed (or often diagnosed as pebcak)
fairly quickly by list regulars.  Nobody maintains a bugzilla that
is not maintained and is full of stale/invalid bug reports.

The best contribution a new person can make is to use the software
regularly and find issues.  It is very hard to find real bugs that
can easily be fixed by somebody totally new to the codebase in Git
these days.

On the other hand, there probably still are many loose ends.  When a
command is supposed to take only two arguments because taking more
than three does not make any sense, for example, it has not been
unusual for us to document the two-argument form of the command,
reject if the user gives only one argument with an error message,
but we simply ignore the third argument if the user mistakenly runs
the command with three arguments, instead of erroring out (i.e. the
code does not bother to help insane or too inexperienced users).
That kind of things are hard to find by users experienced with Git
exactly because they know running such a command with three or more
arguments is nonsense, and they do not even try to make such a
mistake.  Still, it would be very nice to find and fix such issues.

Thanks.
