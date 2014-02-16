From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Profiling support?
Date: Sun, 16 Feb 2014 16:44:55 +0100
Message-ID: <87wqgv2hag.fsf@thomasrast.ch>
References: <87d2itc2zv.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 16 16:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF3uZ-0000El-Bx
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 16:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbaBPPpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 10:45:11 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:50281 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbaBPPpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 10:45:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 812BC4D6584;
	Sun, 16 Feb 2014 16:45:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xU7PedL4wJ2p; Sun, 16 Feb 2014 16:44:58 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9E5C04D64BD;
	Sun, 16 Feb 2014 16:44:58 +0100 (CET)
In-Reply-To: <87d2itc2zv.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 11 Feb 2014 12:17:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242225>

David Kastrup <dak@gnu.org> writes:

> Looking in the Makefile, I just find support for coverage reports using
> gcov.  Whatever is there with "profile" in it seems to be for
> profile-based compilation rather than using gprof.
[...]
> Is there a reason there are no prewired recipes or advice for using
> gprof on git?  Is there a way to get the work done, namely seeing the
> actual distribution of call times (rather than iterations) using gcov so
> that this is not necessary?

No reason I'm aware of, other than that nobody ever wrote it.

Note that I wouldn't exactly be surprised if the gcov targets had
bitrotted without anyone noticing.  I haven't heard of any heavy users.
I originally wrote them to do some basic test coverage analysis, but
that's about it.

-- 
Thomas Rast
tr@thomasrast.ch
