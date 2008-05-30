From: Junio C Hamano <gitster@pobox.com>
Subject: Re: perl/Git.pm: Writing a test suite
Date: Fri, 30 May 2008 13:28:30 -0700
Message-ID: <7v1w3jk041.fsf@gitster.siamese.dyndns.org>
References: <483FB034.3050507@gmail.com>
 <20080530100306.GF18781@machine.or.cz> <484004AB.40008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 22:30:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BEH-0002dw-KK
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYE3U2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYE3U2o
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:28:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYE3U2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:28:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 035272485;
	Fri, 30 May 2008 16:28:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 677CC2484; Fri, 30 May 2008 16:28:37 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE6CB154-2E86-11DD-94B3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83330>

Lea Wiemann <lewiemann@gmail.com> writes:

> 1. Is it OK for the Git.pm tests to be called from the Git test
> scripts but generate different-looking output (since the tests are run
> in Perl)?

Cosmetics.  As long as they are not disproportionally chatty nor too
terse, and correctly catch breakages and stop (if told to with -i) on the
first one, I think it is Ok to be different (e.g. no support for colored
output).

> 2. I might need external test helpers from CPAN at some point.  Is
> that a bad idea because of dependencies, or are we OK with having
> additional dependencies for running the test suite if necessary?

As long as you use the ones that is widely used in Perl world I do not
think it would be a problem.
