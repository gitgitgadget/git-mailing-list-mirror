From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git Feature Request - show current branch
Date: Thu, 19 Feb 2015 17:21:05 +0100
Message-ID: <54E60D71.6050906@drmicha.warpmail.net>
References: <13b.3lxh{.41MsIT3sthY.1KvU6v@seznam.cz> <001801d04c48$732f9980$598ecc80$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Randall S. Becker" <rsbecker@nexbridge.com>, mdconf@seznam.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 17:21:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOTqj-0005DC-6B
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 17:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbbBSQVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 11:21:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33070 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbbBSQVH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 11:21:07 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 94ED120D79
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 11:21:06 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 19 Feb 2015 11:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=r217HJ06CBxQ9xKocH13Jj
	ZNkcg=; b=FHZUJWhnBAH6g2EjDn6bpt6rVls1iEgYnhi/HQdH7NakeHRkgi1xeM
	Wyx/BC86mzIe6flhuT/c2PxcL7o9wl1Sk0x9UzVPUv4Nl20pWCRwG6WHqHfIQRgh
	qZZKeK+lRXato4KAVeZeZDyyQREzXjrnI5aURqwhtm+y6h/P41fXI=
X-Sasl-enc: iAb+nodcYrKt5QF2o5jdLkzIqYu1uh9VewpXKbQfiJUb 1424362866
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 07D6E6801D3;
	Thu, 19 Feb 2015 11:21:05 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <001801d04c48$732f9980$598ecc80$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264102>

Randall S. Becker venit, vidit, dixit 19.02.2015 14:32:
> git symbolic-ref --short HEAD

That errors out when HEAD is detached.

git rev-parse --symbolic-full-name [--abbrev-ref] HEAD

returns the branch name or HEAD. Though it's a bit difficult to discover.

I guess git 3.0 will have "git branch" and "git branches" :)

Michael
