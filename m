From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 14:51:18 -0700
Message-ID: <7v8x5hab3d.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
	<7v4pg5btis.fsf@gitster.siamese.dyndns.org>
	<200711012232.57286.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:51:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inhx3-0007Mn-ND
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbXKAVv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754033AbXKAVv3
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:51:29 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:34956 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbXKAVv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:51:28 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3771D2F0;
	Thu,  1 Nov 2007 17:51:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 929C691285;
	Thu,  1 Nov 2007 17:51:43 -0400 (EDT)
In-Reply-To: <200711012232.57286.johan@herland.net> (Johan Herland's message
	of "Thu, 01 Nov 2007 22:32:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63019>

Johan Herland <johan@herland.net> writes:

> What about making "git clean" _stash_ your changes instead of deleting them 
> (so that you can undo the clean)? Preferably they should be stashed 
> somewhere _other_ than where "git stash" does its thing. "git clean" could 
> even delete the stash immediately, but keep the reflog around so that 
> the "clean" at least could be undone within 30 days (or whatever is the 
> current default).
>
> Thoughts?

Unthoughts.  That does not mesh with the way how world works.

"git clean" is about things that git usually do not care about
(i.e. things not in .gitignore, or even in .gitignore when -x is
given).  Everything else including "git stash" is all about what
git cares about (i.e. tracked paths).
