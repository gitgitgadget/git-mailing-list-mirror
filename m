From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCHv2] add Android support
Date: Thu, 19 May 2011 19:30:49 +0200
Message-ID: <AE42113D-8D2F-4B24-A800-D49183152911@gieschke.de>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de> <7vaaej9pt3.fsf@alter.siamese.dyndns.org> <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de> <20110519122026.GA30240@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 19:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN73s-0004rl-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933711Ab1ESRau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:30:50 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:19473 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933494Ab1ESRau convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 13:30:50 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 4CA241D1D9C;
	Thu, 19 May 2011 19:30:49 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.399
X-Spam-Level: 
X-Spam-Status: No, score=-3.399 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=-0.499, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QnM92Qdeuef1; Thu, 19 May 2011 19:30:48 +0200 (CEST)
Received: from dhcp208-43.rz.uni-freiburg.de (dhcp208-43.rz.uni-freiburg.de [132.230.208.43])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id 881771D1C95;
	Thu, 19 May 2011 19:30:48 +0200 (CEST)
In-Reply-To: <20110519122026.GA30240@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173976>


Am 19.05.2011 um 14:20 schrieb Jeff King:

> The point of uname_S is that it would be found automatically. Sadly,
> There is nothing helpful in uname to tell us that we are on android:
> 

Actually, you can't even call uname as I suspect that you would normally not compile on Android (I don't think that gcc runs on Android) but always cross-compile.


> So I think we are probably stuck either with the user setting an ANDROID
> meta-flag that sets the other flags appropriately, or leaving it up to
> the user to provide a sane config.mak.

Yes, I agree that leaving it up completely to the user to provide a config.mak is a very good option too, especially as build environments might be different and some might want to try building with Perl and libcurl, which would require a config.mak anyhow.
