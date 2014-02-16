From: David Kastrup <dak@gnu.org>
Subject: Re: Profiling support?
Date: Sun, 16 Feb 2014 16:59:50 +0100
Message-ID: <871tz3xd3d.fsf@fencepost.gnu.org>
References: <87d2itc2zv.fsf@fencepost.gnu.org> <87wqgv2hag.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Feb 16 17:00:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF48K-0008Da-BP
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 16:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbaBPP7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 10:59:52 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:45937 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbaBPP7v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 10:59:51 -0500
Received: from localhost ([127.0.0.1]:44978 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WF48E-0006gm-Q8; Sun, 16 Feb 2014 10:59:51 -0500
Received: by lola (Postfix, from userid 1000)
	id 41FDBE067D; Sun, 16 Feb 2014 16:59:50 +0100 (CET)
In-Reply-To: <87wqgv2hag.fsf@thomasrast.ch> (Thomas Rast's message of "Sun, 16
	Feb 2014 16:44:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242226>

Thomas Rast <tr@thomasrast.ch> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Looking in the Makefile, I just find support for coverage reports using
>> gcov.  Whatever is there with "profile" in it seems to be for
>> profile-based compilation rather than using gprof.
> [...]
>> Is there a reason there are no prewired recipes or advice for using
>> gprof on git?  Is there a way to get the work done, namely seeing the
>> actual distribution of call times (rather than iterations) using gcov so
>> that this is not necessary?
>
> No reason I'm aware of, other than that nobody ever wrote it.

A solid testing/benchmarking framework would quite seem like a useful
GSoC project as it would make it easy for casual programmers to dip
their feet into their personal bottlenecks, and it would make it much
easier to find worthwhile hotspots for future projects taking the
challenge of speeding up core and/or specific operations.

> Note that I wouldn't exactly be surprised if the gcov targets had
> bitrotted without anyone noticing.  I haven't heard of any heavy users.
> I originally wrote them to do some basic test coverage analysis, but
> that's about it.

I've managed to make use of the outer sandwich layers: the prepare and
the evaluate stuff.  I ran my own tests for benchmarking though.

It's enfuriatingly hard to get the stuff in the right directories and
with the right options, so that was already more helpful than it
probably should have been.

-- 
David Kastrup
