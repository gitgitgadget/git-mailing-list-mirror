From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git pull with "no common commits" : danger?
Date: Thu, 08 Apr 2010 10:08:24 +0800
Message-ID: <4BBD3A98.2020207@drmicha.warpmail.net>
References: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 04:08:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzhAb-0001Wk-Nh
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 04:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758326Ab0DHCIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 22:08:32 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46080 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754453Ab0DHCIb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 22:08:31 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1E906EA67E;
	Wed,  7 Apr 2010 22:08:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 07 Apr 2010 22:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tgDoidQcKY74fPKgtcHjIcy6xQQ=; b=fQ5T9UsvBYwghifg68+k4UFh0LdMF8eMXoSYfF/RriSTkRCXb60S1xfV4Jf59uSn+ChsFPqDcmpIbGmqWzdSomObLFwTPQ6XxAHSXtrhi7urOYWQuHWIQeXFiS9a9e3EhVM31lO4r538K1UVvL9PUxm8Ll9K39lLb1FCk04BBis=
X-Sasl-enc: 4zJZ3/spQFEMIf01vW+gC0uzxGPAkw3xepI+zzDcdQ71 1270692510
Received: from localhost.localdomain (unknown [202.113.236.7])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 310F94A8C04;
	Wed,  7 Apr 2010 22:08:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <v2t3abd05a91004071856s5811e086q17241996a359e172@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144304>

Aghiles venit, vidit, dixit 08.04.2010 09:56:
> Hello,
> 
> I mistakenly pulled a project into another project. I had the
> "warning: no common commits" but the pull did proceed.
> I am wondering if, from a usability point of view, it would be
> best to avoid doing so by default.

Puleeezze: No animals were harmed during the process, right? I mean, no
data loss, all you have to do is a git reset. Let's try and not make Git
into "Are you sure"dom.

Michael
