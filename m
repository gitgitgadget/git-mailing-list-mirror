From: Sam Vilain <sam@vilain.net>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Mon, 31 Mar 2008 06:48:03 +1300
Message-ID: <47EFD253.6020105@vilain.net>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com> <47EECF1F.60908@vilain.net> <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sun Mar 30 19:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg1be-0003kV-4k
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 19:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbYC3Rp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 13:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbYC3Rp1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 13:45:27 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:38099 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbYC3Rp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 13:45:27 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id F1F9A21C97F; Mon, 31 Mar 2008 06:45:23 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id A51A121C978;
	Mon, 31 Mar 2008 06:45:05 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78508>

Eyvind Bernhardsen wrote:
> I solved that by adding a "submodule push" that pushes the detached head
> of each submodule to its own ref ("refs/submodule-update/commit-$sha1",
> imaginatively).  I also made "submodule update" try to fetch that ref
> when looking for a sha1.

Hmm, a reasonable decision, but I think it would be better to force the
user to choose which branch they want to push to.  Leaving breadcrumbs
in the refs/ space like that is best avoided.

> I ran into trouble trying to avoid pushing every submodule for each
> "submodule push", and then more or less decided not to use submodules,
> so it's not quite fit for public consumption.  I still think it's a
> sound idea in principle, so I'll clean it up and send it to the list if
> there's any interest.

Indeed - it can only become "fit for public consumption" if people
submit their usability enhancements!

Sam.
