From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and broken branch imports
Date: Thu, 3 Apr 2008 07:47:54 +0200
Message-ID: <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de>
References: <1207100091.10532.64.camel@gandalf.cobite.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Mansfield <david@cobite.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 07:55:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhIQ3-0003mx-Dt
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 07:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760821AbYDCFyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 01:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760777AbYDCFyn
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 01:54:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:49382 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760331AbYDCFym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 01:54:42 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.14.2/8.14.2) with ESMTP id m335l5Rj021525;
	Thu, 3 Apr 2008 07:47:06 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db92029.pool.einsundeins.de [77.185.32.41])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m335l34m002674
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 3 Apr 2008 07:47:04 +0200 (MEST)
In-Reply-To: <1207100091.10532.64.camel@gandalf.cobite.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78726>


On Apr 2, 2008, at 3:34 AM, David Mansfield wrote:

> P.S Also, as many people may have imported broken branches already,  
> can
> anyone thing of a way to fix the branch, (maybe with git-rebase or
> something)?  The breakage affects, I believe, files not ever  
> modified on
> the branch until any given point in time on the branch...
>

The breakage you describe might be the same breakage that I recognized
in June 2007:

   http://article.gmane.org/gmane.comp.version-control.git/50736

At that time, I wrote a script (git-transplant) that fixed a broken
import from CVS for me:

   http://article.gmane.org/gmane.comp.version-control.git/50746

The discussion in

   http://article.gmane.org/gmane.comp.version-control.git/50789

explains the reason for the script a bit more detailed.

But note that I never finished git-transplant and I also failed to
convince anyone that the idea behind the script is of any general value.
Instead, I decided that git-cvsimport is not the right tools for me; and
since then I use parsecvs to convert my repositories.

         Steffen
