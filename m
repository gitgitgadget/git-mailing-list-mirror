From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH next v4] git-notes: fix printing of multi-line notes
Date: Sun, 18 Jan 2009 13:27:34 -0800
Message-ID: <7vmydouwxl.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de>
 <49708644.7040809@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <tavestbo@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:29:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOfCv-0007wH-0M
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbZARV1s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 16:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754692AbZARV1s
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:27:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbZARV1r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 16:27:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B192D1BC43;
	Sun, 18 Jan 2009 16:27:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 461221B56B; Sun,
 18 Jan 2009 16:27:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D84B1BAA-E5A6-11DD-849D-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106285>

Tor Arne Vestb=C3=B8 <tavestbo@trolltech.com> writes:

> The line length was read from the same position every time,
> causing mangled output when printing notes with multiple lines.
>
> Also, adding new-line manually for each line ensures that we
> get a new-line between commits, matching git-log for commits
> without notes.
>
> Test case added to t3301-notes.sh.
>
> Signed-off-by: Tor Arne Vestb=C3=B8 <tavestbo@trolltech.com>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
> Sorry about the delay. Here's a squashed patch.

Thanks.  This exactly matches 22a3d06 (git-notes: fix printing of
multi-line notes, 2009-01-13) I already have, so we are in a good shape=
=2E
