From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git describe bug?
Date: Fri, 2 Apr 2010 11:31:47 -0700
Message-ID: <20100402183147.GA20007@spearce.org>
References: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dustin Sallings <dustin@spy.net>
X-From: git-owner@vger.kernel.org Fri Apr 02 20:31:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxlev-0006VC-4k
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 20:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0DBSbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 14:31:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38346 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0DBSbv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 14:31:51 -0400
Received: by pwi5 with SMTP id 5so1862318pwi.19
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 11:31:50 -0700 (PDT)
Received: by 10.140.252.8 with SMTP id z8mr1833795rvh.35.1270233110157;
        Fri, 02 Apr 2010 11:31:50 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm2110928iwn.7.2010.04.02.11.31.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 11:31:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143833>

Dustin Sallings <dustin@spy.net> wrote:
> 
> 	describe does not choose the most recent tag when multiple tags point to a single commit (for example, when an RC release becomes a proper release).
> 
> 	There's a bit of conflict in the documentation between the following:
> 
> 		``tags with newer dates will always be preferred over tags with older dates''
> 
> 	and the next sentence:
> 
> 		``If an exact match is found, its name will be output and searching will stop.''
> 
> 	The code does not allow for multiple exact matches, leading to what I would consider incorrect behavior as shown below:

Yes, I've seen this too.  IIRC we've actually discussed this in
the past.  I can't find the thread (my search skills are sub-par
despite who I work for...).  But the general idea if I remember
it right was we wanted to use the older tag, because that tag
came first.

So its probably more a documentation bug than a software bug.

-- 
Shawn.
