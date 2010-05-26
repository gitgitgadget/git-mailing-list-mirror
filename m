From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] t1304,t2007: quell output to stdout and stderr
Date: Wed, 26 May 2010 11:08:15 +0200
Message-ID: <4BFCE4FF.60500@drmicha.warpmail.net>
References: <20100421151236.GB8726@progeny.tock> <5ef48a01f29730a24b74d599bb9b89e77591decf.1271969046.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed May 26 11:08:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHCbM-0001Df-HD
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 11:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab0EZJIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 05:08:32 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36820 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422Ab0EZJIb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 05:08:31 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4DDA4F896C;
	Wed, 26 May 2010 05:08:31 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 26 May 2010 05:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0Jv3AwI95gHF3t2UIyfHJTU3PKI=; b=RRS42t6fXrTrPR3CPham5X/JJiWzYG0VDSXGk2/BNCS7RvY83oXAEcjCZatKdscfH76NZc842QGEr2z5vbgt2GORaRXVibYevtI/fX3SMps4v/nV1UsPNR3s6cWa+dP66cW8OVBZHd3OnZ0BtIMxeAqVuVQmLVUhefwRvyRK3Es=
X-Sasl-enc: LnNUoU70tGzFz1oxJPdwMzSgvALle8q5X6UZnLwEEAZo 1274864910
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7CA2E12F7F;
	Wed, 26 May 2010 05:08:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <5ef48a01f29730a24b74d599bb9b89e77591decf.1271969046.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147787>

Michael J Gruber venit, vidit, dixit 22.04.2010 22:45:
> These tests send output to stdout or stderr even without -v. This is
> distracting because unexpected output flashing by during make test
> usually indicates problems.
> 
> Shut them up unconditionally by integrating them in test code: In both
> cases, the output was due to intermediate commands in between the actual
> test cases.
> 
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---

ping...
