From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] gitk: use UTF-8 encoding
Date: Wed, 05 Oct 2005 22:00:58 -0700
Message-ID: <4344AF8A.1040504@zytor.com>
References: <1128564768.32103.18.camel@dv> <7vvf0b9t0d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 07:03:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENNsX-0005Vm-Ca
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 07:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVJFFBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 01:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJFFBL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 01:01:11 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:36008 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1750729AbVJFFBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 01:01:09 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j9650xJv017034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Oct 2005 22:01:00 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf0b9t0d.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9761>

Junio C Hamano wrote:
> Pavel Roskin <proski@gnu.org> writes:
> 
>>gitk should try to use UTF-8 encoding for system operations, such as
>>reading and writing files and git output.
> 
> I agree about commit messages, but I am not so sure about the
> file contents (aka user data).  Is it possible to control them
> separately?
> 

git needs to be able to treat user data as arbitrary binary blobs. 
However, if interpreting as text, UTF-8 is the right default, at least.

	-hpa
