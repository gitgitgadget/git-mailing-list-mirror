From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 27 Nov 2008 18:06:13 -0800
Message-ID: <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 28 03:07:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5slp-0008UL-6d
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 03:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbYK1CGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 21:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbYK1CGb
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 21:06:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbYK1CGa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 21:06:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C9D6A17A1A;
	Thu, 27 Nov 2008 21:06:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3D93C17A17; Thu,
 27 Nov 2008 21:06:15 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 27 Nov 2008 23:49:40 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2B27A3D6-BCF1-11DD-841E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101857>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I have a strong suspicion that the narrow stuff will make the worktree 
> mess pale in comparison.
>
> Note that I do not have time to review this myself (which is not helped at 
> all by it being no longer a trivial single patch, but a full 10 patches!), 
> but I really have a bad feeling about this.  IMO it is substantially 
> under-reviewed.

Well, "a bad feeling" is not a convincing enough argument either, is it?
What kind of bad interaction are you fearing?

I thought the changes this first half of the topic implements were safe
for people who do not use this feature at all (which is the most important
thing I care about very first), and also I thought they made sense.

A bigger concern I actually have about this series is that the original
author seems to have gone quiet.  I would have expected a discussion on
adding Porcelain level support after the series hit 'next' to begin, so
that the underlying feature can be made more accessible by the end users.
Also a new section to tutorial or a new addition to how-to series of
documents that describe how to work inside narrowly checked out work tree,
what the pitfalls are, etc., together with follow-up improvements of what
is already in 'next', and end user questions and reports on issues should
have come, if this is ever being used by anybody by now, but none of that
has happened.
