From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Mon, 26 Mar 2007 14:08:57 +0400
Message-ID: <20070326100857.GW14837@codelabs.ru>
References: <20070326073502.GD44578@codelabs.ru> <7vwt14xvaw.fsf@assigned-by-dhcp.cox.net> <20070326083617.GG13247@spearce.org> <7v8xdkxukt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 12:09:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVm8h-00072i-7R
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbXCZKJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 06:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753602AbXCZKJG
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:09:06 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:54644 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbXCZKJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 06:09:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=WsfPnXDkuZHsNCHSmjKnT1Lc8j5e/afcX62ojW6O3z8TU3bxG36wAy5B/x//YgQD09cX0OOlmcoHJNnTK0EvubjmTlLUiWnPa6sLzl9jWgNS6C3bmtXZbXRa47IHGSBcb9GafGIORX9osRBgykbVAnk4R+VQiiI15vciES6aqxk=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HVm8L-000BoC-Rn; Mon, 26 Mar 2007 14:09:02 +0400
Content-Disposition: inline
In-Reply-To: <7v8xdkxukt.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43145>

Junio,

Mon, Mar 26, 2007 at 01:44:34AM -0700, Junio C Hamano wrote:
> > Junio C Hamano <junkio@cox.net> wrote:
> >> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
> >> 
> >> > Remove unnecessary '-S' option that enabled less to chop long lines.
> >> > It used to provide some confusion at least for the 'git diff':
> >> > "Where are my long lines? Are they missed from the patch?".
> >> 
> >> It is not "unnecessary", but only "what _you_ are not used to".
> >> As this breaks expectentions of people already familiar with
> >> what git does by default, I cannot take this patch.

OK, no problem.

> > Hear hear.  I completely agree with Junio.  I (and a number of
> > other users that I work with) expect this behevaior by default.
> 
> Two tips.
> 
>  (1) Learn to use left/right arrow keys under "less -S" if you
>      have occasional lines that are too long.

I do not like the left/right keys: it is wery hard to get the
right typing speed if we're using the arrow keys. But it is just
my habit since I learned to 10 fingers typing.

>  (2) Do not have too many too long lines to begin with.  If you
>      cannot comfortably read your code with "less -S", your
>      nesting is too deep to be understood with or without line
>      folding.

Yes, yes, "if you need more than 4 levels of identation then your
code is probably in a bad shape". I know it. But the problem was that
I noticed this behaviour when I was patching the Git sources and there
were some removed lines that were long enough not to fit to the screen
with the addition of the '- ' diff tags.
-- 
Eygene
