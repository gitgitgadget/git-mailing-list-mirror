From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: cogito remote branch
Date: Mon, 12 Nov 2007 11:47:52 +0100
Message-ID: <1IrWpc-0kFExM0@fwd28.aul.t-online.de>
References: <Pine.LNX.4.64.0711111359590.9401@castor.milkiway.cos>
 <Pine.LNX.4.64.0711111520260.4362@racer.site>
 <1IrUDz-01jF4a0@fwd29.aul.t-online.de>
 <Pine.LNX.4.64.0711120954460.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrWqD-0000iG-An
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060AbXKLKsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757102AbXKLKsK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:48:10 -0500
Received: from mailout02.sul.t-online.de ([194.25.134.17]:48254 "EHLO
	mailout02.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756449AbXKLKsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 05:48:09 -0500
Received: from fwd28.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1IrWpo-0006jV-00; Mon, 12 Nov 2007 11:48:04 +0100
Received: from localhost (XRxHNUZBghgSm+NfQybHgDuwVgj7K40ImH3nLn7HDH6P9JlEhDSe00I-7THA3irQGy@[172.20.101.250]) by fwd28.aul.t-online.de
	with esmtp id 1IrWpc-0kFExM0; Mon, 12 Nov 2007 11:47:52 +0100
In-Reply-To: <Pine.LNX.4.64.0711120954460.4362@racer.site>
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-0-8
X-ID: XRxHNUZBghgSm+NfQybHgDuwVgj7K40ImH3nLn7HDH6P9JlEhDSe00I-7THA3irQGy@t-dialin.net
X-TOI-MSGID: f5495d8a-6114-4b6f-8f5e-a9dec8ccc4f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64596>


Johannes Schindelin wrote:

>> A push is needed somewhere in order to prevent every remote to be
pushed 
>> by default, right?

>You mean a "push" config variable?  No.  I think I mentioned in my
first 
>reply that

>	git push  <remote> <branch>...

>works quite wonderfully.

I mean a push = .. line in the [remote <name>] block.
And if there is such a line than git-push without arguments will push
only
the current branch. For me that is nice, because if I forgot to give 
an argument to git-push it will not push other branches.

If there is no such line all the remotes (that don't have a push line?) 
get pushed. 

Cheers,
Michael
