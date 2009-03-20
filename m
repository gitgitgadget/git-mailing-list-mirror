From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Allow http authentication via prompt for http push.
Date: Fri, 20 Mar 2009 14:25:09 +0100
Message-ID: <49C39935.5070707@drmicha.warpmail.net>
References: <d8c371a80903190812w59febbd3qc6bc3d70ce85f76e@mail.gmail.com>	 <alpine.DEB.1.00.0903191755270.6357@intel-tinevez-2-302>	 <d8c371a80903191202v6fb974f4t2321761d0cf21a70@mail.gmail.com>	 <49C35891.7010004@drmicha.warpmail.net> <d8c371a80903200538t71adbca5hc11aae2ea1e36c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Amos King <amos.l.king@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 14:27:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkeka-0004Ng-Aw
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 14:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbZCTNZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbZCTNZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 09:25:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53525 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751060AbZCTNZ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 09:25:26 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 0A66D2F4422;
	Fri, 20 Mar 2009 09:25:24 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 20 Mar 2009 09:25:24 -0400
X-Sasl-enc: qjuGuVnYhYLuR5R9imGMcd3KNo4kdF7QSviaV8MZYlgd 1237555523
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2802D267F2;
	Fri, 20 Mar 2009 09:25:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090320 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <d8c371a80903200538t71adbca5hc11aae2ea1e36c9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113955>

Amos King venit, vidit, dixit 20.03.2009 13:38:
> Where are the typos and I will fix them?

I'll respond to this only, everything else has been said already.

> There is now a faux remote created in order to
> be passed to http_init.
...
> +	 * This is a faked remote so that http_init can
> +	 * get the correct data for builidng out athorization.

Obviously:

"builidng" -> "building"
"athorization" -> "authorization"

Up for discussion:

"out" -> "our"/"up"/""
"build out" isn't that common and doesn't seem to apply here: In order
to build something out that something must exist already. You can build
up something from the ground.

"faux" -> "fake"
"faked" -> "fake"

Both changes go for a more common, simplified wording. It's only a
comment, though. No one would have cared about those.

Michael
