From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to use git merge -s subtree?
Date: Sat, 05 Jan 2008 18:42:37 -0800
Message-ID: <7vir277jz6.fsf@gitster.siamese.dyndns.org>
References: <20080105230004.GY29972@genesis.frugalware.org>
	<BAYC1-PASMTP12374B54BA370A1E1C6E78AE4E0@CEZ.ICE>
	<flpah7$beg$2@ger.gmane.org>
	<BAYC1-PASMTP01FC193EA959D148F19374AE4E0@CEZ.ICE>
	<47803CB6.4050102@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 03:43:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBLTv-0006W9-80
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 03:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYAFCms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 21:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbYAFCmr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 21:42:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbYAFCmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 21:42:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 351F38984;
	Sat,  5 Jan 2008 21:42:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B4EA68983;
	Sat,  5 Jan 2008 21:42:39 -0500 (EST)
In-Reply-To: <47803CB6.4050102@gmx.net> (David Soria Parra's message of "Sun,
	06 Jan 2008 03:28:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69704>

David Soria Parra <sn_@gmx.net> writes:

> Well yes the history is preserved, but it's not connected to the
> subdirectory. So you cannot do git-log B/foo.c as git doesnot know where
> to search it as it thinks
> it is in /foo.c not in B/foo.c

The thing is, what you are talking is not about the subtree
merge strategy, but the fundamental philosophy of git.  Asking
for "the history of file B/foo.c" does not make any sense, as
git never tracks history of individual files.

I'll point you to one of the most important messages in the
whole archive of the git mailing list.

 http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217
