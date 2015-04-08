From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: gitk won't show notes?
Date: Wed, 08 Apr 2015 13:51:40 +0200
Message-ID: <5525164C.6000309@drmicha.warpmail.net>
References: <551D99B9.7040200@ubuntu.com> <5523DE66.8060904@drmicha.warpmail.net> <5523E479.2010701@ubuntu.com> <5523E5FF.8060101@drmicha.warpmail.net> <55240F0A.80902@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 13:51:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfoWJ-0005MM-8q
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 13:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbbDHLvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 07:51:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33632 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751598AbbDHLvm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2015 07:51:42 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 121DA20E6A
	for <git@vger.kernel.org>; Wed,  8 Apr 2015 07:51:38 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 08 Apr 2015 07:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=fXnBT1DMrih/qxBYEF4wk5OLdeI=; b=OCdDg5
	WqsfdLaqoboEYm8H+6rPXNmfDyFbOPYkBkyI7SMFH9qsFTx6WwkWzDzTrsHRuOyb
	Nntue8hpyZUUNEzwCfj3+QowRqriXAIMYKfTa779wWffrGBg+DckUaTV2nb3fdCa
	5RiCPiswcdV0JhGpNh+IxpdG+5IUMA5lQlTXI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=fXnBT1DMrih/qxB
	YEF4wk5OLdeI=; b=VO4scC5ABPPKsMruBpXJo6dISem9st5pRi4RXr+h2meVLoF
	0b2+PXTtIDb65LpTovhUrFMmIksipFTyo4nzOyvB17wHERLoqpwWILBTlir5bs4J
	Y9CEIyl0Qg4kgkBlF769Qews2MQluBxHspVfgyKlLV1toiA2AMdcC9PlMnl8=
X-Sasl-enc: /ZcnJU4krpNAmRDgEvSWGzCWqBv1dXgUeUSZ451gJ4F4 1428493901
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 64F2E6801A0;
	Wed,  8 Apr 2015 07:51:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <55240F0A.80902@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266958>

Phillip Susi venit, vidit, dixit 07.04.2015 19:08:
> On 4/7/2015 10:13 AM, Michael J Gruber wrote:
>> Seriously: gitk knows F5 and Shift-F5 for refresh, and I think the 
>> latter is the thorougher refreshment.
> 
> Neither one makes newly added notes show up.  The only way seems to be
> to close and restart gitk.  Looks like a bug.
> 
> 

Apparently, gitk rereads the refs but not commits it has read already -
and the commit reading includes the notes lookup.

Unfortunately, my wish-fu is lacking. But I'll cc the master.

Paulus: None of updatecommits, reloadcommits and rereadrefs seem to
reread the notes of a commit that has been displayed already if the
notes have changed (but the other refs have not).

Michael
