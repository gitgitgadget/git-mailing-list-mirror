From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 next 0/4] format-patch --cover-letter --in-reply-to
Date: Sun, 22 Feb 2009 08:49:45 -0800
Message-ID: <7vocwu1knq.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0902191734110.19665@iabervon.org>
 <cover.1235158956.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHY9-0004zQ-HR
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbZBVQt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 11:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbZBVQt4
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:49:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbZBVQtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:49:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 459392BB15;
	Sun, 22 Feb 2009 11:49:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 460922BB12; Sun,
 22 Feb 2009 11:49:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4FD4B88-0100-11DE-BBF0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111020>

Thomas Rast <trast@student.ethz.ch> writes:

> I also noticed that there is a textual conflict with 0db5260 (Enable
> setting attach as the default in .gitconfig for git-format-patch.,
> 2009-02-12), which is already in 'next'.  So I rebased the series to
> 'next'.

In general I'd rather not to see a series based on 'next' merely for a
textual dependency like this (it is a different matter if your patch
semantically depends on somebody else's work in 'next').  Your own topic
will fork from 'master' and it will not want to be taken hostage of
"attach as default" series.
