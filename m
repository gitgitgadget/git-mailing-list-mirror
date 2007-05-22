From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: Using git to store /etc, redux
Date: Tue, 22 May 2007 14:16:40 +0200 (CEST)
Message-ID: <17042.145.64.134.244.1179836200.squirrel@www.hardeman.nu>
References: <20070519174815.GA5124@hardeman.nu>
    <20070521183239.GB5082@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue May 22 14:55:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqTu4-0002P4-GQ
	for gcvg-git@gmane.org; Tue, 22 May 2007 14:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbXEVMzr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 May 2007 08:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757507AbXEVMzr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 08:55:47 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:38718 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757505AbXEVMzr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 08:55:47 -0400
X-Greylist: delayed 2345 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 May 2007 08:55:46 EDT
Received: from localhost ([127.0.0.1] helo=www.hardeman.nu)
	by palpatine.hardeman.nu with esmtp (Exim 4.63)
	(envelope-from <david@hardeman.nu>)
	id 1HqTI8-0002gS-4k; Tue, 22 May 2007 14:16:40 +0200
Received: from 145.64.134.244
        (SquirrelMail authenticated user david)
        by www.hardeman.nu with HTTP;
        Tue, 22 May 2007 14:16:40 +0200 (CEST)
In-Reply-To: <20070521183239.GB5082@efreet.light.src>
User-Agent: SquirrelMail/1.4.9a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48103>

On Mon, May 21, 2007 20:32, Jan Hudec wrote:
> Have you looked at IsiSetup (http://www.isisetup.ch/, linked from
> http://git.or.cz/gitwiki/InterfacesFrontendsAndTools) yet? It's a
> front-end
> to git specifically targeted for versioning configuration. From a qui=
ck
> glance at it's web I don't see whether it already stores the metadata=
 you
> describe, but in either case it could be interesting for you.

Yes, it was mentioned in the previous thread about tracking /etc in git=
=2E
I've looked at it but it seemed to not store any metadata. Also, it see=
med
like overkill for just keeping a history of my /etc.

It also used a lot of hairy "grep -v" and similar tricks to run git but=
 to
mangle the output before it's shown to the user. I'd prefer to interact
directly with git which I'm already familiar with...and git already has
everything I need for tracking /etc with the exception of the metadata.

--=20
David H=E4rdeman
