From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test "git log --diff-filter"
Date: Sat, 05 Jan 2008 14:34:08 -0800
Message-ID: <7vsl1b7vhb.fsf@gitster.siamese.dyndns.org>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org>
	<1199571622-12953-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:35:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBHbl-0000OW-Cg
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 23:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbYAEWeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 17:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbYAEWeP
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 17:34:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272AbYAEWeO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 17:34:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B6F8E87C8;
	Sat,  5 Jan 2008 17:34:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4ED7687C7;
	Sat,  5 Jan 2008 17:34:10 -0500 (EST)
In-Reply-To: <1199571622-12953-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Sat, 5 Jan 2008 23:20:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69690>

Jakub Narebski <jnareb@gmail.com> writes:

> Add test to check "git log --diff-filter" works correctly with and
> without diff generation by git-log; the main purpose of this test is
> to check if "git log --diff-filter" filters revisions correctly.
>
> This is a companion test to commit 0faf2da7e5ee5c2f472d8a7afaf8616101f34e80
> (Fix "git log --diff-filter" bug) by Arjen Laarhoven.

If you look at the commit, you'd notice that I've added
necessary test when I accepted the patch from Arjen already ;-).

Does this new set of tests check something new?
