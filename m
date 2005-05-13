From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/4] Pulling refs by ssh
Date: Fri, 13 May 2005 11:59:21 -0700
Message-ID: <4284F909.9000309@zytor.com>
References: <Pine.LNX.4.21.0505130258030.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 21:51:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWgBE-0000xw-3Y
	for gcvg-git@gmane.org; Fri, 13 May 2005 21:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVEMTow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 15:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVEMTol
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 15:44:41 -0400
Received: from terminus.zytor.com ([209.128.68.124]:24730 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262493AbVEMS75
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 14:59:57 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4DIxQVo006400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 May 2005 11:59:27 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0505130258030.30848-100000@iabervon.org>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow wrote:
> Adds support for pulling refs by rsh.
> 
> This changes the rsh protocol to allow requests for different things, and
> to allow the server to report that it doesn't have something without
> breaking the connection.
> 

Use && rather than semicolon, and make sure you quote things that need 
to be quoted.

	-hpa
