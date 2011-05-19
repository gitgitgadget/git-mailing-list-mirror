From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCHv2] add Android support
Date: Thu, 19 May 2011 21:27:16 +0200
Message-ID: <A91176A6-4F67-4289-AFF2-870D7DF7720A@gieschke.de>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de> <7vaaej9pt3.fsf@alter.siamese.dyndns.org> <2218C353-80FC-4540-A60E-608385384FB5@gieschke.de> <20110519122026.GA30240@sigill.intra.peff.net> <AE42113D-8D2F-4B24-A800-D49183152911@gieschke.de> <20110519173851.GA12295@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 19 21:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN8sd-0000LU-63
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 21:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934286Ab1EST10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 15:27:26 -0400
Received: from smtp1.goneo.de ([212.90.139.80]:47068 "EHLO smtp1.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933896Ab1EST1Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 15:27:25 -0400
Received: from smtp1.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 000D03A3B33;
	Thu, 19 May 2011 21:27:24 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.87
X-Spam-Level: 
X-Spam-Status: No, score=-2.87 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.030, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
	by smtp1.goneo.de (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YN5xzJr7wQRB; Thu, 19 May 2011 21:27:24 +0200 (CEST)
Received: from [10.167.157.160] (unknown [89.204.137.160])
	by smtp1-587.goneo.de (Postfix) with ESMTPSA id D43933A39A7;
	Thu, 19 May 2011 21:27:22 +0200 (CEST)
In-Reply-To: <20110519173851.GA12295@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173995>


Am 19.05.2011 um 19:38 schrieb Jeff King:

> I don't know enough about Android development to know how much
> commonality there is between devices and builds. AFAIK, the Android spec
> itself only provides the Java-callable API. So for Unix-y stuff like
> this, I have no idea what is on stock Android versus Cyanogen for
> instance, or even if what is on stock varies from handset to handset.

The common shared libraries (which should only be different among different Android versions - e.g. 2.2 vs. 2.1) are provided together with the toolchain in the Android NDK by Google. And as far as I can see, SSH/dropbear is on cyanogenmod as well as on stock Android (at least it is on the emulator). But there might be distributions from vendors without a SSH client.


> So yeah, we are probably better not even trying to provide a default set
> of flags for Android; we can support specific hacks (like your patches 1
> and 2) but leave it up to individual build environments to enable them
> as appropriate.

I agree.
