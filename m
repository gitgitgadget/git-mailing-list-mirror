From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Troubles building man pages
Date: Mon, 31 Aug 2009 19:44:41 -0700
Message-ID: <7v7hwjidt2.fsf@alter.siamese.dyndns.org>
References: <4A9C8750.60308@lists.schang.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Brian S. Schang" <git@lists.schang.net>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:45:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiJNK-0003cN-Dx
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 04:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbZIACor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 22:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbZIACor
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 22:44:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZIACor (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 22:44:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A985120DB3;
	Mon, 31 Aug 2009 22:44:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VROWL1EJjyfs+AuYa64hLr0euNU=; b=D0HTb1
	KBtg5wi2kme7QyNY+Fjxhjs0rSsKf38ITF7fnmCoCbN0IQZZk0yz3YHAlU4nO6EC
	LuIM0R96XiVs0F2Fl/cw3P1NsYxswSYi04SBQwd6psuritpTg69aJ/f2MEggNKF1
	bRgVqk0cvOqORwzmS0o9jv9ckpOyrd4IY5/pE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RMYKCLmSrR7YqHul/0lfwQ3Dctj/ReVP
	gB12+/Y8hIy9+p/Q+nVC0xK6cPgJsz/g8nKj4Z65sWeiNspx+SmgpBKxN/AcjXsl
	VbeNsx7QQNXvzziYCF7ReA4qLRHrR7uqWyCig1R7IoLzJPNaZn6wwkSbYkItkNzp
	Zbiy1YGV3Yo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 850D120DB2;
	Mon, 31 Aug 2009 22:44:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E03DB20DB1; Mon, 31 Aug
 2009 22:44:43 -0400 (EDT)
In-Reply-To: <4A9C8750.60308@lists.schang.net> (Brian S. Schang's message of
 "Mon\, 31 Aug 2009 22\:30\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 691D53FE-96A1-11DE-BF78-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127515>

"Brian S. Schang" <git@lists.schang.net> writes:

>>     ASCIIDOC git-am.xml
>>     XMLTO git-am.1
>> I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd
>> /raida/packages/git/Documentation/git-am.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
>> D DocBook XML V4.2//EN" "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd"
>
> I have read through INSTALL and Documentation/README. I have tried to
> cover all dependencies, but I suspect that I'm missing something
> simple.
>
> Note that 'git' itself compiles fine and I can build the HTML pages
> fine also. It seems to be the man pages that cause the problem.
>
> Note that I am using openSUSE 11.1. I was able to build the man pages
> on my older openSUSE 11.0 machine, but not any longer.

The following was an ancient experience of mine with a different distro
but I am reasonably sure it would point you in the right direction.

    http://article.gmane.org/gmane.comp.version-control.git/107387
