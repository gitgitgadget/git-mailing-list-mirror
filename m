From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: Accept -n as a synonym for --dry-run.
Date: Sat, 12 Sep 2009 22:23:47 -0700
Message-ID: <7vd45v2za4.fsf@alter.siamese.dyndns.org>
References: <1252800302-26560-1-git-send-email-nelhage@mit.edu>
 <7vfxar5zsi.fsf@alter.siamese.dyndns.org> <20090913034031.GO4275@mit.edu>
 <20090913035421.GP4275@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 13 07:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmhaK-00059Y-O4
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 07:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbZIMFXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 01:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZIMFXw
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 01:23:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751186AbZIMFXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 01:23:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5391430659;
	Sun, 13 Sep 2009 01:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b185uThOCcJPgjGdxZIdCN4o3Mg=; b=TplX8+
	oYJEk8anJbUHywOcCIEZ2AObbNIyUpRaI8hxhlxLONVupR8/txU09g0EQ7be1KD7
	PGG5p8uN0iC1+9N1KNxPhjAkkz7wvl/ZMZsri1YQXX+GfbWN7CT6nnbOKF4lw+FF
	G8jk+lFCBj6aakyZEBiWZR3waDP+YuNpzubz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySzSVpN+tQLBhHA5FN715/ydndjBCgJM
	tDm0Zz1c7IVW5VwIAYDGbmuMZuP30On6cSgUWjS/ByMxEs3tkwYrvwx2QgFS5ow7
	1tSSgYaTA0lDL2OLDkcor7V4Gg5e1AGC0jAbs5boYQbSKF8sj4AJf2OfqPfABqgR
	mqkbUyw/L2A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 316DB30658;
	Sun, 13 Sep 2009 01:23:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FD9B30657; Sun, 13 Sep
 2009 01:23:48 -0400 (EDT)
In-Reply-To: <20090913035421.GP4275@mit.edu> (Nelson Elhage's message of
 "Sat\, 12 Sep 2009 23\:54\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9FBB02E8-A025-11DE-9883-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128334>

Nelson Elhage <nelhage@MIT.EDU> writes:

> ... I think my
> general argument still stands for commands where that is not the case.

Cool down.

It is a mere subset of what I already said, so you are not arguing against
me at all.

    So the justification should be more like "push does not have any other
    option that deserves a short-and-sweet -n better, it will not have any
    such option in the future, and --dry-run is very often used that it
    deserves to use -n as its short-hand."

and I already said I tend to agree with the first two points.  Indeed the
first point is an absolute truth (the statement is about the current
state).

To answer the second point you need to look into the future, but I do not
foresee us adding a very useful option to the command whose usefulness far
outweigh that of dry-run and whose name begins with 'n' to want to use it
as the short-hand.  In such a case, it is likely that we would try very
hard to find a name that does not begin with 'n' to avoid the issue.
