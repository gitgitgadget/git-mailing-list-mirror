From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Linking with -R (rpath) not supported on Darwin
Date: Wed, 03 Oct 2007 14:41:51 -0700
Message-ID: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org>
References: <4D954ADB-E66E-43CA-87EE-7522FFA87370@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBym-0005x0-Q9
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbXJCVl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754597AbXJCVl5
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:41:57 -0400
Received: from rune.pobox.com ([208.210.124.79]:54888 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbXJCVl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:41:56 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 4B15D14123E;
	Wed,  3 Oct 2007 17:42:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A31A814122D;
	Wed,  3 Oct 2007 17:42:14 -0400 (EDT)
In-Reply-To: <4D954ADB-E66E-43CA-87EE-7522FFA87370@lrde.epita.fr> (Benoit
	SIGOURE's message of "Wed, 3 Oct 2007 23:34:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59893>

Benoit SIGOURE <tsuna@lrde.epita.fr> writes:

> It didn't harm but the build process should be more careful to not use
> options that are not supported by the compiler.  And it's not a
> matter of using -Wl,-rpath instead.

As I do not have an access to a Darwin box (nor anybody sent me
a free Mac yet), I do not have any interest in fixing it myself
nor more importantly any means to verify the result.  That makes
it _your_ build process that should be more careful ;-).

You know where -R is coming from and can find out what options
_your_ platform wants, so why not send in a patch _before_
complaining?
