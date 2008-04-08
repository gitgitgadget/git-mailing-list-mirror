From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is my repository broken?
Date: Tue, 08 Apr 2008 15:13:31 -0700
Message-ID: <7vk5j8knas.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 09 00:16:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjM6m-0006vq-R4
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 00:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbYDHWPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 18:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbYDHWPS
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 18:15:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbYDHWPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 18:15:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACEA27FB4;
	Tue,  8 Apr 2008 18:13:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1D56D7C50; Tue,  8 Apr 2008 18:13:33 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0804082246160.8753@kaos.quantumfyre.co.uk>
 (Julian Phillips's message of "Tue, 8 Apr 2008 23:02:16 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79037>

Julian Phillips <julian@quantumfyre.co.uk> writes:

> ...  However - will having commits with more than 16
> parents break things for un-modified git?

Offhand, 82d853d (builtin-blame.c: allow more than 16 parents, 2008-04-03)
comes to mind.  Also I would not be surprised if Porcelain scripts on the
periphery had trouble with commits with duplicated parents and such
esotericos, though.
