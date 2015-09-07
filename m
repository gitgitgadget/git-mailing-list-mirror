From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Standardization of messages - dot after the sentence
Date: Mon, 7 Sep 2015 09:14:59 +0200
Message-ID: <55ED3973.2020304@drmicha.warpmail.net>
References: <CALx9kCVwpOvBfTxBi8gn7MBajEbuMLGP_HAJ0TW3XGzmUE0=QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: sigo <spam@sigo.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 09:15:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYqdx-0001BC-Kf
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 09:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbbIGHPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 03:15:06 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56549 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751015AbbIGHPE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2015 03:15:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 350A0204B4
	for <git@vger.kernel.org>; Mon,  7 Sep 2015 03:15:01 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Mon, 07 Sep 2015 03:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=6w2AZbwIKQ6MoDTWjwMl1qq0qyo=; b=VeIIfZ
	beXU6bs429SaLXjVCuAI3S2GuFM5j1y8L5BrqH6pMeNdVTWFkbTUH6QkAmfHgTq7
	Tcm9kMFT7SIvgvmYc0E6iWjVbJ2EmbotvJ7wGXWbGSTwMW3dz9+Q669z4Stk2/wB
	FuQ7ePUTBnUg8sW+DOJst8rVSLwlXiznUToNo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=6w2AZbwIKQ6MoDT
	WjwMl1qq0qyo=; b=pvQOdidB+nbKaYXSEAeOfc1GxDx4m6CnfuCxYlI8kw9dV4g
	kxijgNWXAU3C0SYFVFqdwqc47a/pwPZCeXF1up8jEnadCjZuvoHw1+pkKpmYxuT+
	yqIax/ldrQ2aZEHxZSasiGBJtRwb48/HchckwVoZFgm2nffSzTw3LpGtG+E8=
X-Sasl-enc: siptD9eV7aOpcBPsCLTCYQiF6azYcfBuryuj+sNKVTm5 1441610100
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A66C76801CB;
	Mon,  7 Sep 2015 03:15:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CALx9kCVwpOvBfTxBi8gn7MBajEbuMLGP_HAJ0TW3XGzmUE0=QA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277447>

sigo venit, vidit, dixit 05.09.2015 14:22:
> I've found really "little bug" with dots in the git output.
> 
> $ git push
> Everything up-to-date
> 
> git pull
> Already up-to-date.
> 
> Could all phrases contain dots? :)
> 

In this case, also both messages mean the same but are phrased
differently, which is suboptimal in more than one way.

It would be good to change them systematically (not just in these 2
spots) - and that would make for a perfect first foray into submitting
patches, hint hint hint :)

Michael
