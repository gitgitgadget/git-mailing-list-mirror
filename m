From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 01:50:23 -0800
Message-ID: <7vipie85nk.fsf@alter.siamese.dyndns.org>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
 <87k42vs8pi.fsf@thomas.inf.ethz.ch>
 <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
 <1331202483.21444.11.camel@beez.lab.cmartin.tk>
 <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
 <1331203321.21444.13.camel@beez.lab.cmartin.tk>
 <CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
 <7vlinbdkb0.fsf@alter.siamese.dyndns.org> <vpq1up3aqk8.fsf@bauges.imag.fr>
 <7vty1ydh7p.fsf@alter.siamese.dyndns.org> <vpqr4x26vyp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Morton <jeremy@configit.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 09 10:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5wT1-0004sT-CR
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 10:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab2CIJu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 04:50:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39488 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab2CIJuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 04:50:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 662B151BD;
	Fri,  9 Mar 2012 04:50:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zttP/ICWl1d5OHalR6LmtLQPM9Y=; b=pINp9zoD6GHoKmH2rjgE
	VvZXa5q2Cw0QwJ+H8i2NzbTX1LzKJ6KOzQ9Ulolurogxrh1mTrwRHlo0F3YHk5uy
	vBg0SZPcHtHlGZoeyIcJCQUoPrv3CvSyIOccmhHBbAEx/gYtp9O1f2QggGrLxUwQ
	6m2V7meYrAs9Vgh8PIGlJ3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=O7Ks3T2EgQ/jGbfiFeoXrW2xeQFp/2xuiN5cPEIjHr6EAv
	Afs2l29cDVVmTtN4w4bOpj1LTsigm4bhT7h6uNd1dM9O0HQAbntjVNdSdg7tE90f
	8ZB6XoLzg6AQp3bQ/GgZ6eljNmvU46j7MeyBMhObRi7neJD+zZb31WoQq7iHs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DBD451BC;
	Fri,  9 Mar 2012 04:50:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAA4D51BB; Fri,  9 Mar 2012
 04:50:24 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B2F1F2E-69CD-11E1-955E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192702>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> And regardless of the danger, if I look around me, I see almost only
> people working with shared archives, and a few projects (including Git,
> obviously) using the "one commiter per repository" workflow (I teach Git

These days, you do not have to even go to kernel.org to find people
and projects that use "publish to be pulled" model.  I hear that
there is a popular site called GitHub where people create their own
fork, publish their work there and ask the project they forked from
to pull their work.

By the way, don't we ask the workflow used by the users in the
annual user survey?

> to 200 students and several colleagues every year, I've tried teaching
> the "one public repository per developer" and it was a complete disaster).

Interesting.  I have a couple of questions.

Who are these 200 people and what do they do with Git?  If the
answer is "They work on a class assignment project, 20 teams of 10
members each", I would count that as a datapoint that represents one
project among thousands of projects that use Git.

I am also curious to learn a bit more about "a complete disaster",
even though this question (and its answer) would not be directly
relevant to this topic, as nobody is trying to convert projects to
use the "publish to be pulled" model when the "push to the shared
central repository" model is more appropriate for them.
