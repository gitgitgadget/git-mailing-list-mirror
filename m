From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git-svn repo in weird state
Date: Fri, 19 Aug 2011 11:54:57 +0200
Message-ID: <4E4E32F1.9040808@drmicha.warpmail.net>
References: <85C67F68-AEF7-4E98-9388-C16BD04A68F8@apple.com> <2F128636-95A4-4216-894A-F0295A2D23EB@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 11:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuLnS-0006Xl-J5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 11:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250Ab1HSJzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 05:55:04 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51798 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752570Ab1HSJzB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 05:55:01 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 220A520F93;
	Fri, 19 Aug 2011 05:55:00 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 19 Aug 2011 05:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Vaj25aBF4PFEUkTrIafsZz
	cBmsY=; b=iXY9uDoQzMu3djbLRyJYuNh2oiOVgMeSeJf0snBmceANsa9jZVWgcr
	nbBAj30c2tOpq0PdzzsqFxjMGOuqZEgrYKN9ZYaLogEFiOCxxTUiilqtMZFOGOVg
	MkiOcobAI53Sa65rUZ4/ElDyBTAvASZGdfpGuwHxa5cOdXqUgol28=
X-Sasl-enc: bsrTxLYL7rinGSXt9gu3FxL+k5hN9VNhvF7rIZT/3LRd 1313747699
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 83E1245B063;
	Fri, 19 Aug 2011 05:54:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <2F128636-95A4-4216-894A-F0295A2D23EB@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179687>

Dave Zarzycki venit, vidit, dixit 18.08.2011 16:22:
> After introspecting the .git directory, it seems like a stale .git/master was created somehow. Why does git-show-ref not show .git/master as a ref?

Because it's not in .git/refs/?

Michael
