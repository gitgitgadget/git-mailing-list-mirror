From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Thu, 19 Nov 2009 22:33:05 -0800
Message-ID: <7vmy2h904e.fsf@alter.siamese.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com>
 <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com>
 <20091120013545.GA22556@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Dennie <gdennie@pospeople.com>,
	'Jan =?utf-8?Q?Kr=C3=BCger'?= <jk@jk.gs>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 07:33:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBN3r-0001pm-Fo
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 07:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099AbZKTGdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 01:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbZKTGdL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 01:33:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292AbZKTGdK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 01:33:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8DD28113C;
	Fri, 20 Nov 2009 01:33:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vCtIxJgo8c3oMGrf5KG3ujZrGg4=; b=FNPP1s
	rcoPEXcuHOf5hbCNS3OX1M6jpaNU25JQARPIryubNZYeYO5jD0tPEzr6Sxw2FZ0P
	6udZpK+szjdcmiGbjk9Q5dvGncH/nG0/m8i9hg3BaoRz38R/qAWf7j17ttiVdQY3
	yDgDKZ4d56iY257XyzwdH8wZomYbv/Xn6oZdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ma3n6R0GbNrq7layke0/OeqhyrJsB7pC
	S9kQN4XcTwVleiS045ZATPC2gM13bHx93FrVcrHHvngbAjeSXZUpTvbJNwnppPnS
	VJ7kvjHiqlAqsouJNio9Hj3hPSPPrj+yrraizDyPjWNS81gzAhPr10hIj1K588io
	QkcHif4Yi3c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF05E8113B;
	Fri, 20 Nov 2009 01:33:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D93BC81139; Fri, 20 Nov
 2009 01:33:06 -0500 (EST)
In-Reply-To: <20091120013545.GA22556@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Fri\, 20 Nov 2009 04\:35\:46 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 93151D54-D59E-11DE-8005-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133307>

Dmitry Potapov <dpotapov@gmail.com> writes:

> It is more difficult to make this mistake with Git than many others
> VCSes, because Git shows the list of files that are changed but not
> committed as well as the list of untracked files when you try to commit
> something.

Not really in practice.  Too many people carry their existing practice of
using -m to write a useless single liner commit log message that they
acquired while using their previous SCM.  Arguably, useless log messages
are less of a problem on systems like CVS/SVN because they do not do
useful log summarization such as "log -- paths..." or "shortlog", so they
can be excused for learning the practice in the first place, though.

That incidentally is exactly why earlier we (mostly me and Linus)
recommended people not to teach "commit -m" to new people, but of course
nobody listened ;-).
