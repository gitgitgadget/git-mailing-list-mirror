From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git is not scalable with too many refs/*
Date: Thu, 29 Sep 2011 14:11:06 -0600
Organization: CAF
Message-ID: <201109291411.06733.mfick@codeaurora.org>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 29 22:11:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Mws-0005h2-HM
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 22:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624Ab1I2ULJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Sep 2011 16:11:09 -0400
Received: from wolverine01.qualcomm.com ([199.106.114.254]:15337 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab1I2ULI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 16:11:08 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6484"; a="123577332"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 29 Sep 2011 13:11:08 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id D55EC10004BE;
	Thu, 29 Sep 2011 13:11:07 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <4E84B89F.4060304@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182429>

On Thursday, September 29, 2011 12:27:43 pm Ren=C3=A9 Scharfe=20
wrote:
> Hmm.  Can we get rid of the multiple ref lookups fixed by
> the above *and* the overhead of dealing with a textual
> argument list at the same time by calling
> add_pending_object directly, like this?  (Factoring out
> add_pending_sha1 should be a separate patch..)
=20
Ren=C3=A9,

Your patch works well for me.  It achieves about the same=20
gains as Julian's patch. Thanks!

After all the performance fixes get merged for large ref=20
counts, it sure should help the Gerrit community.  I wonder=20
how it might impact Gerrit mirroring...

-Martin


Employee of Qualcomm Innovation Center, Inc. which is a=20
member of Code Aurora Forum
