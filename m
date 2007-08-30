From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: Buffer overflows
Date: Thu, 30 Aug 2007 22:26:14 +0200
Message-ID: <46D727E6.1060006@etek.chalmers.se>
References: <1188502009.29782.874.camel@hurina>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Thu Aug 30 22:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQqaq-0003Ig-Pe
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 22:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758171AbXH3U0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 16:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758733AbXH3U0S
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 16:26:18 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:37739 "EHLO
	anubis.medic.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbXH3U0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 16:26:17 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by anubis.medic.chalmers.se (Postfix) with ESMTP id 95438E3F6;
	Thu, 30 Aug 2007 22:26:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.6) Gecko/20070804 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <1188502009.29782.874.camel@hurina>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57065>

Timo Sirainen wrote:
> Attached once again beginnings of safer string handling functions, which
> should be easy to use to replace the existing string handling code. I
> even thought about creating some kind of an automated tool to do this,
> but that's a bit too much trouble with no gain for myself.

How about using an existing string handling library instead of
creating another one from scratch?

One library worth looking at might be "The Better String Library"[1].

It claims to be both portable, stable, secure and have high performance.

/Lukas

[1] http://bstring.sourceforge.net/
