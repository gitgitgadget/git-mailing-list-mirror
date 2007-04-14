From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cygwin and git 1.5.1
Date: Sat, 14 Apr 2007 10:53:34 -0700
Message-ID: <4621151E.9070707@zytor.com>
References: <461BCBC0.2000705@ramsay1.demon.co.uk> <461C134D.8020803@zytor.com> <46210DA4.1090600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 14 19:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcmRe-0006p6-PQ
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 19:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbXDNRxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 13:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbXDNRxv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 13:53:51 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42671 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbXDNRxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 13:53:50 -0400
Received: from [172.27.0.16] (c-67-180-238-171.hsd1.ca.comcast.net [67.180.238.171])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l3EHrY5t004747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 14 Apr 2007 10:53:35 -0700
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <46210DA4.1090600@ramsay1.demon.co.uk>
X-Virus-Scanned: ClamAV 0.88.7/3091/Sat Apr 14 09:53:57 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.9 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_48_96,RCVD_IN_NJABL_DUL autolearn=no version=3.1.8
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44466>

Ramsay Jones wrote:
> 
> Yes, that would work. However, I rejected this solution last time, because
> I did not want to add a dependency on the C99 header files.
> Having said that, that ship has probably sailed ... ;-)
> 

If you're using uint32_t and similar types, well, then, you're using 
<inttypes.h>.  Now, <inttypes.h> can be written up for an old compiler 
fairly easily.

	-hpa
