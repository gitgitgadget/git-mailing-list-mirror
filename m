From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb.cgi
Date: Wed, 19 Oct 2005 09:16:44 -0700
Message-ID: <4356716C.7080003@zytor.com>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org> <43552FC2.3000000@zytor.com> <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org> <43559575.1060902@zytor.com> <Pine.LNX.4.64.0510181753340.3369@g5.osdl.org> <43559DFE.7060503@zytor.com> <Pine.LNX.4.64.0510190655230.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 18:19:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESGcm-0007Il-Hx
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 18:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJSQRB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 12:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVJSQRB
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 12:17:01 -0400
Received: from terminus.zytor.com ([192.83.249.54]:29613 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751097AbVJSQRA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 12:17:00 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9JGGijT017030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 09:16:44 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510190655230.3369@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10294>

Linus Torvalds wrote:
> 
> Well, I tried again this morning, and _boy_ is it better. The "projects" 
> thing came up immediately, no waiting. 
> 
> Maybe it just took a while for the mod_cache thing to take effect as 
> Apache swarm members time out? 
> 

No, that's not it.  It takes killing httpd and restarting it.  Rather, 
it looks like mod_cache in different swarm members doesn't always 
communicate instantly, which is also underscored by the fact that cache 
files don't appear into the filesystem until after a while.

	-hpa
