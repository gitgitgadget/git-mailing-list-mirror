From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Wed, 05 Nov 2008 07:10:31 +1300
Message-ID: <1225822231.6722.3.camel@maia.lan>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
	 <20081031003154.GA5745@sigill.intra.peff.net>
	 <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
	 <1225691960.20883.41.camel@maia.lan>
	 <20081104091800.GB24100@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 19:12:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxQNt-0008P7-4Z
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 19:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYKDSKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 13:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbYKDSKz
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 13:10:55 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:53282 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbYKDSKy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 13:10:54 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 1E6F021C3BC; Wed,  5 Nov 2008 07:10:49 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id AD0D921C39C;
	Wed,  5 Nov 2008 07:10:35 +1300 (NZDT)
In-Reply-To: <20081104091800.GB24100@dpotapov.dyndns.org>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100095>

On Tue, 2008-11-04 at 12:18 +0300, Dmitry Potapov wrote:
> > I can see that some people want this behaviour by default; but to me
> > "push the current branch back to where it came from" seems like far more
> > a rational default for at least 90% of users.
> 
> I think it depends on one's workflow. If you use a centralized workflow
> as with CVS then yes, 90% cases you want to push the current branch. On
> the other hand, if people push their changes to the server only for
> review, it means that accidentally pushing more than one intended is not
> a big deal.

Perhaps not, but it was still unintended.  I really can't understand the
opposition to making this command make many people less angry at it.

>  The only one who does publishing to the official repository
> is the maintainer, and the maintainer is most likely to run some tests
> after merging all changes, which takes some time. So, it is rarely push
> the current branch, it is usually the branch that has been tested, so
> the name of the branch should be specified explicitly anyway.

Why is that relevant?  That person can still use the explicit version of
the command.

Sam.
