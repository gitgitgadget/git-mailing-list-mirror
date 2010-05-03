From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] git over TLS (gits://) support
Date: Mon, 03 May 2010 15:26:23 +0200
Message-ID: <4BDECEFF.7060900@drmicha.warpmail.net>
References: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi> <j2tbe6fef0d1005030557l1f746349zfce18213add19efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 15:26:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8vfR-0008MK-Dl
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 15:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759244Ab0ECN00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 09:26:26 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40711 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758975Ab0ECN0Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 09:26:25 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 06015F1EB9;
	Mon,  3 May 2010 09:26:25 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 03 May 2010 09:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=qcSAYllItsF8hVzEv+GyDZYtd/8=; b=fMZxhiH31GSV8+mE+tfGkqwsoXOoLdkF2UoUkUYyhwSlmX9Bpzs+NZvjWn2NQaaUsgDBOCLD96H4n6/Mh3OEQZown0widhuz4Jt6mkqsKtNk48rY4/rsXvAGbJYn1GDJhN+E4bpBnGSp7Kn4WQiYa3MORpteLC5Vi8TsrJRd1d0=
X-Sasl-enc: vN3i4ZMA69abWLXvjtsxG0nRDJ201iy1va0OyFWIvIfa 1272893184
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 177524C7A84;
	Mon,  3 May 2010 09:26:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <j2tbe6fef0d1005030557l1f746349zfce18213add19efe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146237>

Tay Ray Chuan venit, vidit, dixit 03.05.2010 14:57:
> Hi,
> 
> On Sun, May 2, 2010 at 1:09 AM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
>> This is newer version of gits:// client side support.
> 
> in case anyone is wondering where the older version is, Ilari posted
> it early this year:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/136816
> 
> From the discussion, Avery (Cc'ed) had some strong objections; the
> point that I remembered the most clearly was "why not just use SSH".
> There didn't seem to be any headway.
> 
> I hope that we can continue where we left off and resolve the various
> objections without too much duplication of shot-down arguments.
> 

Except for "This is a newer patch" and the split in 3 rather than 2,
there is no information whatsoever on what's different and which
questions have been addressed. Given that, it would be only fair to
raise the same objections again.

Condensing the old thread to a bare minimum, these questions seem to be
open (though answered, one might say):

- What ssh+git: problems does gits: address?
- What tells us these are solved by gits:?
- What tells us there are no gits: problems which ssh+git: would solve?

Frankly, so far I see no tests, no benchmarks, one author convinced by
his own code, and seemingly nobody willing to really look a the patches.

Michael
