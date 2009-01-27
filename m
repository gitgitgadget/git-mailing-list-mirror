From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: correctly remember --root flag across
 --continue
Date: Mon, 26 Jan 2009 16:29:17 -0800
Message-ID: <7v7i4h382q.fsf@gitster.siamese.dyndns.org>
References: <7vtz7ma9z1.fsf@gitster.siamese.dyndns.org>
 <1232960722-17480-1-git-send-email-trast@student.ethz.ch>
 <7veiyp4w2m.fsf@gitster.siamese.dyndns.org>
 <200901262228.13104.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 01:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRbqv-0001QS-45
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 01:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbZA0A31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 19:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbZA0A31
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 19:29:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52083 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbZA0A31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 19:29:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A92C793B38;
	Mon, 26 Jan 2009 19:29:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0F69393B35; Mon,
 26 Jan 2009 19:29:19 -0500 (EST)
In-Reply-To: <200901262228.13104.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon, 26 Jan 2009 22:28:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C7C47E4-EC09-11DD-84D6-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107296>

Thomas Rast <trast@student.ethz.ch> writes:

> It would certainly be possible to test the SHA1 of the resulting
> branch tip, but t/README says I shouldn't.

Correct.  The test should convert the SHA-1 back to some symbolic form
that is stable for comparison.
