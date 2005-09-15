From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 22:58:56 -0700
Message-ID: <43290DA0.3030402@zytor.com>
References: <59a6e583050914094777c4fe96@mail.gmail.com>	<7vwtljjzc3.fsf@assigned-by-dhcp.cox.net>	<59a6e583050914114054b1564d@mail.gmail.com>	<Pine.LNX.4.58.0509141321180.26803@g5.osdl.org> <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Wayne Scott <wsc9tt@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 07:59:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFmm5-00076b-3x
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 07:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVIOF7F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 01:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbVIOF7F
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 01:59:05 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:32229 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S964995AbVIOF7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 01:59:04 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8F5wuJv024578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Sep 2005 22:58:57 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8588>

Paul Mackerras wrote:
> 
> I assume you're compiling git as 32-bit executables on your G5.  I
> don't see any reason why the git binaries would need to be 64-bit.
> 

Well, git seems to assume it can mmap() the entirety of any file under 
its control, so a 64-bit git could handle larger files.

Still, I'm using 32-bit git on ppc64.

	-hpa
