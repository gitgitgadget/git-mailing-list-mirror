From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/8] wt-status: load diff ui config
Date: Sun, 26 Oct 2008 22:30:48 -0700
Message-ID: <7vmygqiozb.fsf@gitster.siamese.dyndns.org>
References: <20081026043802.GA14530@coredump.intra.peff.net>
 <20081026044935.GG21047@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 06:32:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuKiI-0001RE-Av
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 06:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYJ0FbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 01:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYJ0FbK
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 01:31:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYJ0FbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 01:31:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B5E8749A7;
	Mon, 27 Oct 2008 01:31:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 30220749A4; Mon, 27 Oct 2008 01:30:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75ABEDC6-A3E8-11DD-901A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99205>

Jeff King <peff@peff.net> writes:

> But it makes me a little nervous. On one hand, I think it is definitely
> the right thing for "status -v" to respect user options. But we do
> several _other_ diffs in addition, and those are more "plumbing" diffs.
> I think they should probably at least have diff_basic_config (e.g., for
> rename limits). But we are applying the diff_ui_config options to all
> diffs. Looking over the available options, I _think_ there are no nasty
> surprises. But you never know.

Up to 6/8 are indisputably good changes.  The next one means well, and
this one is a requisite step for it, but I agree that this feels somewhat
risky.
