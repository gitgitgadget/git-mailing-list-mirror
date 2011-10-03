From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: unable to resolve reference refs/tags/v3.1-rc8: Success
Date: Mon, 03 Oct 2011 00:11:42 -0500
Message-ID: <4E89440E.8060702@lwfinger.net>
References: <4E892483.7070605@lwfinger.net> <20111003035907.GA17134@elie> <4E8936F4.5060506@lwfinger.net> <20111003044045.GA17289@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 03 07:12:01 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RAaoq-0001KX-DN
	for glk-linux-kernel-3@lo.gmane.org; Mon, 03 Oct 2011 07:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189Ab1JCFLw (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 3 Oct 2011 01:11:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38326 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab1JCFLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2011 01:11:46 -0400
Received: by ywb5 with SMTP id 5so3060578ywb.19
        for <multiple recipients>; Sun, 02 Oct 2011 22:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=caYmNRpVtz+kt9t/+y35BYqEGGne/Fptpwq8CJ2ckBs=;
        b=qpWcQZm/YnlVKluV9FTV3jQ31GUSlKGBMVTmqT/5VhymyqNyClVbPyjGI2x4fbvm6A
         Xyjlsqde5iZWcftht9baCjS48g+jEl6iekH3jQVOI/ieVAii9gY6Kpjrm3fYUhS1Ignr
         VQOkMllW3LCQWY4sgwpAhW+OTzY69fvHMO+JA=
Received: by 10.151.20.12 with SMTP id x12mr12523444ybi.367.1317618705515;
        Sun, 02 Oct 2011 22:11:45 -0700 (PDT)
Received: from larrylap.site (cpe-65-28-92-85.kc.res.rr.com. [65.28.92.85])
        by mx.google.com with ESMTPS id z5sm34393522anz.7.2011.10.02.22.11.44
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 22:11:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <20111003044045.GA17289@elie>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182622>

On 10/02/2011 11:40 PM, Jonathan Nieder wrote:
> Larry Finger wrote:
>
>> After applying that patch, I get
>>
>> finger@larrylap:~/linux-2.6>  ~/git/git pull
>> fatal: ref refs/tags/v3.1-rc8 is corrupt: length=41, content=
>
> Great, thanks.
>
> In the short term I'd suggest just removing the corrupt
> .git/refs/tags/v3.1-rc8 file with "rm" so it can be fetched again.
> Hopefully later tonight I can prepare a real patch to fix this, though
> I wouldn't mind if someone else takes care of it first.

Thanks. That did the trick.

Larry
