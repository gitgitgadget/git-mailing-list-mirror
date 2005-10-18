From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git-daemon enabled on kernel.org
Date: Tue, 18 Oct 2005 12:30:23 -0700
Message-ID: <43554D4F.7040403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 18 21:32:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERxAe-0000zu-Lw
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 21:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVJRTal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 15:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVJRTal
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 15:30:41 -0400
Received: from terminus.zytor.com ([192.83.249.54]:16343 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751359AbVJRTak
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 15:30:40 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9IJUSoU005669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 12:30:29 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10224>

After getting gitweb behind mod_cache, the load on kernel.org has gotten 
down into the tolerable range, so I have enabled git-daemon in an 
attempt to fix that :)

The URL, obviously, is git://git.kernel.org/pub/scm/...

(or, to specify a specific server, git1.kernel.org or git2.kernel.org.)

I consider this experimental so far, and if it imposes an unacceptable 
load I'll have to disable it.  It currently runs with an inetd-imposed 
limits of 10 instances per server.

	-hpa
