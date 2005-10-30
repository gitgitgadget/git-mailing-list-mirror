From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Sun, 30 Oct 2005 12:51:20 -0800
Message-ID: <43653248.2010608@zytor.com>
References: <20051030204034.849C5353E3E@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 30 21:52:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWK9L-00029q-P3
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 21:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVJ3Uv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 15:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVJ3Uv2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 15:51:28 -0500
Received: from terminus.zytor.com ([192.83.249.54]:16591 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751124AbVJ3Uv1
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 15:51:27 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9UKpKN8012391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Oct 2005 12:51:21 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051030204034.849C5353E3E@atlas.denx.de>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10832>

Wolfgang Denk wrote:
> In message <43652934.8000308@zytor.com> you wrote:
> 
>>The Subversion importer Perl script breaks RPM generation.  First of 
> 
> Confirmed. Well, actually the RPM *build* works fine.

No, it doesn't.  It runs to completion, but it produces the wrong output.

	-hpa
