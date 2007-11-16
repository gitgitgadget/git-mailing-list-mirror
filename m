From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Fix per-directory exclude handing for "git add"
Date: Fri, 16 Nov 2007 15:05:20 +0000
Message-ID: <80ve82z0wf.fsf@tiny.isode.net>
References: <80ir431xny.fsf@tiny.isode.net>
            <alpine.LFD.0.9999.0711151044150.2786@woody.linux-foundation.org>
            <80ir43e04o.fsf@tiny.isode.net>
            <7vir4341ok.fsf@gitster.siamese.dyndns.org>
            <7vodduzh36.fsf@gitster.siamese.dyndns.org>
            <80y7cy2tay.fsf@tiny.isode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 16:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It2lP-0007hW-KS
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 16:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbXKPPFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 10:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXKPPFa
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 10:05:30 -0500
Received: from rufus.isode.com ([62.3.217.251]:40530 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbXKPPF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 10:05:29 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <Rz2xsQBBVBxC@rufus.isode.com>; Fri, 16 Nov 2007 15:05:22 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Fri, 16 Nov 2007 15:05:20 +0000
X-Hashcash: 1:20:071116:gitster@pobox.com::vyr6QLZtK3ziezzC:00000000000000000000000000000000000000000000B/J+
X-Hashcash: 1:20:071116:torvalds@linux-foundation.org::4PQvkWG1D0i21Qki:000000000000000000000000000000009VSL
X-Hashcash: 1:20:071116:git@vger.kernel.org::FIFOYpwvDYcG5gNn:0000000000000000000000000000000000000000006yOl
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65229>

Bruce Stephens <bruce.stephens@isode.com> writes:

[...]

> I guess really the output of "git status" (or "git runstatus") is
> more significant since that's what we'd normally be running (that's
> presumably what "git gui" and similar tools run, though perhaps they
> use "git ls-files"---probably the underlying code's the same, I
> guess).

Bah.  "git status" also works correctly, I think.  I was just testing
stupidly.

[...]
