From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] removed some unused variables
Date: Sat, 7 Mar 2009 18:52:46 -0500
Message-ID: <20090307235245.GA19926@coredump.intra.peff.net>
References: <7f978c810903071202w59a5ca37id6d1fee405c24e9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 00:54:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg6Ln-0007qd-DG
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 00:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbZCGXxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 18:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbZCGXxF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 18:53:05 -0500
Received: from peff.net ([208.65.91.99]:55482 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbZCGXxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 18:53:04 -0500
Received: (qmail 18036 invoked by uid 107); 7 Mar 2009 23:52:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Mar 2009 18:52:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Mar 2009 18:52:46 -0500
Content-Disposition: inline
In-Reply-To: <7f978c810903071202w59a5ca37id6d1fee405c24e9c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112596>

On Sat, Mar 07, 2009 at 09:02:10PM +0100, Benjamin Kramer wrote:

> these variables were unused and can be removed safely
> 
> builtin-clone: removed unused variable 'option_no_hardlinks'

I did a double-take here, as I was just looking at option_no_hardlinks
code the other day. But looking at your patch, I think you meant
"use_local_hardlinks".

> @@ -388,9 +386,6 @@ int cmd_clone(int argc, const char **argv, const
> char *prefix)

Your patch is damaged due to wrapping here (and several other places).
Please check your mailer settings.

Other than that, I think it is a fine cleanup.

-Peff
