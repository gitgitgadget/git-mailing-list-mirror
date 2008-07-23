From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bring description of git diff --cc up to date
Date: Tue, 22 Jul 2008 17:36:43 -0700
Message-ID: <7vfxq1igh0.fsf@gitster.siamese.dyndns.org>
References: <20080722111947.BIW29914@m4500-01.uchicago.edu>
 <7v63qxn8w2.fsf@gitster.siamese.dyndns.org>
 <7vd4l5lio1.fsf@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0807221812470.25746@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSMa-0002pv-C4
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYGWAgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbYGWAgv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:36:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857AbYGWAgv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:36:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 342673770F;
	Tue, 22 Jul 2008 20:36:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 16D9B3770E; Tue, 22 Jul 2008 20:36:45 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.62.0807221812470.25746@harper.uchicago.edu>
 (Jonathan Nieder's message of "Tue, 22 Jul 2008 18:27:18 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7060CED4-584F-11DD-BE2E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89578>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> +	This flag implies the '-c' option and makes the patch output
> +	even more compact by omitting uninteresting hunks.  A hunk is
> +	considered uninteresting if the person merging had two versions
> +	to choose between among all of the parents and the result shows

Hmm, I am not a native speaker, but the above makes me confused into
thinking that even if there are 47 parent versions, it is Ok if I looked
at only two versions and picked from one of them -- the description does
not seem to make it clear that it is required that the other 45 agree with
one of the two I looked at and picked from.

    ... if the contents in the parents had only two variants and the merge
    result picked one of them without modification.

would be succinct enough, perhaps?

If we want to further elaborate, we could say something like:

    In a two-parent merge, by definition, there can only be two variants
    to choose from.  Even in a merge with more than two parents, if some
    parents share the same content, and all the other parents share
    another, same content, there are only two variants to choose from.

but I think that is too verbose...
