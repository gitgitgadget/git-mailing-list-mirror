From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test "git log --diff-filter"
Date: Sat, 05 Jan 2008 18:26:26 -0800
Message-ID: <7vmyrj7kq5.fsf@gitster.siamese.dyndns.org>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org>
	<1199571622-12953-1-git-send-email-jnareb@gmail.com>
	<7vsl1b7vhb.fsf@gitster.siamese.dyndns.org>
	<200801060033.03672.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 03:27:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBLEG-00038I-NS
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 03:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYAFC0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 21:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbYAFC0p
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 21:26:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYAFC0o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 21:26:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B0D09808F;
	Sat,  5 Jan 2008 21:26:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FD85808E;
	Sat,  5 Jan 2008 21:26:38 -0500 (EST)
In-Reply-To: <200801060033.03672.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 6 Jan 2008 00:33:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69702>

Jakub Narebski <jnareb@gmail.com> writes:

> My test checks all --diff-filter filters relevant to git-diff-tree,
> i.e. ADMRCBT, and not only AMD.

Ah, I see.  Thanks --- that could have been stated in the log
message.  Maybe we would want to add them to existing test
script, instead of adding a whole new one?

> P.S. By the way, it is IMHO a bit strange that --pretty=oneline uses
> newline as a terminator (it means that there is a newline at the end of
> "git log --pretty=oneline), while --pretty="format:%s" uses newline as
> a separator...

Yeah, I tend to agree, although I learned to live with it long
time ago.
