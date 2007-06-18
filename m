From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a local implementation of hstrerror for the system which do not have it
Date: Mon, 18 Jun 2007 23:37:49 +0200
Message-ID: <20070618213749.GB16397@steel.home>
References: <86ejkh40cr.fsf@blue.stonehenge.com> <20070612205210.GC2459@steel.home> <20070612213129.GD2459@steel.home> <4676F8EA.1030305@nrlssc.navy.mil>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:37:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Ov5-0000W9-Ge
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761691AbXFRVhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762281AbXFRVhx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:37:53 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:11391 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760535AbXFRVhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:37:52 -0400
Received: from tigra.home (Fcb3e.f.strato-dslnet.de [195.4.203.62])
	by post.webmailer.de (fruni mo44) (RZmta 7.4)
	with ESMTP id j06b51j5IJR3tb ; Mon, 18 Jun 2007 23:37:50 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E339A277BD;
	Mon, 18 Jun 2007 23:37:49 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 92B32C164; Mon, 18 Jun 2007 23:37:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4676F8EA.1030305@nrlssc.navy.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqByfDQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50417>

Brandon Casey, Mon, Jun 18, 2007 23:28:10 +0200:
> Alex Riesen wrote:
> >The function converts the value of h_errno (last error of name
> >resolver library, see netdb.h). One of systems which supposedly do
> >not have the function is SunOS. POSIX does not mandate its presence.
> 
> I saw a comment on another mailing list that hstrerror() is in the
> resolv library.
> 
>    So adding -lresolv should do it.
> 
> A quick compile works for my test program.
> 

Ah-ha. Good to know, thanks!

Still, the patch is correct: no need for hstrerror there.
