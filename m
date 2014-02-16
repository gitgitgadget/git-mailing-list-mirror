From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Profiling support?
Date: Sun, 16 Feb 2014 17:54:51 +0100
Message-ID: <87mwhr2e1w.fsf@thomasrast.ch>
References: <87d2itc2zv.fsf@fencepost.gnu.org> <87wqgv2hag.fsf@thomasrast.ch>
	<871tz3xd3d.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 16 17:54:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4za-0003NJ-UE
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbaBPQyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:54:55 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:50510 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbaBPQyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:54:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id B84CC4D64E6;
	Sun, 16 Feb 2014 17:54:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id j8beyWxhFBzK; Sun, 16 Feb 2014 17:54:53 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B4F244D64BD;
	Sun, 16 Feb 2014 17:54:52 +0100 (CET)
In-Reply-To: <871tz3xd3d.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Sun, 16 Feb 2014 16:59:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242237>

David Kastrup <dak@gnu.org> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Looking in the Makefile, I just find support for coverage reports using
>>> gcov.  Whatever is there with "profile" in it seems to be for
>>> profile-based compilation rather than using gprof.
>> [...]
>>> Is there a reason there are no prewired recipes or advice for using
>>> gprof on git?  Is there a way to get the work done, namely seeing the
>>> actual distribution of call times (rather than iterations) using gcov so
>>> that this is not necessary?
>>
>> No reason I'm aware of, other than that nobody ever wrote it.
>
> A solid testing/benchmarking framework would quite seem like a useful
> GSoC project as it would make it easy for casual programmers to dip
> their feet into their personal bottlenecks, and it would make it much
> easier to find worthwhile hotspots for future projects taking the
> challenge of speeding up core and/or specific operations.
>
>> Note that I wouldn't exactly be surprised if the gcov targets had
>> bitrotted without anyone noticing.  I haven't heard of any heavy users.
>> I originally wrote them to do some basic test coverage analysis, but
>> that's about it.
>
> I've managed to make use of the outer sandwich layers: the prepare and
> the evaluate stuff.  I ran my own tests for benchmarking though.

Umm, are we even discussing the same thing here?

Are you saying you ran profiling-instrumented code under the t/perf/
support code?  Sounds nice...

-- 
Thomas Rast
tr@thomasrast.ch
