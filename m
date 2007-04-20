From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: cherry-pick --since ?
Date: Fri, 20 Apr 2007 20:55:24 +0200
Message-ID: <20070420185524.GA4420@steel.home>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Apr 20 20:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeyGa-0005Ms-1v
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 20:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbXDTSz2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 14:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbXDTSz2
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 14:55:28 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:29803 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbXDTSz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 14:55:27 -0400
Received: from tigra.home (Fc9ca.f.strato-dslnet.de [195.4.201.202])
	by post.webmailer.de (mrclete mo22) (RZmta 5.5)
	with ESMTP id A000dej3KDUfDg ; Fri, 20 Apr 2007 20:55:25 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 39E0F277BD;
	Fri, 20 Apr 2007 20:55:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A738DBDDE; Fri, 20 Apr 2007 20:55:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAcnfmc=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45123>

Brandon Casey, Fri, Apr 20, 2007 18:20:32 +0200:
> Is there functionality to allow something akin to a
>
>    git cherry-pick --since <commit>
> 

git format-patch --stdin --binary --full-index -k from..to | git am -k -3
