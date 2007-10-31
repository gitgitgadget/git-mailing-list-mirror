From: David Kastrup <dak@gnu.org>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 07:39:54 +0100
Message-ID: <85pryvzt1h.fsf@lola.goethe.zz>
References: <20071030044026.GA9600@thunk.org>
	<alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
	<20071030053732.GA16963@hermes.priv>
	<alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
	<20071030160232.GB2640@hermes.priv>
	<alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
	<vpq8x5kh4rr.fsf@bauges.imag.fr>
	<alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
	<4727839B.9070205@obry.net>
	<alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
	<20071030235823.GA22747@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Pascal Obry <pascal@obry.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 07:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In7EW-0004Cy-LA
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 07:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbXJaGjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 02:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967AbXJaGjE
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 02:39:04 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:41780 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbXJaGjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 02:39:01 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1In7E3-0001S4-30; Wed, 31 Oct 2007 02:38:51 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E32441C460DF; Wed, 31 Oct 2007 07:39:54 +0100 (CET)
In-Reply-To: <20071030235823.GA22747@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Oct 2007 19:58:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 30, 2007 at 12:38:27PM -0700, Linus Torvalds wrote:
>
>> So if you want to follow the RFC, you'd better give a real reason. And no, 
>> the existence of an RFC, and the fact that people use the same name for 
>> things that superficially _look_ the same is not a reason in itself.
>> 
>> So hands up, people. Anybody who asked for RFC quoting. Give a damn 
>> *reason* already!
>
> I didn't ask for RFC quoting, but a nice side effect of URL syntax is
> that they are machine parseable. If you wanted to write a tool to pick
> the URLs out of this email and clone them as git repos, then how do you
> find the end of:
>
>   http://host/git repo with spaces in the path
>
> compared to:
>
>   http://host/git+repo+with+spaces+in+the+path

You just write <URL:http://host/git repo with spaces in the path> and
have a good chance it will work.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
