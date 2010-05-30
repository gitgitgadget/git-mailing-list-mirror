From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Group the default git help message by topic
Date: Sun, 30 May 2010 01:36:46 -0400
Message-ID: <20100530053646.GB19219@coredump.intra.peff.net>
References: <1274809430-36060-1-git-send-email-schacon@gmail.com>
 <AANLkTilWIRqnjjgGA3e9DDzw2MiHirjP2-W7PuPhonUs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 07:37:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIbDO-00016I-1d
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 07:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab0E3Fgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 01:36:47 -0400
Received: from peff.net ([208.65.91.99]:59620 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab0E3Fgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 01:36:47 -0400
Received: (qmail 27724 invoked by uid 107); 30 May 2010 05:36:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 30 May 2010 01:36:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 May 2010 01:36:46 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTilWIRqnjjgGA3e9DDzw2MiHirjP2-W7PuPhonUs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147984>

On Tue, May 25, 2010 at 10:47:19AM -0700, Scott Chacon wrote:

> It's difficult to process 21 commands (which is what is output
> by default for git when no command is given). =C2=A0They have been
> re-grouped into 4 groups of 5-6 commands each, which is clearer
> and easier for new users to process. =C2=A0More advanced commands
> such as bisect and rebase have also been removed as this should
> be output for beginners.

I think this is an improvement, but your patch seems to be whitespace
damaged.

> Also removes the common-cmd.h generation process, including
> parts of the Makefile and the generate-cmdlist.sh file.

We could always mark the relevant commands in command-list.txt and
auto-generate the structured list. But this list really should not
change much, so I don't know if the extra complexity to do it
automatically is worth it.

-Peff
