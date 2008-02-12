From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git-status shows bad instructions prior to first commit
Date: Mon, 11 Feb 2008 19:13:15 -0800
Message-ID: <7vzlu66f5g.fsf@gitster.siamese.dyndns.org>
References: <F1B5775C-1C11-4C30-B72E-9EB4076613A5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 04:14:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOlav-0007nv-LV
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 04:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756708AbYBLDNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 22:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756684AbYBLDNX
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 22:13:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581AbYBLDNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 22:13:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 18CD23A20;
	Mon, 11 Feb 2008 22:13:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8813A395F;
	Mon, 11 Feb 2008 22:13:17 -0500 (EST)
In-Reply-To: <F1B5775C-1C11-4C30-B72E-9EB4076613A5@gmail.com> (Kate Rhodes's
	message of "Mon, 11 Feb 2008 19:59:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73624>

"Rhodes, Kate" <masukomi@gmail.com> writes:

> While we're at it, can someone please explain to me how to remove a
> file from the index prior to the first commit? I'm stumped.

rm --cached
