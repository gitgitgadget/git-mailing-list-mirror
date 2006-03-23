From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Wed, 22 Mar 2006 22:09:20 -0800
Message-ID: <44223B90.3040500@zytor.com>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 07:09:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMJ0r-0002Kt-L3
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 07:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWCWGJf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 01:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWCWGJf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 01:09:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:2013 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750759AbWCWGJe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 01:09:34 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k2N69KiN000443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Mar 2006 22:09:20 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17854>

Linus Torvalds wrote:
> 
> It _seems_ that the reason for that is that cvsps considers a revision 
> number of 1.1.1.1 to have a "dot depth" of 0, for some really strange 
> reason (it's a total special case).
> 

Probably because in 99% of all cases, revision 1.1.1.1 is the result of 
a "cvs import".

	-hpa
