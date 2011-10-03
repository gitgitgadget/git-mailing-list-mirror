From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] transport: do not allow to push over git:// protocol
Date: Mon, 03 Oct 2011 10:44:23 +0200
Message-ID: <4E8975E7.2040804@viscovery.net>
References: <1317432415-9459-1-git-send-email-pclouds@gmail.com> <20111003074250.GB9455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 10:44:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAe8X-0003tL-7l
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 10:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab1JCIo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 04:44:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61046 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769Ab1JCIo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 04:44:27 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RAe8N-0004RK-Us; Mon, 03 Oct 2011 10:44:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id AE4CF1660F;
	Mon,  3 Oct 2011 10:44:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <20111003074250.GB9455@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182639>

Am 10/3/2011 9:42, schrieb Jeff King:
> I still think push-over-git:// is a bit insane, and especially now with
> smart-http, you'd be crazy to run it. And in that sense, I wouldn't mind
> seeing it deprecated.

You must be kidding ;) It is so much easier to type

  git daemon --export-all --enable=receive-pack

for a one-shot, temporary git connection compared to setting up a
smart-http, ssh, or even a rsh server.

-- Hannes
