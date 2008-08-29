From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Clarified how pattern works in documentation to
 git-show-ref.
Date: Thu, 28 Aug 2008 22:04:46 -0700
Message-ID: <7vtzd48l8x.fsf@gitster.siamese.dyndns.org>
References: <1219955836-10070-1-git-send-email-gdolley@arpnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Garry Dolley <gdolley@ucla.edu>
To: Garry Dolley <gdolley@arpnetworks.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 07:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYwBL-0001gy-OP
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 07:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbYH2FEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 01:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbYH2FEx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 01:04:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbYH2FEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 01:04:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 264D45522B;
	Fri, 29 Aug 2008 01:04:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 68D7855229; Fri, 29 Aug 2008 01:04:48 -0400 (EDT)
In-Reply-To: <1219955836-10070-1-git-send-email-gdolley@arpnetworks.com>
 (Garry Dolley's message of "Thu, 28 Aug 2008 13:37:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 033EFB90-7588-11DD-87E3-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94251>

Garry Dolley <gdolley@arpnetworks.com> writes:

> Several people in #git, including myself, thought that the following would
> show all refs:
>
>   git show-ref '*'
>
> Since that is not how the pattern patching works, clarification was needed
> in the documentation.
>
> Signed-off-by: Garry Dolley <gdolley@ucla.edu>
> ---
>
> I think including a little more info in the docs regarding the pattern would
> be helpful.  Comments?

Would be helpful.

It may be worthwhile to know that that "pathspec" limiting done by
revision traversal ("git log", "git rev-list") and diff is also without
globbing, but it is a head-match, and match is forced at '/' boundary.

ls-files and grep know how to glob, on the other hand.
