From: Martin Fick <mfick@codeaurora.org>
Subject: Re: hook for rebase --continue
Date: Mon, 7 Nov 2011 12:46:34 -0700
Organization: CAF
Message-ID: <201111071246.35100.mfick@codeaurora.org>
References: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 20:46:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNV9W-0006DU-3C
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 20:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab1KGTqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 14:46:38 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:21060 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab1KGTqh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 14:46:37 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6523"; a="133139490"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 07 Nov 2011 11:46:37 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E823510004D5;
	Mon,  7 Nov 2011 11:46:36 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CALts4TQ545L1d1J0EiUjd7x=WBJpjCCv6UsXZOoGQAC29RqC5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185019>

On Monday, November 07, 2011 12:42:32 pm Matt Graham wrote:
> Does anyone else share my expectation that the pre-commit
> hook should run during a rebase? Or at least for the
> first commit following a rebase conflict?

I have had the same concern.  We use a change-id hook for 
Gerrit development, and it adds a footer line to commit 
messages.  If during a rebase, it is accidentally removed, 
the hook does not get run and does not re-add it,

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
