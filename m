From: Martin Fick <mfick@codeaurora.org>
Subject: Re: git hangs on pthread_join
Date: Thu, 23 May 2013 13:45:38 -0600
Organization: CAF
Message-ID: <201305231345.38190.mfick@codeaurora.org>
References: <20130523130143.GA6376@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Thu May 23 21:45:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfbSP-0003jz-M1
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758776Ab3EWTpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:45:40 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:39299 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758314Ab3EWTpj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:45:39 -0400
X-IronPort-AV: E=Sophos;i="4.87,730,1363158000"; 
   d="scan'208";a="50208577"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 May 2013 12:45:39 -0700
Received: from mfick-lnx.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E211810004CA;
	Thu, 23 May 2013 12:45:38 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <20130523130143.GA6376@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225287>

On Thursday, May 23, 2013 07:01:43 am you wrote:
> 
> I'm running a rather special configuration, basically i
> have a gerrit server pushing
... 
> I have found "git receive-pack"s that has been running
> for days/weeks without terminating....
> 
... 
> Anyone that has any clues about what could be going
> wrong? --


Have you narrowed down whether this is a git client problem, 
or a server problem (gerrit in your case).  Is this a 
repeatable issue.  Try the same operation against a clone of 
the repo using just git.  Check on the server side for .noz 
files in you repo (a jgit thing),

-Martin
