From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Introduce SHA1_FILE_DIRECTORIES
Date: Mon, 09 May 2005 06:33:07 -0700
Message-ID: <427F6693.2080707@zytor.com>
References: <7vmzr8apxc.fsf@assigned-by-dhcp.cox.net>	<2637.10.10.10.24.1115425225.squirrel@linux1>	<7vis1vc27f.fsf@assigned-by-dhcp.cox.net>	<2721.10.10.10.24.1115425962.squirrel@linux1>	<7vbr7nbl89.fsf@assigned-by-dhcp.cox.net> <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 15:33:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV8Lz-0006KA-Q7
	for gcvg-git@gmane.org; Mon, 09 May 2005 15:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVEINii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 09:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVEINih
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 09:38:37 -0400
Received: from terminus.zytor.com ([209.128.68.124]:47275 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261341AbVEINih
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 09:38:37 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j49DXEpF021309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 9 May 2005 06:33:14 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vacn6ak7r.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Naming the environment variables SHA1_FILE_<anything> is almost 
certainly wrong; a much more logical name would be GIT_<something>. 
It'd also be much less likely to cause conflicts.

	-hpa
