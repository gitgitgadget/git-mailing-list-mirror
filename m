From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitk won't show notes?
Date: Tue, 07 Apr 2015 15:40:54 +0200
Message-ID: <5523DE66.8060904@drmicha.warpmail.net>
References: <551D99B9.7040200@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 15:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfTkT-000534-Ev
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 15:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753682AbbDGNk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 09:40:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59676 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753511AbbDGNk4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 09:40:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 98EEB20CEC
	for <git@vger.kernel.org>; Tue,  7 Apr 2015 09:40:51 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Tue, 07 Apr 2015 09:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=BItJiQmbIqCrXD9rjLcim/g6rXo=; b=K9pNyQ
	Y0xDoI7gK0J8sL+mrSBTUj/WOET+DcSKYq8JEhgwXsFaN5Af8PB6zK9kqlwFQWPX
	OXXJz2JwpMplpoOdVuJhBPC2hkXQHJ8fcDY17IN+LZd86qWr3vRFvCU3vp354fbK
	okYsbs+DiX9t85CTljkLAA+0V6276pGmCGRDQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=BItJiQmbIqCrXD9
	rjLcim/g6rXo=; b=H1XOSQ2RusAqLjTqbZnhRCIEpiYclOkjeN8SzVDcYC7ncXi
	ql6OO5Y33F2973Y55D41lakT8XXy5zrgKvb/MslCTCPqw+7MkkDHfvG8O2l+GxjV
	xGz7G76UHn2RQutYRsE+PU4fRUMMrCKSkoOgd8tC+oddcbQaQrisoy5zfoPI=
X-Sasl-enc: bzL61z4/ExE0N8hV6zFQBEcuxScaois9ti6ebGkVkIiA 1428414055
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F2AF36801F0;
	Tue,  7 Apr 2015 09:40:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <551D99B9.7040200@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266912>

Phillip Susi venit, vidit, dixit 02.04.2015 21:34:
> I can't seem to get gitk to show notes, even when I give it --notes.
> Does it just not handle notes?
> 
> 

Have you tried with "--show-notes"?

It works over here even without --show-notes, by the way, but I'm not on
Windows. Are you?

Michael
