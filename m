From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] fix the installation path for html documentation
Date: Tue, 10 Feb 2009 21:25:04 +0100
Message-ID: <200902102125.05287.j6t@kdbg.org>
References: <1234278853-25452-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 21:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzC5-00048C-SO
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 21:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbZBJUZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 15:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbZBJUZN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 15:25:13 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:27122 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748AbZBJUZM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 15:25:12 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 67BA5CDF88;
	Tue, 10 Feb 2009 21:25:07 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 153095BB72;
	Tue, 10 Feb 2009 21:25:07 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <1234278853-25452-1-git-send-email-git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109302>

On Dienstag, 10. Februar 2009, Michael J Gruber wrote:
> Since 026fa0d5ad9538ca76838070861531c037d7b9ba (Move computation of
> absolute paths from Makefile to runtime (in preparation for
> RUNTIME_PREFIX) the installation of html doc was broken:
> Documentation/Makefile does not know how to resolve relative dirs, which
> results in html doc being installed in
> $(git-build-root)/Documentation/share/doc/git-doc.
>
> Fix this by not exporting htmldir from Makefile since this allows
> Documentation/Makefile to compute htmldir from prefix.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> An alternative would be to teach Documentation/Makefile to take the
> relative htmldir and make it into an absolute path. But the approach I'm
> taking with this patch as analogous to how mandir is handled, with the
> same draw back. But all is well as long as the build monkey messes with
> prefix only.

Makes sense. There is no point handling mandir and htmldir differently.

-- Hannes
