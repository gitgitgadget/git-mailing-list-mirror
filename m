From: Zack Brown <zbrown@tumblerings.org>
Subject: cg-mv
Date: Fri, 7 Oct 2005 07:33:33 -0700
Message-ID: <20051007143333.GA18843@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 07 16:34:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENtI2-0004gt-6Z
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 16:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVJGOdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 10:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbVJGOdf
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 10:33:35 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:22406 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S1030205AbVJGOde
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 10:33:34 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.52)
	id 1ENtHy-000511-1b
	for git@vger.kernel.org; Fri, 07 Oct 2005 07:33:34 -0700
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9801>

Hi,

IIRC, file renaming is something we only care about at read time, we don't
actually need to track it while making the change, because git allows us to
track data from file to file without having to tell it that the data is moving.

So, just to keep certain people happy, why not have the cg-mv command defined to
something like this:

#!/bin/bash
cp $1 $2
cg-rm $1
cg-add $2


Be well,
Zack

-- 
Zack Brown
