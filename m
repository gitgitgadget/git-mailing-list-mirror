From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: Avoid unnecessary warning when using --all
Date: Fri, 26 Dec 2008 16:18:21 -0800
Message-ID: <7vmyeijws2.fsf@gitster.siamese.dyndns.org>
References: <20081226220201.GA20516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: demerphq <demerphq@gmail.com>, rene.scharfe@lsrfire.ath.cx,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 01:19:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGMuG-0000co-Ru
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbYL0ASb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 19:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYL0ASa
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:18:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYL0ASa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 19:18:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EAC721B279;
	Fri, 26 Dec 2008 19:18:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 285E31B278; Fri,
 26 Dec 2008 19:18:22 -0500 (EST)
In-Reply-To: <20081226220201.GA20516@spearce.org> (Shawn O. Pearce's message
 of "Fri, 26 Dec 2008 14:02:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2D56A38-D3AB-11DD-A186-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103968>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In 212945d4 ("Teach git-describe to verify annotated tag names
> before output") git-describe learned how to output a warning if
> an annotated tag object was matched but its internal name doesn't
> match the local ref name.
>
> However, "git describe --all" causes the local ref name to be
> prefixed with "tags/", so we need to skip over this prefix before
> comparing the local ref name with the name recorded inside of the
> tag object.
>
> Patch-by: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> Signed-off-by: Shawn O. Pearce <sop@google.com>
> ---
>  IMHO, suitable for maint...

Yeah, do you prefer to be known as "sop" over "spearce" these days, by =
the
way?  It does not make a difference to me but I just noticed that Autho=
r
and S-o-b won't be matching, so I am just being curious.
