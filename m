From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git log missing last line of output
Date: Wed, 27 May 2009 21:06:30 +0200
Message-ID: <200905272106.31036.j6t@kdbg.org>
References: <gvhrtf$vpr$1@ger.gmane.org> <4A1D5F70.4030101@drmicha.warpmail.net> <gvjsc9$f40$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Wed May 27 21:07:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9OTK-0007FD-L5
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 21:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047AbZE0TGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 15:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757326AbZE0TGe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 15:06:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:61012 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757213AbZE0TGd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 15:06:33 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7C864CDF8C;
	Wed, 27 May 2009 21:06:31 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7EC9542767;
	Wed, 27 May 2009 21:06:31 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <gvjsc9$f40$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120094>

Please use "Reply to all" so that Cc list remains.

On Mittwoch, 27. Mai 2009, Neal Kreitzinger wrote:
> $ git log
> commit 73170498d68a0011b37d7ee095bf88b8dcb6fbb5
> Author: tstuser1 <tstuser1@tstuser.com>
> Date:   Wed May 27 11:48:30 2009 -0500
>
>     2nd commit after initial commit
>
> commit 9f9ed5663d180caefd0bcaff4578fdb2c542bf17
> Author: tstuser1 <tstuser1@tstuser.com>
> Date:   Wed May 27 11:14:38 2009 -0500
>
>     1st commit after initial commit
>
> commit bee2e0fa066aaa9fed99c15c2ab58744a34fda48
> Author: tstuser1 <tstuser1@tstuser.com>
> Date:   Wed May 27 11:13:13 2009 -0500
>
> $
> ***NOTE THAT LAST LINE OF OUTPUT IS MISSING ABOVE (SHOULD BE THE TITLE LINE
> OF THE INITIAL COMMIT -- BUT ITS NOT THERE)***

Please try

   git --no-pager log

Do you see the line? Yes? Then your pager and your terminal do not cooperate 
correctly.

-- Hannes
