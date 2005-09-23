From: "H. Peter Anvin" <hpa@zytor.com>
Subject: How to make Cogito use git-fetch-pack?
Date: Fri, 23 Sep 2005 15:20:08 -0700
Message-ID: <43347F98.6020101@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Sep 24 00:21:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIvuG-0007Ea-Hf
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 00:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVIWWUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 18:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVIWWUc
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 18:20:32 -0400
Received: from terminus.zytor.com ([209.128.68.124]:58304 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751323AbVIWWUb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 18:20:31 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8NMKDQR007898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 15:20:14 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9209>

Is there any way to make Cogito use git-fetch-pack instead of 
git-ssh-fetch?  git+ssh:// seems to invoke the latter.

	-hpa
