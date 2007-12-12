From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] "diff --check" should affect exit status
Date: Wed, 12 Dec 2007 01:16:20 -0800
Message-ID: <7vmysg8e8r.fsf@gitster.siamese.dyndns.org>
References: <1197447122-93416-1-git-send-email-win@wincent.com>
	<1197447122-93416-2-git-send-email-win@wincent.com>
	<1197447122-93416-3-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:17:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Ni5-00052B-Th
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757255AbXLLJQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 04:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756601AbXLLJQf
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:16:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbXLLJQe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:16:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DFDB644B;
	Wed, 12 Dec 2007 04:16:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A146644A;
	Wed, 12 Dec 2007 04:16:27 -0500 (EST)
In-Reply-To: <1197447122-93416-3-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Wed, 12 Dec 2007 09:12:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68018>

Wincent Colaiuta <win@wincent.com> writes:

> "git diff" has a --check option that can be used to check for whitespace
> problems but it only reported by printing warnings to the
> console.

The primary use of this option used to be to see where the breakages are
in order to fix them up (IOW, the option was not about seeing if
breakage exists or not), but that is much easier with --color output
these days.

It is probably a good idea to do this, although I do not care much about
it either way.  It probably could replace the sample pre-commit hook
currently implemented in Perl.  As I happen to be fairly familiar with
the area, I'll take a look at the patch if/when I find time.

Thanks.
