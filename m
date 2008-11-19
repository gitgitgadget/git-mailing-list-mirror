From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Tue, 18 Nov 2008 17:51:30 -0800
Message-ID: <7vtza4trdp.fsf@gitster.siamese.dyndns.org>
References: <20081118211237.234d8035@crow>
 <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
 <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 02:53:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2cFm-0008PL-0d
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 02:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbYKSBv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 20:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbYKSBv6
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 20:51:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbYKSBv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 20:51:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 180451700C;
	Tue, 18 Nov 2008 20:51:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E332E16FFA; Tue,
 18 Nov 2008 20:51:36 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 19 Nov 2008 02:07:41 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A5402754-B5DC-11DD-834D-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101304>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It may be a traditional wart, but a helpful one.  Remember, you can also 
> say:
>
> 	git commit that/directory/
>
> I do _not_ want Git to add all untracked (and unignored) files in that 
> directory automatically.

Yes, very much so.

Although it is conceivable that we may want to change that to behave more
like "git add that/directory && git commit that/directory", that is a
rather large UI semantics change (even if it could be a useful one) that
needs to wait for a major version bump, perhaps in 1.7.0.

I think Mark's update to the documentation is a good thing to have in any
case, so I've applied it.
