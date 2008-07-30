From: Kevin Ballard <kevin@sb.org>
Subject: Re: git help broken
Date: Wed, 30 Jul 2008 16:45:27 -0700
Message-ID: <88026755-3022-43A5-921C-D11244E1F723@sb.org>
References: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org> <alpine.LSU.1.00.0807310141060.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 01:47:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLNm-00089m-Cs
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 01:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbYG3Xp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 19:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbYG3Xp6
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 19:45:58 -0400
Received: from mail.rapleaf.com ([208.96.16.213]:47768 "EHLO mail.rapleaf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbYG3Xp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 19:45:58 -0400
Received: from mail.rapleaf.com (localhost.localdomain [127.0.0.1])
	by mail.rapleaf.com (Postfix) with ESMTP id BA7101250342;
	Wed, 30 Jul 2008 16:45:57 -0700 (PDT)
Received: from [192.168.1.80] (unknown [192.168.1.80])
	by mail.rapleaf.com (Postfix) with ESMTP id A2C8912500B6;
	Wed, 30 Jul 2008 16:45:57 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0807310141060.3486@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90877>

On Jul 30, 2008, at 4:42 PM, Johannes Schindelin wrote:

> On Wed, 30 Jul 2008, Kevin Ballard wrote:
>
>> `git help diff` no longer finds the git-diff manpage (as of tip of  
>> next
>> branch). I haven't tested, but I suspect
>> 940208a771066229bc6a486f6a058e332b71cfe4 is responsible.
>
> Just to save everybody else and her dog the trouble: that commit's  
> oneline
> is "builtin-help: make some internal functions available to other
> builtins".
>
> And from the patch, it is pretty obvious that it does not come close  
> to
> the "man" code path.

I suspected it because it was the only non-merge commit since my last  
pull that mentioned "help" in the message. Regardless, Miklos has  
posted a patch that works.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
