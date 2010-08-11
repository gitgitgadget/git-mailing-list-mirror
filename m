From: Sam Vilain <sam@vilain.net>
Subject: Re: Git server eats all memory
Date: Wed, 11 Aug 2010 12:30:26 +0200
Message-ID: <1281522626.2512.10.camel@arcturus>
References: <wesfwyupgrg.fsf@kanis.fr>
	 <robbat2-20100810T004153-279468425Z@orbis-terrarum.net>
	 <AANLkTi=DcuHEkJf1s18LUHrA2L6jUiadhxKqQBO4QCHh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ivan Kanis <expire-by-2010-08-11@kanis.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, Avery Pennarun <apenwarr@gmail.com>,
	jnareb@gmail.com, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 12:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj8b5-0000ob-7T
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 12:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab0HKKbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 06:31:32 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:33138 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab0HKKbb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 06:31:31 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 9AB5D21C985; Wed, 11 Aug 2010 22:31:29 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.80.129.230] (unknown [91.137.20.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 619E321C96D;
	Wed, 11 Aug 2010 22:30:29 +1200 (NZST)
In-Reply-To: <AANLkTi=DcuHEkJf1s18LUHrA2L6jUiadhxKqQBO4QCHh@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153223>

On Mon, 2010-08-09 at 21:31 -0500, Sverre Rabbelier wrote:
> On Mon, Aug 9, 2010 at 19:46, Robin H. Johnson <robbat2@gentoo.org> wrote:
> > Our temporary solution plan is via hooks, if you're asking for a item
> > before a certain point, throw an error telling you to download a
> > git-bundle from a given URL instead (as a bonus you can resume that
> > trivially).
> 
> Seems like there should be a way to tell the git server that certain
> pack files should be sent to the client verbatim. Perhaps the protocol
> could learn a new capability to support such a negotiation in which
> the server will assume that the client either has the required packs,
> or continue negotiation under the assumption that they will be
> downloaded first.
> 
> Sounds like Sam might have some relevant to say about this? Or perhaps
> the pack caching gsoc project is relevant?

Sure, well the project was supposed to be primarily useful for this use
case.  It just needs someone to pick it up and revitalize it so it can
be merged... looks like there's a topgit series at github.com/sirnot/git
from Oct. last year.

Sam
