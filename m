From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] autoconf: Check autoconf version (ASCIIDOC8)
Date: Mon, 10 Dec 2007 19:11:18 -0800
Message-ID: <7vhciqhqnd.fsf@gitster.siamese.dyndns.org>
References: <1197205059-16742-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 04:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1vXH-0002TN-09
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 04:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbXLKDLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 22:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbXLKDLd
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 22:11:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbXLKDLc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 22:11:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0868339BC;
	Mon, 10 Dec 2007 22:11:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6010B39BA;
	Mon, 10 Dec 2007 22:11:22 -0500 (EST)
In-Reply-To: <1197205059-16742-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Sun, 9 Dec 2007 13:57:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67780>

Jakub Narebski <jnareb@gmail.com> writes:

> Subject: Re: [PATCH] autoconf: Check autoconf version (ASCIIDOC8)

That's "Check asciidoc version".

> Check for asciidoc, and if it exists check asciidoc version, setting
> ASCIIDOC8 when needed.  Currently it just runs asciidoc in asciidoc7
> compatibility mode (see: Documentation/Makefile).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> diff --git a/config.mak.in b/config.mak.in
> index 7d5df9b..759470a 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -7,6 +7,7 @@ AR = @AR@
>  TAR = @TAR@
>  #INSTALL = @INSTALL@		# needs install-sh or install.sh in sources
>  TCLTK_PATH = @TCLTK_PATH@
> +ASCIIDOC=@ASCIIDOC@

And this is "ASCIIDOC8=@ASCIIDOC8@", I think.

Will apply with the said fixups.

Thanks.
