From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Git GSoC 2014
Date: Fri, 14 Feb 2014 08:26:52 +0100
Message-ID: <87vbwi6toj.fsf@thomasrast.ch>
References: <20140213091037.GA28927@sigill.intra.peff.net>
	<87bnya8z6q.fsf@thomasrast.ch>
	<xmqqk3cyk4oz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 08:27:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEDB2-0005aN-K2
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 08:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaBNH1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 02:27:06 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:45578 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbaBNH1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 02:27:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 081F24D6510;
	Fri, 14 Feb 2014 08:27:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sdDFdzvmmWTi; Fri, 14 Feb 2014 08:26:53 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EBD314D64BD;
	Fri, 14 Feb 2014 08:26:52 +0100 (CET)
In-Reply-To: <xmqqk3cyk4oz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Feb 2014 14:50:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242090>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> Downside: not listing "code merged" as a goal may not make the project
>> as shiny, neither for Git nor for the student.
>
> I'd actually view that as an upside. This sounds like a good first
> step for a feasibility study that is really necessary.
>
> I wonder why the handling of storage corruption and replacement
> could be left broken, though. Is that because libgit2 has known
> breakages in these areas, or is there some other reason?

It's because I don't know enough about what libgit2's state is, and I
wanted to keep the scope limited.  Naturally, the next step would then
be to implement the lacking functionality (if any) in libgit2 so that
the test suite passes.  I just don't know if that's trivial, or
something for the "if we have time" section of the project, or too much
work.

(I did do a quick "can we reasonably link against libgit2" test where I
gave git-cat-file a --libgit2 option that loads blobs with libgit2.
There are some name collisions in the git_config* identifiers that need
to be resolved, but otherwise it seems entirely possible.)

-- 
Thomas Rast
tr@thomasrast.ch
