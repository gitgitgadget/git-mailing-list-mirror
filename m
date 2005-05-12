From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Adapting scripts to work in current (not top) directory
Date: Thu, 12 May 2005 12:15:52 -0700
Message-ID: <4283AB68.1090003@zytor.com>
References: <200505121758.10971.snake@penza-gsm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 21:10:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWJ3I-0001Mt-CK
	for gcvg-git@gmane.org; Thu, 12 May 2005 21:08:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVELTQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVELTQ1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 15:16:27 -0400
Received: from terminus.zytor.com ([209.128.68.124]:29408 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261417AbVELTQI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 15:16:08 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4CJFqsB011383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 May 2005 12:15:54 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Alexey Nezhdanov <snake@penza-gsm.ru>
In-Reply-To: <200505121758.10971.snake@penza-gsm.ru>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alexey Nezhdanov wrote:
> All git and cogito scripts wants .git subdirectory. If I'm in a subdirectory 
> that have no .git direcory in it I'm out of luck.
> I have wrote an example script that determines the lowest possible .git 
> directory position and changes to it to satisfy user request.
> 
> Problems with script:
> 1) May be I misunderstood the git ideology and it needs not this at all.
> 

Linus has explicitly said he doesn't want that.

	-hpa
