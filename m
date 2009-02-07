From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Switch receive.denyCurrentBranch to "refuse"
Date: Fri, 06 Feb 2009 23:51:36 -0800
Message-ID: <7v1vuaznuf.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901300133070.3586@pacific.mpi-cbg.de>
 <76718490901300817x3f31460k59b6fe75d136372d@mail.gmail.com>
 <alpine.DEB.1.00.0901301756560.3586@pacific.mpi-cbg.de>
 <76718490901301050h1f0f5b2bq902de384d954d99b@mail.gmail.com>
 <alpine.DEB.1.00.0901301959300.3586@pacific.mpi-cbg.de>
 <20090131095622.6117@nanako3.lavabit.com>
 <7vy6wr0wvi.fsf@gitster.siamese.dyndns.org>
 <20090202124148.GB8325@sigio.peff.net>
 <7vvdrsdtvr.fsf@gitster.siamese.dyndns.org>
 <7vd4dzbei5.fsf@gitster.siamese.dyndns.org>
 <20090206140637.GB18364@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 07 08:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVi0L-0007il-1v
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 08:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbZBGHvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 02:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZBGHvq
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 02:51:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZBGHvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 02:51:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 208322A9CB;
	Sat,  7 Feb 2009 02:51:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED1122A9C9; Sat, 
 7 Feb 2009 02:51:37 -0500 (EST)
In-Reply-To: <20090206140637.GB18364@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 6 Feb 2009 09:06:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29BC3EF2-F4EC-11DD-90EB-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108827>

Jeff King <peff@peff.net> writes:

>> This makes git-push to refuse pushing-push into a non-bare repository to
>
> As opposed to non-pushing push?

Editor/finger slippage.  Thanks for catching it.
