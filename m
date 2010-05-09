From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
 end-of-line conversion
Date: Sun, 09 May 2010 14:57:47 -0700
Message-ID: <7vwrvc91r8.fsf@alter.siamese.dyndns.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <7v632x9dfk.fsf@alter.siamese.dyndns.org> <20100509181853.GA4676@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Sun May 09 23:58:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBEW8-0003aI-Ol
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 23:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab0EIV60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 17:58:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0EIV6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 17:58:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39913B19BE;
	Sun,  9 May 2010 17:58:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UCc89nRRv2yUs7zKHEYYaWtew6Y=; b=oZ6zl7
	S96e5SoKnGhSCc+4npBYQZV5PGSagK4Kb2ATkDO7VzMS46zsUXuHLQTheInounO3
	w5JZT1Eo3CATrwLfbmg68Oos92uuphcAgU1XpOLg1x+v/ThG2DVIKOBB9YYeXan8
	7L9GHd4qcK4esNH0fRyNVlhA/c0yLWfDFS3x8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=szaDhb0PBGevdO6cQimMutmQT+b9lRq/
	O3O2Q9F4OVLehh3bYlTNl86yCAXweR/iTccjegfiXstN6kXIWQ57zob8UjU9mbar
	hJ+FYSkpLefmOrGKpGAPWYuq/a7Vm3EtBK9k6aETlo7MbKVRSjUKZo4tqrT845mN
	QghCpDP2v2k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BCE5B19B5;
	Sun,  9 May 2010 17:58:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0761AB19B0; Sun,  9 May
 2010 17:57:58 -0400 (EDT)
In-Reply-To: <20100509181853.GA4676@pvv.org> (Finn Arne Gangstad's message of
 "Sun\, 9 May 2010 20\:18\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6FDC792-5BB5-11DF-866D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146748>

Finn Arne Gangstad <finnag@pvv.org> writes:

> Are you thinking we could live completely without it?

Yes, and your description makes it sound like it doesn't buy us anything
that an entry '* eolconv=true" in .git/info/attributes wouldn't.
