From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Better mail handling in stgit
Date: Sun, 18 Sep 2005 09:19:51 +0100
Message-ID: <1127031591.6959.3.camel@localhost.localdomain>
References: <432C1B71.4090105@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 10:20:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGuP0-0001wz-Jl
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 10:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbVIRITz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 04:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVIRITz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 04:19:55 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:34538 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751328AbVIRITz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 04:19:55 -0400
Received: from aamta09-winn.ispmail.ntl.com ([81.103.221.35])
          by mta07-winn.ispmail.ntl.com with ESMTP
          id <20050918081953.BEF21883.mta07-winn.ispmail.ntl.com@aamta09-winn.ispmail.ntl.com>;
          Sun, 18 Sep 2005 09:19:53 +0100
Received: from cpc3-cmbg5-3-0-cust199.cmbg.cable.ntl.com ([81.104.194.199])
          by aamta09-winn.ispmail.ntl.com with ESMTP
          id <20050918081953.SJNQ13031.aamta09-winn.ispmail.ntl.com@cpc3-cmbg5-3-0-cust199.cmbg.cable.ntl.com>;
          Sun, 18 Sep 2005 09:19:53 +0100
To: Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <432C1B71.4090105@drzeus.cx>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8777>

On Sat, 2005-09-17 at 15:34 +0200, Pierre Ossman wrote:
> Fix some issues with the mail function in StGIT:
> 
>  * Allow multiple To/Cc/Bcc command line options.
> 
>  * Better parsing of mail addresses.

Applied. Thanks.

On a side note, since people don't usually send patches against the
latest HEAD and git-apply fails, I implemented a --base option for
import which applies the patch on a given commit id and performs a
three-way merge with the current HEAD. It's much easier to fix the diff3
conflicts than modify the patch file to apply cleanly (with no fuzz).

-- 
Catalin
