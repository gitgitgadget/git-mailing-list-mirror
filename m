From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Wed, 19 Mar 2014 11:53:06 -0700
Message-ID: <xmqqwqfq2f71.fsf@gitster.dls.corp.google.com>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
	<53240C0F.2050204@web.de>
	<xmqqha6wg3o1.fsf@gitster.dls.corp.google.com>
	<906CACC0-FB16-4BB8-812D-59067DE0CC89@quendi.de>
	<xmqqlhw65dcq.fsf@gitster.dls.corp.google.com>
	<0CF0981E-FFF8-4A38-B690-17826686BEA6@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Mar 19 19:53:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQLc4-0005a6-7I
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 19:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbaCSSxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 14:53:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33030 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbaCSSxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 14:53:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2861274C9A;
	Wed, 19 Mar 2014 14:53:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3lszXc5fKxAx2s1B+WJpyJDICug=; b=NYiNym
	v97u6cNYpAAJXoGfnBFY0GA1ki+lzBP7ZQwVzsSMkpadPZQq9RGrx2IDU/60t9L3
	eZh+OrlHU2U8FaQud4KGVEDbHCqixC9HHkicbNh5kBU9yxAyeQHHhnUCWFCssk0V
	OMsnWHjSj/hwQf41unywrfWHpe81Ap+Y+kiKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o1g8DZfNQfc8XnY0qtOmh+FP1zJKvR+W
	C4wM8nB+ThZk4X7gDzTvALWGkysAlLyeXCN7FLr+63vuBG9+QlqXBF5ngER8NCbK
	46eWNXrSfFtGaPXwHIlRcygAwcUaF9xnMTnnflYU/GUyrHXgR3Mals4JzRu8KqzB
	PHqwM41m+j4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11EA674C99;
	Wed, 19 Mar 2014 14:53:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62E1F74C98;
	Wed, 19 Mar 2014 14:53:08 -0400 (EDT)
In-Reply-To: <0CF0981E-FFF8-4A38-B690-17826686BEA6@quendi.de> (Max Horn's
	message of "Wed, 19 Mar 2014 18:21:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B644FBDC-AF97-11E3-9183-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244477>

Max Horn <max@quendi.de> writes:

> So, one more silly (bikeshedding) question: should I do this as one big
> patch adding multiple xfail tests - or one commit per test, with perhaps a
> brief description of the issue at hand? Or should a code comment next to
> the failing test explain things?

Judging from the next paragraph, one patch per issue sounds like a
good organization to help those who would want to fix these issues.

> Actually, some of those bugs might require a lengthy background
> explanation, so yet another variant would be to write an email here
> With an explanation, then add a gmane ref to the commit message...

Please first try to find a way that does not need any external
references---not everybody is always online.  A two-page description
in the log message for a new five-line test_expect_fail piece is
perfectly fine.
