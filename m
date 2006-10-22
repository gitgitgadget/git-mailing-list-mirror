From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 17:05:59 +0200
Message-ID: <vpqbqo45r1k.fsf@ecrins.imag.fr>
References: <1161487417.9241.220.camel@localhost.localdomain>
	<20061021233014.d4525a1d.seanlkml@sympatico.ca>
	<20061022100028.GQ75501@over-yonder.net>
	<20061022074422.50dcbee6.seanlkml@sympatico.ca>
	<20061022130322.GS75501@over-yonder.net>
	<20061022092845.233deb43.seanlkml@sympatico.ca>
	<20061022133336.GT75501@over-yonder.net>
	<20061022094041.77c06cc7.seanlkml@sympatico.ca>
	<20061022135702.GU75501@over-yonder.net>
	<20061022102454.b9dea693.seanlkml@sympatico.ca>
	<20061022145658.GV75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 17:06:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbeud-0002QE-Fr
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 17:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWJVPGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWJVPGw
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 11:06:52 -0400
Received: from imag.imag.fr ([129.88.30.1]:55700 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1750796AbWJVPGw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 11:06:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9MF60DS019192
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Oct 2006 17:06:02 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Gbetj-00035k-Lj; Sun, 22 Oct 2006 17:05:59 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1Gbetj-0000lh-JS; Sun, 22 Oct 2006 17:05:59 +0200
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
In-Reply-To: <20061022145658.GV75501@over-yonder.net> (Matthew D. Fuller's message of "Sun\, 22 Oct 2006 09\:56\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Sun, 22 Oct 2006 17:06:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29761>

"Matthew D. Fuller" <fullermd@over-yonder.net> writes:

> On Sun, Oct 22, 2006 at 10:24:54AM -0400 I heard the voice of
> Sean, and lo! it spake thus:
>> 
>> Light goes on.  Okay.  So a bzr "branch" is only ever editable on a
>> single machine.  So there is no distributed development on top of a
>> bzr "branch".  Everyone else just has read-only copies of it.
>
> Ah!  Yes, that's exactly[0] right.  Mark up another of those "so
> obvious we never think to state it" thought-patterns   :|

Well, I'm not sure you talk about the same thing still. Adding my
2cents:

If ~/branch1 is a branch, I can get a read-write "copy" of it with

$ bzr branch ~/branch1 ~/branch2

which will roughly be equivalent to

$ cp -r ~/branch1 ~/branch2

Whether they are at this point "the same branch" or "two distinct
branches with same content" is just a matter of vocabulary since there
is no real "branch identity" AFAIK in bzr.

Now, if you commit in ~/branch1, then ~/branch2 is out of date with
it. If you commit also to ~/branch2, then you get two divergent
branches.

(and obviously, I could have done the same with branches in different
machines)

-- 
Matthieu
