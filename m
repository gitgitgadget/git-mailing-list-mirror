From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Cogito limitation in tag names?
Date: Sun, 11 Dec 2005 11:23:21 -0800
Message-ID: <439C7CA9.4030404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Dec 11 20:24:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElWn9-0003uu-QE
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 20:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVLKTXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 14:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVLKTXZ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 14:23:25 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6792 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750813AbVLKTXY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 14:23:24 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBBJNLX8002589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Dec 2005 11:23:22 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13505>

 From cg-tag in 0.16:

(echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
         die "name contains invalid characters"

WHY?  I can see rejecting control characters, but the above will reject 
pretty much anything written in a non-English language, which is rude to 
say the least...

	-hpa
