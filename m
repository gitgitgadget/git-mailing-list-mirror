From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] clone: report check out for non-bare clones
Date: Wed, 12 May 2010 09:59:33 +0200
Message-ID: <4BEA5FE5.3060503@drmicha.warpmail.net>
References: <4BE7E09F.3040303@drmicha.warpmail.net> <3521b4733b58bfa516303fafc64d87f05760ea02.1273502583.git.git@drmicha.warpmail.net> <7vljbp994c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pete Harlan <pgit@pcharlan.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 12 09:59:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC6qs-0007YM-DH
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 09:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab0ELH73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 03:59:29 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46856 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753798Ab0ELH73 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 May 2010 03:59:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 02F01F5FB8;
	Wed, 12 May 2010 03:59:28 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 12 May 2010 03:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5GOOd7A9AnfmE/e/NrrTfviMtb4=; b=WOGB48pdmtqY8ZLDL/+JbyYUV4yI/CpsOIDAiQgcsSUgZEsr42+yFrj00A+yvvQzPTNm8JHVGDg66cPQIauVRsxnd+pJJF17fl40/o0i+ZKZRKjtoaxW8O2lErHUe/vBYA0O3cxkDHhAkNR7uG0F2Yzj/nfFiZDSflvJh/Z3zNE=
X-Sasl-enc: ZSzGHTjVNenEzOp9aD3l+Fmo9GzgNGtQPA1K01KpNMwE 1273651167
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2DFD34D55EA;
	Wed, 12 May 2010 03:59:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <7vljbp994c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146930>

Junio C Hamano venit, vidit, dixit 12.05.2010 03:55:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> In the case of a detached head, (null) is the branch name.
> 
> I think that depends on your particular libc implementation that helpfully
> makes printf("%s", NULL) not to at least dump core.

Sorry, I didn't know I can't rely on that. I'll change that if going
this route (reporting check out) is desirable at all. Is it?

Michael
