From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Auto update submodules after merge and reset
Date: Mon, 5 Dec 2011 17:06:20 -0800
Message-ID: <4EDD6A8C.40008@qualcomm.com>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 06 02:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXjUb-0007Qj-7E
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 02:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932842Ab1LFBGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 20:06:24 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:18907 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759Ab1LFBGV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 20:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=maxk@qualcomm.com; q=dns/txt;
  s=qcdkim; t=1323133581; x=1354669581;
  h=message-id:date:from:user-agent:mime-version:to:cc:
   subject:references:in-reply-to:content-type:
   content-transfer-encoding:x-originating-ip;
  z=Message-ID:=20<4EDD6A8C.40008@qualcomm.com>|Date:=20Mon,
   =205=20Dec=202011=2017:06:20=20-0800|From:=20Max=20Krasny
   ansky=20<maxk@qualcomm.com>|User-Agent:=20Mozilla/5.0=20(
   X11=3B=20Linux=20x86_64=3B=20rv:8.0)=20Gecko/20111124=20T
   hunderbird/8.0|MIME-Version:=201.0|To:=20Jens=20Lehmann
   =20<Jens.Lehmann@web.de>|CC:=20<git@vger.kernel.org>
   |Subject:=20Re:=20Auto=20update=20submodules=20after=20me
   rge=20and=20reset|References:=20<4ED57EED.4040705@qualcom
   m.com>=20<4ED5E9D2.4060503@web.de>|In-Reply-To:=20<4ED5E9
   D2.4060503@web.de>|Content-Type:=20text/plain=3B=20charse
   t 
X-IronPort-AV: E=McAfee;i="5400,1158,6551"; a="141671775"
Received: from ironmsg04-r.qualcomm.com ([172.30.46.18])
  by wolverine02.qualcomm.com with ESMTP; 05 Dec 2011 17:06:21 -0800
X-IronPort-AV: E=Sophos;i="4.71,299,1320652800"; 
   d="scan'208";a="215016213"
Received: from nasanexhc05.na.qualcomm.com ([172.30.48.2])
  by Ironmsg04-R.qualcomm.com with ESMTP/TLS/AES128-SHA; 05 Dec 2011 17:06:21 -0800
Received: from [10.50.16.24] (172.30.48.1) by qcmail1.qualcomm.com
 (172.30.48.2) with Microsoft SMTP Server (TLS) id 14.1.339.1; Mon, 5 Dec 2011
 17:06:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <4ED5E9D2.4060503@web.de>
X-Originating-IP: [172.30.48.1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186303>

Hi Jens,

On 11/30/2011 12:31 AM, Jens Lehmann wrote:
> I'm working on a patch series to teach Git to optionally update the 
> submodules work trees on checkout, reset merge and so on, but I'm not 
> there yet.
> [SNIP]

Sorry for not replying right away.
Everything you suggested sounds great. We're on the same page (config 
option, etc).
How far along are you? Do you have a tree I could pull from to play with 
things?
I could help with testing, bug fixes and/or implementing parts of it. 
Let me know.

For now I implemented automatic submodules update using 'post-merge' 
hook. But obviously it does
not handle reset and things. I'm thinking of adding 'post-reset' and 
'pre-merge' that would be useful
for this and maybe other things.

Thanx
Max
