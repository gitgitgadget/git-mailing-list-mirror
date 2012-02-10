From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git, Builds, and Filesystem Type
Date: Thu, 09 Feb 2012 19:08:45 -0700
Message-ID: <14de0389-6497-4e74-baa5-129b0c1560a3@email.android.com>
References: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com> <201202091453.38564.mfick@codeaurora.org> <CAE1pOi387-bimYEG4bjFOjaCwhPeDyLRj7wOJgyuKSCrZ9kBFg@mail.gmail.com> <201202091634.36563.mfick@codeaurora.org> <CAE1pOi1O10XeROv+sQRwAAVQ0PneMZTOaEfny-Oz2Sp+=z+aiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:11:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvfxc-0000l0-BB
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757365Ab2BJCLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:11:12 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11465 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754410Ab2BJCLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:11:12 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6615"; a="159707476"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 09 Feb 2012 18:11:11 -0800
Received: from [192.168.1.160] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 42BD410004D1;
	Thu,  9 Feb 2012 18:11:11 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAE1pOi1O10XeROv+sQRwAAVQ0PneMZTOaEfny-Oz2Sp+=z+aiA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190364>



>I found [1]. Is that sort of what you had in mind

yes

>That would be quite
>tricky. I have a group of some 60 projects, each with their own
>"target" directory which would have to be mounted on tmpfs. And the
>"target" directory is created by Maven, not by me. Not to mention that
>I shut down my computer at the end of the day. :-)

Sounds like a laptop?  Hibernate?

>I think I would prefer a somewhat more persistent solution. I
>certainly have enough space for a very big swap partition. So the
>whole of ~/my-project would fit on tmpfs. I'm just not sure about
>making it persistent at the end of the day.


Link your .git dir to a persistent location. 

Benchmark it first so you know how much hassle it may be worth.  If it isn't worth it, xfs or brtfs will likely not be worth it either,

-Martin
Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
