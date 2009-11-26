From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 2/2] status -s: obey color.status
Date: Thu, 26 Nov 2009 17:03:43 +0100
Message-ID: <4B0EA6DF.6070701@drmicha.warpmail.net>
References: <cover.1259248243.git.git@drmicha.warpmail.net> <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net> <4B0EA06A.1050101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 17:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgq2-00012E-QU
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 17:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbZKZQEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 11:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756117AbZKZQEr
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 11:04:47 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40709 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756297AbZKZQEq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 11:04:46 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 69D48C285C;
	Thu, 26 Nov 2009 11:04:52 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 26 Nov 2009 11:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=pV3P3BawOJ3W60e9+o4mZrnbmRg=; b=NNL3jpIsUdrzvjTayAhSia115k/SDLMEIF53kNdGSr4Em4fdKQacL/7ztK7BhHMb+9g/F3V/Djr31ypDsCE1hKDJU5jKVPL9beRqXC5ngzwZSGLJy8nl/LM4R1amdRjSR+bRcxmqww3qPR5mhdy4DkDs3jmvAqDO5q/DsITMMkA=
X-Sasl-enc: kutJEeT/1S9asxDsKqeKcfsSEjqMtcczl5oRbEHTCdFY 1259251492
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B60012E77E;
	Thu, 26 Nov 2009 11:04:51 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <4B0EA06A.1050101@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133805>

Johannes Sixt venit, vidit, dixit 26.11.2009 16:36:
> Michael J Gruber schrieb:
>> * Is there any policy regarding use of putchar/puts vs. printf?
> 
> If the printed string contains color escapes that should be obeyed, you
> can use only fputs, printf, and fprintf. You should not use puts or putchar.

Oh, I don't use them with colors. I use only color_fprintf for that. I
was wondering whether there's a preference of printf("%c", c) over
putchar(c), for example.

>> * Even if I were to write tests for status -s: How do I test colors?
> 
> See t4034-diff-words.sh.

Thanks, I'll keep that in mind for the case that I do have to write test ;)

Michael
