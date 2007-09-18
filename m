From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Mon, 17 Sep 2007 18:09:14 -0700
Message-ID: <7vk5qoye2t.fsf@gitster.siamese.dyndns.org>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	<11900461843997-git-send-email-hjemli@gmail.com>
	<20070918005013.GA6368@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 03:09:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXRai-0006zu-UH
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 03:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbXIRBJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 21:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbXIRBJY
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 21:09:24 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:45568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753869AbXIRBJX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 21:09:23 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5ED4813706B;
	Mon, 17 Sep 2007 21:09:38 -0400 (EDT)
In-Reply-To: <20070918005013.GA6368@muzzle> (Eric Wong's message of "Mon, 17
	Sep 2007 17:50:13 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58520>

Eric Wong <normalperson@yhbt.net> writes:

> Would automatically enabling --no-ff when it detects merging of two (or
> more) SVN branches be a good thing?  We can add scripting support to
> git-svn for detecting if any given commit is really from SVN or not.
> Then we could do something like this in git-merge
>
> ---------------------------- 8< --------------------------------
> if git-svn test-svn-commits "$@"
> then
> 	no_ff=t
> 	no_fast_forward_strategies=$all_strategies
> fi
> ---------------------------- 8< --------------------------------

Yuck, do I understand you correctly?  Are you talking about
adding dependency on git-svn to git-merge?
