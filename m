From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Fri, 31 Aug 2007 21:25:31 +0200
Message-ID: <85wsvbbj6c.fsf@lola.goethe.zz>
References: <lkbtwek0.fsf@cante.net>
	<Pine.LNX.4.64.0708301107320.28586@racer.site>
	<46D6984D.9040802@op5.se> <7v7inc907e.fsf@gitster.siamese.dyndns.org>
	<46D7E058.9050001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Aug 31 21:25:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRC7m-00053X-C1
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 21:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbXHaTZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 15:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbXHaTZl
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 15:25:41 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:60734 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751939AbXHaTZl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 15:25:41 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 86CEA302BB7;
	Fri, 31 Aug 2007 21:25:39 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 7727F28EE1C;
	Fri, 31 Aug 2007 21:25:39 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-032.pools.arcor-ip.net [84.61.17.32])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 428F33664C2;
	Fri, 31 Aug 2007 21:25:35 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D2AF11D3DB8A; Fri, 31 Aug 2007 21:25:31 +0200 (CEST)
In-Reply-To: <46D7E058.9050001@op5.se> (Andreas Ericsson's message of "Fri\, 31 Aug 2007 11\:33\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4111/Fri Aug 31 17:25:39 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57199>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>
>>> When gc was a shell-script, it was fairly easy to find out the command-
>>> sequence...
>>
>> Maybe referring more advanced/curious users to contrib/examples/
>> directory is a good idea, but not necessarily from manpages of
>> the commands that have been rewritten in C.
>>
>> I think contrib/examples/ needs a README file that effectively
>> say "these are the last versions of shell script implementation
>> of the commands before they were rewritten in C.  New features
>> may have been added to the built-in ones but these example
>> scripts are not kept up to date.  They are here to serve as
>> examples to show you how you would pipeline the plumbing level
>> commands."
>>
>
> Sensible, and also avoids the possible bitrot problem with the
> man-page should there be additional actions added to standard
> git-gc operations.

Let's just make all manual pages empty, and then we have solved all
manual page bitrot problems in one fell swoop.

Really: I don't see how this helps at all.  If I am interested in
seeing what operations git-gc performs, I am not interested in some
historical script's behavior.

Hiding that information into contrib/examples and telling people that
it may be wrong, anyway, is not really helpful as a way of documenting
git-gc's behavior.

Of _course_, _any_ useful documentation will have a "possible bitrot
problem with the man-page" whenever code is changed.  The solution is
not to make the manual pages as useless as possible so that nothing
can be subject to bitrot.  The solution is to update the information.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
