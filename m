From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9700-perl-git.sh: Fix a test failure on Cygwin
Date: Wed, 30 Dec 2009 22:49:54 -0800
Message-ID: <7vbphfzlgt.fsf@alter.siamese.dyndns.org>
References: <4B059150.5050303@ramsay1.demon.co.uk>
 <20091230224023.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 07:50:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQErQ-0003Ov-5n
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 07:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbZLaGuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 01:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbZLaGuH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 01:50:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbZLaGuG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 01:50:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A30EE8CDD5;
	Thu, 31 Dec 2009 01:50:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jDQqvwhtXWqf3yRVu8xLu2MeZIg=; b=r0vSlU
	/YBKSnDTUPLeuhtSuDG8rhCD8bEWSJ3vuoRtevpKvKkL9lTKxEe/xy19lK1St8it
	slPlZYZBzrE5RvKxbDX9/RTY1vlhG435MjX7R6QvwEdtHAlzD+nGlB4Um8TTcwZM
	NcqMoFkrCfvDZYl5TRSN7tBORe3+vT0yKjLpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HvGl68G8LGqKIT1u0S5LeqjyJbThr8wc
	3PpPoVxk3elcQBPaEiqkCPchRFSMDRGwxct9l4abiXBQp8KbRd93mbOsH50RjOcH
	+v2+P+g5av/h4XPJy9lNZuL4K+rU8a7WmXgQVcPFqeObQfQC9H9Wjwj6LtXyYJpd
	Mf/S3jAJ8FY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F7A38CDCB;
	Thu, 31 Dec 2009 01:50:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 884578CDCA; Thu, 31 Dec
 2009 01:49:55 -0500 (EST)
In-Reply-To: <20091230224023.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 30 Dec 2009 22\:40\:23 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B73AC422-F5D8-11DE-AA5D-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135934>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?

Hmph, I think we have it as 81f4026 (t9700-perl-git.sh: Fix a test failure
on Cygwin, 2009-11-19).
