From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Mon, 19 Jan 2009 15:10:56 -0800
Message-ID: <7vljt6q4cf.fsf@gitster.siamese.dyndns.org>
References: <20090117153846.GB27071@coredump.intra.peff.net>
 <49736331.8010003@lsrfire.ath.cx>
 <20090118173753.GB17434@coredump.intra.peff.net>
 <20090118194328.GA31180@coredump.intra.peff.net>
 <20090118195342.GA612@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:12:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3IH-0006Uh-Fm
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbZASXLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbZASXLK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:11:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZASXLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:11:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 07FA9917EB;
	Mon, 19 Jan 2009 18:11:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED304917EA; Mon,
 19 Jan 2009 18:11:02 -0500 (EST)
In-Reply-To: <20090118195342.GA612@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 18 Jan 2009 14:53:43 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 742A98FC-E67E-11DD-B1EE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106399>

Jeff King <peff@peff.net> writes:

> Hrm. OK, it doesn't actually work always. It does for git-log, but not
> for rev-list, which leaves diff_use_color_default as -1. I don't know if
> there are any other ways you can get to this code path without having
> set diff_use_color_default.

Yuck, no matter what you do please don't contaminate plumbing with the UI
color options.

> Maybe it is time to do a cleanup on the color handling, which has
> provided no end of these bugs. I will have to leave that for another
> day, though.
