From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Sat, 20 Dec 2008 18:37:16 -0800
Message-ID: <7viqpetfs3.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <200812200808.02011.robin.rosenberg.lists@dewire.com>
 <200812201654.23110.bss@iguanasuicide.net>
 <200812210031.08443.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 03:38:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEEDS-0003FQ-5Q
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 03:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYLUChY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 21:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbYLUChX
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 21:37:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbYLUChW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 21:37:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5ECAF8910B;
	Sat, 20 Dec 2008 21:37:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 993768910A; Sat,
 20 Dec 2008 21:37:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4B7708E2-CF08-11DD-8523-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103684>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> An alternative, would be "removing changes relative to .."
> (mainline). The changes are the contributions from all other parents. I
> have to huge interest in the exact phrase used.

But that is exactly what "This reverts commit X" means, isn't it?
