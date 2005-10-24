From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFE: git rm
Date: Mon, 24 Oct 2005 12:04:45 -0700
Message-ID: <435D304D.2070306@zytor.com>
References: <435D2FE0.3060307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 24 21:07:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU7d3-0005sA-Do
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 21:05:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVJXTFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 15:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVJXTFA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 15:05:00 -0400
Received: from terminus.zytor.com ([192.83.249.54]:35818 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750988AbVJXTE7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 15:04:59 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9OJ4ocG020174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Oct 2005 12:04:51 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <435D2FE0.3060307@pobox.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10556>

Jeff Garzik wrote:
> 
> It would be nice to say "git rm files..." and have two operations occur:
> 
> * list of files is passed to rm(1)
> * list of files is passed to git-update-index --remove
> 

Install cogito and you have the above as "cg-rm".

	-hpa
