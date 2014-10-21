From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: please document --cached option to git-difftool
Date: Tue, 21 Oct 2014 10:10:45 +0200
Message-ID: <54461505.80608@drmicha.warpmail.net>
References: <20141020212415.GA532@nahmias.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Joseph Nahmias <joe@nahmias.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 10:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgUWr-0007Xu-An
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 10:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbaJUIKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 04:10:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33397 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753539AbaJUIKq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2014 04:10:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway2.nyi.internal (Postfix) with ESMTP id 637F7207FA
	for <git@vger.kernel.org>; Tue, 21 Oct 2014 04:10:46 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 21 Oct 2014 04:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=/jufW3duqHwESzjY2Zf2c2
	A+tA0=; b=PUO6jRIjnirRaY3Nr5vPIq5Vu8wKjuc45aounNl7s0v+75ZLHgN/fD
	t60tmjRfjIXazyCsq2LM/3oc+7dNfUv0KUKIPzKLvq30s/uly9ljqWLlKyaHm0sd
	OBBGDs/LI43wJu+E+Rj2twjRGFhM/RdUfR5cZG1B9EKFLQ4ZU4kLo=
X-Sasl-enc: +in6Jc243ykYAxRhcNzURhwYcXmdGeDatAXgsiQst3yt 1413879046
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DDC4FC00008;
	Tue, 21 Oct 2014 04:10:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <20141020212415.GA532@nahmias.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joseph Nahmias schrieb am 20.10.2014 um 23:24:
> Hello,
> 
> It would be great if the documentation showed that the git-difftool(1)
> command accepted the --cached option.  You can probably steal appropriate
> verbiage from the git-diff(1) manpage.
> 
> $ git --version
> git version 2.1.1
> 
> Thanks,
> --Joe
> 

>From git-difftool(1):

"git difftool is a frontend to git diff and accepts the same options and
arguments. See git-diff(1)."

Michael
