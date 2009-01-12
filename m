From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] color-words: refactor to allow for 0-character word
 boundaries
Date: Mon, 12 Jan 2009 01:36:53 -0800
Message-ID: <7vprisj26i.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901112059340.3586@pacific.mpi-cbg.de>
 <200901120947.13566.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:38:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJFZ-0007Fy-5x
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbZALJhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZALJhA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:37:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbZALJg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:36:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 178458F93B;
	Mon, 12 Jan 2009 04:36:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 478D88F938; Mon,
 12 Jan 2009 04:36:55 -0500 (EST)
In-Reply-To: <200901120947.13566.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon, 12 Jan 2009 09:47:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F0A213A-E08C-11DD-9A27-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105315>

Thomas Rast <trast@student.ethz.ch> writes:

> These remarks aside (and the last one is the only one of relevance to
> the code), this patch would be a vast improvement of the code even if
> we weren't discussing it in the context of the regex feature.  So FWIW
>
>   Acked-by: Thomas Rast <trast@student.ethz.ch>
>
> up to here.  I hope we can agree on some sane regex semantics for
> 4/4...

Ok, although I've already queued your series to 'pu' for the night, I'll
drop and replace it with the one from Dscho.  After a few more iteration
hopefully we can get it into a reasonable shape.

Thanks, both.
