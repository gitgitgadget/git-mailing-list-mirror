From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Cogito: cg-tag creates a tag object only if -s is specified
Date: Mon, 26 Sep 2005 16:36:01 -0700
Message-ID: <433885E1.8010800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 27 01:37:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK2WJ-0002UZ-8K
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 01:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVIZXgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 19:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVIZXgZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 19:36:25 -0400
Received: from terminus.zytor.com ([209.128.68.124]:46060 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964774AbVIZXgY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 19:36:24 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8QNa47f005766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Sep 2005 16:36:04 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9353>

cg-tag only creates a tag object if -s (sign) is specified.  This not 
only doesn't work properly with a fair number of tools (e.g. gitk), but 
it also means that any description the user has entered via the -d 
option is silently discarded!

Please create a tag object for all tags, even if it is not signed.

	-hpa
