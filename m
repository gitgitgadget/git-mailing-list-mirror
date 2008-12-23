From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9129: skip the last two tests if UTF-8 locale not
 available
Date: Mon, 22 Dec 2008 17:52:08 -0800
Message-ID: <7vy6y7fyk7.fsf@gitster.siamese.dyndns.org>
References: <7vzliogcie.fsf@gitster.siamese.dyndns.org>
 <1229994564-5153-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter van der Does <peter@ourvirtualhome.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Dec 23 02:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEwSm-0000qd-20
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 02:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbYLWBwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 20:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbYLWBwR
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 20:52:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbYLWBwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 20:52:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E441F1AE10;
	Mon, 22 Dec 2008 20:52:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 50B371A497; Mon,
 22 Dec 2008 20:52:09 -0500 (EST)
In-Reply-To: <1229994564-5153-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Tue, 23 Dec 2008 02:09:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5285CAD2-D094-11DD-9D3C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103798>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Mon, Dec 22, 2008 at 12:50:49PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> I think some tests play nicer than this one and skip tests that want
>> UTF-8 locales; you may want to teach this script the same trick.
>
> What about this?
>
> Tesed on two Linux boxes (where I have / do not have UTF-8) and HP-UX
> (where I do not have, either).

Thanks.

Peter, is this the only test that you had trouble with, and does Miklos's
patch help your environment?
