From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Git, Builds, and Filesystem Type
Date: Thu, 9 Feb 2012 14:53:38 -0700
Organization: CAF
Message-ID: <201202091453.38564.mfick@codeaurora.org>
References: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:53:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvbw0-0003eJ-CB
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab2BIVxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:53:40 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:44747 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab2BIVxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:53:39 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6615"; a="159647562"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 09 Feb 2012 13:53:39 -0800
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 40CB310004D1;
	Thu,  9 Feb 2012 13:53:39 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <CAE1pOi1of-hj+87M7RqhFUWA8an14bPG88dAOwhNogmfFvJ=tA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190330>

On Thursday, February 09, 2012 02:23:18 pm Hilco Wijbenga 
wrote:
> For the record, our (Java) project is quite small. It's
> 43MB (source and images) and the entire directory tree
> after building is about 1.6GB (this includes all JARs
> downloaded by Maven). So we're not talking TBs of data.
> 
> Any thoughts on which FSs to include in my tests? Or
> simply which FS might be more appropriate?

tmpfs is probably fastest hands down if you can use it (even 
if you have to back it by swap).

-Martin

-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
