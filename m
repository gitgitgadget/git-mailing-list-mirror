From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: most commonly used git commands?
Date: Thu, 28 Jun 2007 16:49:30 +0200
Organization: eudaptics software gmbh
Message-ID: <4683CA7A.7F8070D7@eudaptics.com>
References: <20070625064017.GA2839@mellanox.co.il>  <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
		   <20070625071752.GB15343@mellanox.co.il>  <Pine.LNX.4.64.0706250846200.4059@racer.site>
		  <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com>
		 <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com> <Pine.LNX.4.64.0706281506390.4438@racer.site> <4683C5D2.FDF4ED02@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 28 16:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3vK9-0001Ns-I4
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 16:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536AbXF1OtO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 10:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757513AbXF1OtN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 10:49:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13416 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761962AbXF1OtM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 10:49:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I3vIw-0000mw-RA; Thu, 28 Jun 2007 16:49:09 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6BDBA6EF; Thu, 28 Jun 2007 16:49:06 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.029
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51113>

Johannes Sixt wrote:
> AFAIAC, it's alright to fall back to update-index for those occasions,
> even though they are not that rare due to a deficiency of
> merge-recursive: When it merges an executable file, it loses the +x bit,
> even if core.filemode=false!

I take that back.

The deficiency is not in merge-recursive, but in 'git add'. The problem
is that after a conflicted merge of an executable file 'git add' loses
the +x bit even if core.filemode=false.

-- Hannes
