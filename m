From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Rebase, please help
Date: Wed, 11 Apr 2007 08:52:00 +0700
Message-ID: <200704110852.00540.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 10:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbS0L-00068Z-Pm
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 03:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030746AbXDKBwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 21:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030748AbXDKBwK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 21:52:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:40634 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030746AbXDKBwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 21:52:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so18295uga
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 18:52:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KmOaDh0+tu0CqHXX7w/Hee+UQOSE5G0iEpbnTFi1o5oT5dC8voUDpWMozLzNXde3TLQxuUi+i9cOP90VUeYLvtFNk0UwzttHHpBqSnJDHZew32Vi/yKGvT5fRhiHZCRq3zvFV3lqV/ESCR6bIPiFH6LY0xn9znQLlja9/bsjmBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bB1/ytDFuf+snx/OGHED1mr7hYKS2DW7jQpWPaml1qJb6vkromOW/K55rEvP9Djr/MHGPXKa9Q5L5LmhEqFcwJ20oFrJMInb3z6bOFpxHt/8tp82gPs9VOMNnDi7bqaYMsm3qYMqD8LRcxEyk3iKu4cB/gqBwT1mNGoxeNtKJeY=
Received: by 10.66.252.18 with SMTP id z18mr68015ugh.1176256328172;
        Tue, 10 Apr 2007 18:52:08 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id b23sm1457613ugd.2007.04.10.18.52.06;
        Tue, 10 Apr 2007 18:52:07 -0700 (PDT)
User-Agent: KMail/1.8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44205>

Hello list.

I have found that rebase have (new) option : --merge
Looking at the code show me that regular rebase is a simply format-patch and 
am but --merge (or -s) use some merge stratyegy to merge changes between two 
commits into current head.

What is --merge for ? Will the result be the same ?
