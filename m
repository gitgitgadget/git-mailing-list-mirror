From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make default pre-commit hook less noisy
Date: Mon, 14 Jan 2008 13:51:45 -0800
Message-ID: <7vzlv8hy8e.fsf@gitster.siamese.dyndns.org>
References: <478BD87E.7030606@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Mon Jan 14 22:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEXED-0002tP-MX
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 22:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946AbYANVvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 16:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYANVvy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 16:51:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYANVvx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 16:51:53 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 75B3D1B5B;
	Mon, 14 Jan 2008 16:51:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1546B1B5A;
	Mon, 14 Jan 2008 16:51:47 -0500 (EST)
In-Reply-To: <478BD87E.7030606@gmx.ch> (Jean-Luc Herren's message of "Mon, 14
	Jan 2008 22:47:42 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70482>

Jean-Luc Herren <jlh@gmx.ch> writes:

> This hook thought to have found a conflict marker any time it saw
> a 7-character combination of any of the characters '<>=' at the
> beginning of a line, whereas it should only look for the *same*
> character to appear repeatedly.

I think itt looks good.  Thanks.
