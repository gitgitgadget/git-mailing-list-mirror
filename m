From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.2.0
Date: Sun, 12 Feb 2006 13:51:21 -0800
Message-ID: <43EFADD9.7010909@zytor.com>
References: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 22:51:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8P86-000741-Oz
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 22:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWBLVvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 16:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBLVvf
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 16:51:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:42975 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751452AbWBLVvf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 16:51:35 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k1CLpMFa005385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Feb 2006 13:51:22 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL 
	autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16021>

Junio C Hamano wrote:
> The latest feature release GIT 1.2.0 is available at the
> usual places:
> 
> 	http://www.kernel.org/pub/software/scm/git/
> 
> 	git-1.2.0.tar.{gz,bz2}			(tarball)
> 	RPMS/$arch/git-*-1.2.0-1.$arch.rpm	(RPM)
> 
> Right now binary RPM is available only for x86_64, because I do
> not have an access to RPM capable i386 box.
> 

You can build the i386 binary rpms on hera as such:

rpmbuild --rebuild --target i386 git-1.2.0-1.src.rpm

I had to install openssl-devel from the i386 distribution, which for 
some reason wasn't part of the x86-64 distribution, but that's now taken 
care of.

	-hpa
