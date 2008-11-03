From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Mon, 03 Nov 2008 21:43:33 +1300
Message-ID: <1225701813.20883.85.camel@maia.lan>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
	 <gedhh6$urq$1@ger.gmane.org> <1225435899.20883.25.camel@maia.lan>
	 <200810310836.02908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 09:44:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwv3O-00088D-3b
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 09:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYKCInl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 03:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbYKCInl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 03:43:41 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:34435 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbYKCInj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 03:43:39 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id D0FF621C382; Mon,  3 Nov 2008 21:43:37 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 88D4A21C362;
	Mon,  3 Nov 2008 21:43:32 +1300 (NZDT)
In-Reply-To: <200810310836.02908.jnareb@gmail.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99912>

On Fri, 2008-10-31 at 08:36 +0100, Jakub Narebski wrote:
> > >     git checkout --track origin/wr34251-do-something
> > 
> > Ah, that's a new feature.  Still, I think it's poorly Huffman coded; far
> > too verbose.
> 
> Well, either you have a little bit more verbose, or you have to have
> some DWIM-mery, which (as usual with DWIM) can go wrong.

That's right, you need to choose when to assume that the user meant
something that they didn't write very carefully.

But look at this:

  git checkout origin/master

  git checkout -t origin/master

The option is called "--track", yet in this case what it actually means
in the default situation where you have autosetupmerge (or whatever it's
really called) set to true, is that it modifies the command to imply "-b
master".  So, in this situation, that is clearly what was meant.

Perhaps you can give an example of why this particular piece of DWIM
might not be WYM?

Sam.
