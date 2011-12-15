From: Martin Fick <mfick@codeaurora.org>
Subject: Re: git help prune accuracy?
Date: Thu, 15 Dec 2011 14:53:52 -0700
Organization: CAF
Message-ID: <201112151453.52157.mfick@codeaurora.org>
References: <201112151432.09252.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJFW-0004lO-AS
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518Ab1LOVxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:53:54 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:57981 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759376Ab1LOVxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:53:53 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6561"; a="147205234"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 15 Dec 2011 13:53:53 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E90E110004C4
	for <git@vger.kernel.org>; Thu, 15 Dec 2011 13:53:52 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-28-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201112151432.09252.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187244>

On Thursday, December 15, 2011 02:32:09 pm Martin Fick 
wrote:
> I admit that I am guessing here, but I was wondering if
> this paragraph from git help prune was a incorrect, it
> says:
> 
>   This runs git fsck --unreachable using all the refs
>   available in refs/, optionally with additional set of
>   objects specified on the command line, and prunes all
>   unpacked objects unreachable from any of these head
>   objects from the object database. In addition, it
> prunes the unpacked objects that are also found in packs
> by running git prune-packed.
> 
> The last sentence seems like it should maybe have the
> following fix:
> 
> s/it prunes the unpacked/it prunes the unreferenced/

Ack, I meant:

s/it prunes the unpacked/it prunes the unreachable/

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
