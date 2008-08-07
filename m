From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git blame and cherry-picking
Date: Thu, 7 Aug 2008 08:09:40 +0200
Message-ID: <20080807060940.GA15405@blimp.local>
References: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 18:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR8XY-0004hP-03
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 18:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYHGQj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 12:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbYHGQj2
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 12:39:28 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:39305 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbYHGQj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 12:39:27 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f50O7
Received: from tigra.home (Faf3d.f.strato-dslnet.de [195.4.175.61])
	by post.webmailer.de (klopstock mo11) (RZmta 16.47)
	with ESMTP id 001b61k77Fvkb1 ; Thu, 7 Aug 2008 18:39:25 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 670A9277BD;
	Thu,  7 Aug 2008 18:39:25 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 34EB636D18; Thu,  7 Aug 2008 08:09:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <91A979F0-1329-4CA6-AADC-6CF55872B57A@midwinter.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91590>

Steven Grimm, Thu, Aug 07, 2008 00:18:33 +0200:
> What, if any, is the approved way to get git blame to follow cherry- 
> picked changes?

The can't be any: cherry-picks are just new commits. You just make the
same changes at the new place in the history.
