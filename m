From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git'ing a non-labeled set of sources
Date: Wed, 8 Aug 2007 23:20:11 +0200
Message-ID: <20070808212011.GA3081@steel.home>
References: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local> <20070808193720.GD27470@xp.machine.xx> <CF7E46FCFF66AD478BB72724345289EC170CE5@twx-exch01.twacs.local>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: "Sparks, Sam" <SSparks@twacs.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:20:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsx5-0002Rc-Ns
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765651AbXHHVUU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765463AbXHHVUU
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:20:20 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:16982 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761255AbXHHVUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:20:19 -0400
Received: from tigra.home (Fad2f.f.strato-dslnet.de [195.4.173.47])
	by post.webmailer.de (klopstock mo44) (RZmta 10.3)
	with ESMTP id j06315j78FdsSE ; Wed, 8 Aug 2007 23:20:11 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C45B2277BD;
	Wed,  8 Aug 2007 23:20:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id A6E6BBDCE; Wed,  8 Aug 2007 23:20:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC170CE5@twx-exch01.twacs.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClQI4w==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55370>

Sparks, Sam, Wed, Aug 08, 2007 21:52:14 +0200:
> >From: Peter Baumann [mailto:waste.manager@gmx.de] 
> >
> >Because there is no 5b1313fb2758ffce8b624457f777d8cc6709608d in the
> >repo.
> 
> Does git allow the removal of commits? I don't understand how I was able
> to download it a couple of months ago, but it is no longer accessible.

They cleaned up. Rebased or discarded the branch which had the commit
and cleaned up. That's what "git gc" and "git prune" do.
