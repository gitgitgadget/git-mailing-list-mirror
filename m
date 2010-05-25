From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 25 May 2010 09:28:36 +0200
Message-ID: <4BFB7C24.10609@drmicha.warpmail.net>
References: <4BEAF941.6040609@puckerupgames.com> <20100514051049.GF6075@coredump.intra.peff.net> <4BED47EA.9090905@puckerupgames.com> <20100517231642.GB12092@coredump.intra.peff.net> <4BF2E168.2020706@puckerupgames.com> <20100518191933.GB2383@coredump.intra.peff.net> <alpine.LFD.2.00.1005181528550.12758@xanadu.home> <20100518194105.GA4723@coredump.intra.peff.net> <alpine.LFD.2.00.1005181557250.12758@xanadu.home> <4BF9C678.6010108@puckerupgames.com> <7vaarq14me.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John <john@puckerupgames.com>, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 25 09:28:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGoZL-0008JP-JX
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab0EYH2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 03:28:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60938 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753333Ab0EYH2u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 03:28:50 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 26FCBF7FDC;
	Tue, 25 May 2010 03:28:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 25 May 2010 03:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vqJ5KSd04HjkLbomBWC5uzMMS+s=; b=gGzScvG9UPz2xzfKo/SvM6mJP1TuXdoQYy7OdfpmI9mRvx3xsB4Bypa5tcBC1ZLL64J0c3w9vYJhyjoErcrYwHF7UUjoBC5q1JiCY9zI7ixOQQzBjsXRvb6XtpuLK6M457y8HIsTrx8qGCqQNX3msaxstupRMQJLoO4Al3NIim0=
X-Sasl-enc: wmXNji/bfqaK4kc2P472uOLNw8DTIf6k+NhTNtL+/Pww 1274772529
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 313EB448EE;
	Tue, 25 May 2010 03:28:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <7vaarq14me.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147678>

Junio C Hamano venit, vidit, dixit 24.05.2010 03:16:
> John <john@puckerupgames.com> writes:
> 
>> Is there any reason why someone would NOT want the above
>> ".gitattributes" defined by default?
> 
> Other than that our originally intended target audience are people who use
> git as a source code control system, not much.
> 

and other than that many people use clean/smudge filters to make git
happily and efficiently deltify compressed file formats (such as gz,
bz2, zip) and still keep compressed checkouts...

and other than that which you (plural) and I are not thinking of right now.

Let the defaults be as they are (fit for source control in the proper
sense), it's easy enough to change them for other use cases.

Michael
