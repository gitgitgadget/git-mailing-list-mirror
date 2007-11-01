From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 13:27:55 -0700
Message-ID: <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
	<916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 21:30:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ingfw-000070-E5
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 21:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbXKAU2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 16:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbXKAU2H
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:28:07 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47948 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbXKAU2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 16:28:06 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7D5B22EF;
	Thu,  1 Nov 2007 16:28:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id F3C8D91208;
	Thu,  1 Nov 2007 16:28:18 -0400 (EDT)
In-Reply-To: <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> (Geert Bosch's
	message of "Thu, 1 Nov 2007 15:19:50 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62990>

Geert Bosch <bosch@adacore.com> writes:

> I often type "make clean" as well many "git xyz" commands
> during development, and so it happens that at times, I type
> "git clean" by accident.

Happened to me once.  I hate that command.

> So, I propose *not* converting git clean to a C builtin,
> but instead adding --untracked and --ignored options to
> git-rm.

I think what you are trying to do is to deprecate or remove "git
clean".

I do not know where "git clean" came from.  I am suspecting that
it was to give counterparts to some other SCMs, but do not know
which ones.  Some people wanted to have it --- so you need to
convince them that it is a bad idea first.  Adding an equivalent
options to "git rm" alone does not solve that issue.
