From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-mergetool: add support for ediff
Date: Tue, 03 Jul 2007 18:27:04 +1200
Message-ID: <4689EC38.1010603@vilain.net>
References: <11830788163411-git-send-email-sam.vilain@catalyst.net.nz> <31e9dd080706281831vbe24597i9b6a5f6f6db6fec8@mail.gmail.com> <20070629040328.GG29279@thunk.org> <20070702020401.GD28917@thunk.org> <46896EF2.70006@vilain.net> <20070702215859.GA20597@thunk.org> <20070702221639.GB20597@thunk.org> <46898815.6030607@vilain.net> <20070703010955.GA5322@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jason Sewall <jasonsewall@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 08:27:16 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5br0-00071s-Rl
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 08:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbXGCG1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 02:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbXGCG1M
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 02:27:12 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48767 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbXGCG1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 02:27:12 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 6FC1E13A4EA; Tue,  3 Jul 2007 18:27:10 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id F00C213A3E1;
	Tue,  3 Jul 2007 18:27:06 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <20070703010955.GA5322@thunk.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51463>

Theodore Tso wrote:
> I'm just exploring alternatives.  Basically, it just seems interesting
> that ediff has a lot of nice features, but also has some incredibly
> user-hostile features.  The first time I tried using ediff, I indeed
> tried saving the buffer and exiting it.  That's when I discovered that
> after I changed the focus to the merge window and saved it, when I
> tried typing ^X^C, the exit failed with the error message "Attempt to
> delete a surrogate minibuffer frame".  That's the sort of thing that
> will cause non-elisp programmers to run screaming off into the
> distance.

Ouch.  Yes, I've never seen that before and no doubt if I had've I'd
feel the same way.  I just save the merge buffer and quit, and it is
pretty obedient for me.

However I guess it wouldn't be nice to have a merge mode that did not
work out of the box for a large number of users.

Your .el file certainly does the trick for me - I reckon throw it in
contrib/

Sam.
