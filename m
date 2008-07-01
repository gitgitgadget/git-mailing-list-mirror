From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Some superficial documentation changes
Date: Tue, 01 Jul 2008 01:42:54 -0700
Message-ID: <7viqvqov01.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 01 10:44:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDbT6-0007v6-Nd
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 10:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbYGAInL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 04:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbYGAInL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 04:43:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35683 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbYGAInJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 04:43:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB6581D379;
	Tue,  1 Jul 2008 04:43:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E589F1D376; Tue,  1 Jul 2008 04:43:01 -0400 (EDT)
In-Reply-To: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu> (Jonathan
 Nieder's message of "Mon, 30 Jun 2008 16:56:56 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA8155CC-4749-11DD-B974-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87008>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> But at least I was able to check that patch 6/7 (which redistributes the
> dashes in the world) doesn't touch anything but spaces and hyphens.
> Hopefully that should make this easier to review.

Yes, the earlier "line break adjustments" patch really helped.

I've queued all of them to 'pu' while reading them over, except for the
last one.  I did not look very carefully, but the parts I did look at made
sense.

In general, I've always preferred to see command names "git-foo" typeset
in teletype face, consistent with examples (also typeset in tt), because
they are both something the end users are expected to type.  With this
transition, we are however making "git-foo" not something users are
expected to type, which means that the use of a typeface that is different
from the body text to spell command names is now strictly for making them
stand out in context.  In that sense, I share your hesitation about the
last one to use tt for command names.  It probably is better to use italic
now.

On my next git day (coming Wednesday, if nothing goes wrong at day job),
I'll merge all except the last one to 'master' so that the HTML version of
the manual page k.org serves to the general public is updated and we can
get a wider exposure to looking for conversion errors more easily.  If you
also prefer 'italics' and list agrees, it might be a better idea to also
apply that patch when I do so, as that step is the most error prone one
and benefits from more eyeballs.

Thanks. 
