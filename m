From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Local clone/fetch with cogito is glacial
Date: Sun, 21 May 2006 16:47:45 -0700
Message-ID: <4470FC21.6010104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 22 01:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhxeM-0007uK-Rd
	for gcvg-git@gmane.org; Mon, 22 May 2006 01:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWEUXrv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 19:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWEUXrv
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 19:47:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:3259 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751558AbWEUXru
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 19:47:50 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k4LNljEA011110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 May 2006 16:47:46 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20465>

It appears that doing a *local* -- meaning using a file path or file URL 
-- clone or fetch with cogito is just glacial when the repository has an 
even moderate number of tags (and it's fetching the tags that takes all 
the time.)  That's a really serious problem for me.

	-hpa
