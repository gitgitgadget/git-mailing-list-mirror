From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git for game development?
Date: Tue, 23 Aug 2011 16:32:05 -0700
Message-ID: <7vaaazr9fu.fsf@alter.siamese.dyndns.org>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lawrence Brett <lcbrett@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 01:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw0S9-0005q9-PU
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 01:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139Ab1HWXcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 19:32:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756311Ab1HWXcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 19:32:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22FBB44DC;
	Tue, 23 Aug 2011 19:32:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fWrRU1Aff+O+SdW2KzxNp+G0/QE=; b=O+ClaY
	/thVStGH7Bu8snXGlPME0bLZpa7yf/thI1KZ/QdGqa6g1KZvZjWZdOWKP+bvwlON
	WhdZvFk70rNVi6XBbVYhxl/2fgxW+/TwwkOhLfZfHhg0wHPTq9bCZPsz1lUDOljv
	dZ3XyELeT0pifhKCD9cpBJ7qZThUCYp1r1mHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rxQdZf1e3mnivzGnnAgd5pjDuEDAhpbN
	qvt4pXe0xxld+1mkldA7PuwytkJANCkC5ze9hvoC/JqkSCABCidEn5McX1PsVMMO
	Wuw713dMowGaHeVpnHoEF6UDOhzHXpdhGxSMm5mnNQP1pOCHyjizrgb81sTSak3f
	HVAoiPllNp0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A53C44DB;
	Tue, 23 Aug 2011 19:32:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8846844DA; Tue, 23 Aug 2011
 19:32:08 -0400 (EDT)
In-Reply-To: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com> (Lawrence
 Brett's message of "Tue, 23 Aug 2011 16:06:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E4A868A-CDE0-11E0-83C3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179980>

Lawrence Brett <lcbrett@gmail.com> writes:

> My question for this group is:  would there be interest in incorporating
> this sort of functionality into git core?  I would certainly find it
> compelling as a user, but have no idea how it would fit into the bigger
> picture.

I personally think it is too early for you to ask that question; until you
set up a workable workflow around bup or a combination of bup and git, get
used to its use, and find out what the real pain points are if you used
only git without bup, that is.

Efforts to tweak tools by people who are not yet familiar with the tools
they are trying to use unfortunately often tend to go in wrong directions
and become wasted effort.
