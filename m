From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Wed, 19 Nov 2008 15:51:10 -0800
Message-ID: <7v1vx7s2a9.fsf@gitster.siamese.dyndns.org>
References: <20081118211237.234d8035@crow>
 <200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
 <alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
 <20081119095452.3018d2de@crow>
 <alpine.DEB.1.00.0811191226530.30769@pacific.mpi-cbg.de>
 <7vd4grsveo.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0811191247560.19665@iabervon.org>
 <7v7i6zs4ay.fsf@gitster.siamese.dyndns.org> <20081119233027.17687dd5@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 00:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2wrJ-0006G7-Ia
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 00:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbYKSXwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 18:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbYKSXwF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 18:52:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbYKSXwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 18:52:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E2A7D17170;
	Wed, 19 Nov 2008 18:52:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C11B717165; Wed,
 19 Nov 2008 18:51:11 -0500 (EST)
In-Reply-To: <20081119233027.17687dd5@crow> (Mark Burton's message of "Wed,
 19 Nov 2008 23:30:27 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F9AB5FC-B695-11DD-A3EC-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101383>

Mark Burton <markb@ordern.com> writes:

>> Allowing what Mark wants without any explicit user customization will be a
>> disaster to the end user experience.
>
> If the ability to commit a currently untracked file/tree whilst
> preserving the index is really worth having (and that's debatable, as
> the git user community has survived until now without that capability)
> then another option (say, -O) could be added to git-commit that does
> what -o does but allows untracked files/trees to be specified - that
> way, the current behaviour would remain unchanged and the above
> mentioned disaster averted.

Heh, I apparently failed to convey what I wanted to say with "without any
explicit user customization" part of my message.  IOW, I think you are
saying the same thing as what I wanted to say from the opposite angle.
