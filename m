From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Cogito: cg-clone doesn't like packed tag objects
Date: Fri, 23 Sep 2005 15:24:06 -0700
Message-ID: <43348086.2040006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 24 00:25:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIvxv-0007yK-V9
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 00:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVIWWYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 18:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVIWWYT
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 18:24:19 -0400
Received: from terminus.zytor.com ([209.128.68.124]:996 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751324AbVIWWYS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 18:24:18 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8NMOA6W011971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 15:24:11 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9210>

Packed tag objects breaks Cogito when using git+ssh:// transport.

Example:

cg-clone -s git+ssh://master.kernel.org/pub/scm/libs/klibc/klibc.git

	-hpa
