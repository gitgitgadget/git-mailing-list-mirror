From: Andreas Ericsson <ae@op5.se>
Subject: Re: t1001-read-tree-m-2way.sh failed
Date: Thu, 20 Apr 2006 15:10:07 +0200
Message-ID: <4447882F.8080304@op5.se>
References: <20060420130121.GO11428MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 15:10:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWYvF-0000n5-0i
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 15:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWDTNKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 09:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWDTNKJ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 09:10:09 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:5324 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1750906AbWDTNKI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 09:10:08 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 55F636BD0F; Thu, 20 Apr 2006 15:10:07 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: skimo@liacs.nl
In-Reply-To: <20060420130121.GO11428MdfPADPa@greensroom.kotnet.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18968>

Platform?
Architecture?
git version?
Keyboard color?

This report is missing lots of info. Fill in the missing parts and 
someone will almost certainly be able to help you.

Sven Verdoolaege wrote:
> *** t1001-read-tree-m-2way.sh ***
> * FAIL 1: setup
>         echo frotz >frotz &&
>              echo nitfol >nitfol &&
>              cat bozbar-old >bozbar &&
>              echo rezrov >rezrov &&
>              echo yomin >yomin &&
>              git-update-index --add nitfol bozbar rezrov &&
>              treeH=`git-write-tree` &&
>              echo treeH $treeH &&
>              git-ls-tree $treeH &&
> 
>              cat bozbar-new >bozbar &&
>              git-update-index --add frotz bozbar --force-remove rezrov &&
>              git-ls-files --stage >M.out &&
>              treeM=`git-write-tree` &&
>              echo treeM $treeM &&
>              git-ls-tree $treeM &&
>              git-diff-tree $treeH $treeM
> * failed 1 among 23 test(s)
> 

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
