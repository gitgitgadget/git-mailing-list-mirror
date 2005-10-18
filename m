From: "H. Peter Anvin" <hpa@zytor.com>
Subject: gitweb.cgi
Date: Mon, 17 Oct 2005 19:57:22 -0700
Message-ID: <43546492.3020401@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 18 04:58:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERhfZ-00054S-5K
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 04:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVJRC51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 22:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVJRC51
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 22:57:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62426 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932396AbVJRC50
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 22:57:26 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9I2vLra000959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Oct 2005 19:57:24 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10205>

It is increasingly clear that gitweb.cgi is producing an unacceptable 
load on the kernel.org servers.  Most of the hits we get are either the 
gitweb front page or the gitweb rss feeds, and it's eating I/O bandwidth 
like crazy.

This has become particularly painful during the current one-server outage.

Kay, gitweb really needs to be able to do caching, or be run behind a 
caching proxy.  Otherwise I will have to turn it off until we can come 
up with a dedicated piece of server hardware for it.

	-hpa
