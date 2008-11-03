From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Mon, 03 Nov 2008 18:59:20 +1300
Message-ID: <1225691960.20883.41.camel@maia.lan>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
	 <20081031003154.GA5745@sigill.intra.peff.net>
	 <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Sam Vilain <samv@vilain.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:02:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwsWW-0000J4-TQ
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYKCF7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 00:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbYKCF7a
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 00:59:30 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:59684 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbYKCF73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 00:59:29 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 6F7FBC4002; Mon,  3 Nov 2008 18:59:27 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 4B5C5C4001;
	Mon,  3 Nov 2008 18:59:21 +1300 (NZDT)
In-Reply-To: <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2008-11-02 at 14:27 -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> +  * 'git push --matching' does what 'git push' does today (without
> >> +    explicit configuration)
> >
> > I think this is reasonable even without other changes, just to override
> > any configuration.
> 
> I don't.  Can't you say "git push $there HEAD" these days?  I vaguely
> recall that there is a way to configure push that way for people too lazy
> to type "origin HEAD" after "git push".

I don't think it's about laziness, it's more about making sure that
without specifying behaviour, the action of the command is conservative.
Pushing all matching refs is not conservative; it's "magic".  And in my
experience, people get bitten by it, because they think, "ok, time to
push this branch", type "git push" and then a lot more than they
expected gets pushed.

I can see that some people want this behaviour by default; but to me
"push the current branch back to where it came from" seems like far more
a rational default for at least 90% of users.

Sam.
