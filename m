From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH] mergetool-lib: make (g)vimdiff workable under
 Windows
Date: Sun, 05 Apr 2009 11:41:03 -0700
Message-ID: <7v63hjt03k.fsf@gitster.siamese.dyndns.org>
References: <200904041517.55890.markus.heidelberg@web.de>
 <alpine.DEB.1.00.0904051134210.10279@pacific.mpi-cbg.de>
 <200904051232.19939.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	msysgit@googlegroups.com
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sun Apr 05 20:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXIu-0002L8-3Y
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 20:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbZDESlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbZDESlP
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 14:41:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbZDESlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 14:41:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 732C3C88E;
	Sun,  5 Apr 2009 14:41:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8E864C88B; Sun, 
 5 Apr 2009 14:41:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 56419CD6-2211-11DE-8297-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115675>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> Junio, is this something for maint? I'm not sure, since this problem
> only occurs on Windows and 'maint' isn't interesting for msysgit ATM.

I am not Dscho (nor J6t) but the last time I asked him about some other
"This makes it work better on Windows" patch, the conclusion was "only
Windows has issues and msysgit does not use 'maint'", which I agreed to be
a sensible answer for an undermanned and still-on bleeding edge project
like msysgit.

I don't mind a trivial backport for only mergetool part to the tip of
'master' (because difftool is not in master) that later makes me deal with
a small merge conflict when the refactoring topic hits master.  Or Dscho
can apply such a backport and carry it as a msysgit-only patch until my
'master' is updated with the refactoring topic (at which point the
tentative patch needs to be dropped).  Either would work fine with me.
