From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 16:27:33 -0800
Message-ID: <7v7iif28i2.fsf@gitster.siamese.dyndns.org>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org>
	<200801120026.01930.robin.rosenberg@dewire.com>
	<1973E1D5-C8CC-4979-A085-85A2C5A13E57@sb.org>
	<200801120115.41274.robin.rosenberg@dewire.com>
	<191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:28:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDUEO-0003Pi-BW
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762384AbYALA1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760327AbYALA1o
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:27:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61603 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbYALA1n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:27:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F2E238FF;
	Fri, 11 Jan 2008 19:27:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A890B38FE;
	Fri, 11 Jan 2008 19:27:36 -0500 (EST)
In-Reply-To: <191B60D7-FD89-48D8-8D48-C91645D4814D@sb.org> (Kevin Ballard's
	message of "Fri, 11 Jan 2008 19:25:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70234>

Kevin Ballard <kevin@sb.org> writes:

> Is there a reason for this? It seems like it would be trivial to end
> up with misdiagnosed "untracked" files when using any language other
> than English given this behaviuor.

No.  The assumption of the code has always been that sane
filesystems would return from readdir() the names you gave from
creat().
