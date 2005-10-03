From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What to expect after 0.99.8
Date: Mon, 03 Oct 2005 14:08:36 -0700
Message-ID: <43419DD4.5040508@zytor.com>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <200510032048.37363.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 03 23:09:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMXYM-0007Yz-8n
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 23:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVJCVIv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 17:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJCVIv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 17:08:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18398 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932515AbVJCVIt
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 17:08:49 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j93L8fxH021479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Oct 2005 14:08:41 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200510032048.37363.alan@chandlerfamily.org.uk>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.1 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9653>

Alan Chandler wrote:
> 
> I did wonder today in response to a discussion at work about version control 
> of documentation, whether git could in some way understand OpenDocument 
> format and allow some form of merging of concurrent changes to the same 
> document.  I am not sure if just unzipping the files and applying standard 
> merge strategies the resultant xml would be good enough.
> 
> Sadly just a thought at the moment.
> 

I believe in the medium-to-long term a plugin architecture for merging 
is imperative.  It's not even different media types, but some *files* 
have specific merging policies.  Think, for example, of pci.ids in the 
Linux kernel tree.

	-hpa
