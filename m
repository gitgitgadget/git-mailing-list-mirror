From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] solaris test results
Date: Wed, 20 Feb 2008 16:34:25 -0800
Message-ID: <7vk5kz171q.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:35:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRzPG-0002CP-KE
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159AbYBUAer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758006AbYBUAer
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:34:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623AbYBUAeq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:34:46 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 465FD2226;
	Wed, 20 Feb 2008 19:34:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 72ABE2221; Wed, 20 Feb 2008 19:34:32 -0500 (EST)
In-Reply-To: <20080220235944.GA6278@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 20 Feb 2008 18:59:44 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74580>

Jeff King <peff@peff.net> writes:

>   - Sun's diff doesn't understand "-u". I was able to use GNU diff.
>     Since comparing actual and expected output is so common, we could
>     potentially abstract this with a "test_cmp()" function and use
>     something platform specific. It's probably not worth the trouble, as
>     it impacts only the test suite, and only on systems with a totally
>     broken diff.

It is unfair to call diff without -u "totally broken".  It is
not even in POSIX yet IIRC.

>   - t7505 uses a hook which hard-codes /bin/sh but uses syntax that
>     the Solaris /bin/sh doesn't like. Maybe hooks should get their
>     $SHELL value replaced?

You've already did that in your [PATCH 2/3], haven't you?  So
why not?
