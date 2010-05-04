From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Global .git directory
Date: Tue, 04 May 2010 09:55:29 -0700
Message-ID: <7vsk67mwse.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
 <201004271159.34071.trast@student.ethz.ch>
 <alpine.LFD.2.00.1004272144470.11216@bbs.intern>
 <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com>
 <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
 <q2k40aa078e1004280550o322dc5b8jca74d401a5eb1abe@mail.gmail.com>
 <alpine.LFD.2.00.1004282211431.29101@bbs.intern>
 <alpine.LFD.2.00.1005040705470.4835@bbs.intern>
 <20100504054040.GC13139@goomba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerhard Wiesinger <lists@wiesinger.com>, git@vger.kernel.org,
	kusmabite@gmail.com, Thomas Rast <trast@student.ethz.ch>
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Tue May 04 18:55:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9LPU-0006MZ-Bk
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab0EDQzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 12:55:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab0EDQzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 12:55:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB701B0F30;
	Tue,  4 May 2010 12:55:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UQNRZlA42fTyg8vbJDgW3yTifJs=; b=qaDo2E
	nzMoPyl+E6IOU5iCaeN+OEn9HE5A3XANcIZKXpBoUhA4L8cgSaVklU+s704kUmc+
	eJz7/TwdigKXFmGpoJqet2hMMDaIuZ3OYlGbBm4LLzrQEZpr5KO1zQLZIRebjaaz
	Zg0nawi6YP9ypQwRBswNKLwoXT3W8MAgVXEMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PTsOTKU124TeDbwRUNtir8aX2zyJLQ04
	g7fh3sfKdEpv1mQbQ+jbf7llEB47LCjF/K0I+71J4iJvW0cjCJGsCM0f7VLjjfCC
	GYfgW7fsSfrJjFL/rEQkjcESRqz2W86LssxqPU9y1M9vXvp6Mje8qu+tVe10haDc
	bPmQtG70d/0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 796ACB0F2F;
	Tue,  4 May 2010 12:55:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 533C9B0F2A; Tue,  4 May
 2010 12:55:30 -0400 (EDT)
In-Reply-To: <20100504054040.GC13139@goomba> (Andrew Ruder's message of
 "Mon\, 3 May 2010 22\:40\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC724B94-579D-11DF-B072-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146327>

Andrew Ruder <andy@aeruder.net> writes:

> I'm not really a person that will be doing the reviewing but as a
> frequent lurker on the list, I'm going to try to help you out some.

Thanks.

> While you're not exactly fixing a bug, this would benefit from a
> testcase.

Just so that people do not misunderstand.  A test is _not_ about proving
that your patch fixed a bug.  It instead is to protect your change from
future breakages by _other people_.

Having a test that would fail if careless others muck with related
codepath in the future without taking your change into account is a good
way to make sure your new feature or your good change of behaviour keep
working (the alternative is for you as the author of such a valuable
change to stay on the list 24/7, audit all the patches that may negatively
affect your change and veto them before they are applied, which is
impractical for most people).
