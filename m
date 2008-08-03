From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
 the basename
Date: Sun, 03 Aug 2008 13:43:01 -0700
Message-ID: <7v3allvnhm.fsf@gitster.siamese.dyndns.org>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de>
 <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness>
 <20080803202513.GC3482@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPkR4-0000sr-Qf
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbYHCUnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbYHCUnL
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:43:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbYHCUnL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:43:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BD3F449BDA;
	Sun,  3 Aug 2008 16:43:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 942DE49BD8; Sun,  3 Aug 2008 16:43:03 -0400 (EDT)
In-Reply-To: <20080803202513.GC3482@efreet.light.src> (Jan Hudec's message of
 "Sun, 3 Aug 2008 22:25:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C880BAE2-619C-11DD-9ACC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91265>

Jan Hudec <bulb@ucw.cz> writes:

> On UNIX, not only that argv[0] can contain the program without path -- it can
> contain anything the user thinks of.... Maybe since
> it's only needed for resolving a relative exec dir, relative exec dir could
> be supported only on systems that have such method (which is most of them).

The "relocatable install" itself is not usually a common concept in the
UNIX world, and I do not think this matters anyway.
