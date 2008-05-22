From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Add a test for another combination of --reference
Date: Fri, 23 May 2008 00:34:33 +0200
Message-ID: <200805230034.33567.johan@herland.net>
References: <alpine.LNX.1.00.0805221800090.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri May 23 00:36:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJOf-0007wX-R0
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 00:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399AbYEVWfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758016AbYEVWfi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 18:35:38 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54051 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063AbYEVWfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 18:35:37 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K1A00B2JK3CNH00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 23 May 2008 00:35:36 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1A00114K1LFL70@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 23 May 2008 00:34:33 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1A00C1QK1L2XT3@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 23 May 2008 00:34:33 +0200 (CEST)
In-reply-to: <alpine.LNX.1.00.0805221800090.19665@iabervon.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82666>

On Friday 23 May 2008, Daniel Barkalow wrote:
> From: Johan Herland <johan@herland.net>
> 
> In this case, the reference repository has some useful loose objects,
> but not all useful objects, and we make sure that we can find the
> objects we fetch from the repository we're cloning in the new
> repository, instead of potentially being distracted by the reference
> repository.
> 
> Doing the wrong thing in a builtin-clone implementation would lead to
> this looking for an object in the wrong place, not finding it (because
> it's only in the right place), and crashing.
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

Thanks again.

...Johan

PS: I'm holding off on submitting my builtin-clone-packs-refs series until
1.5.6 is out. I think builtin-clone has seen enough action in this cycle. :)

-- 
Johan Herland, <johan@herland.net>
www.herland.net
