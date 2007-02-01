From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Thu, 01 Feb 2007 08:16:12 -0800
Message-ID: <45C2124C.5070308@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com> <7vireuaj9d.fsf@assigned-by-dhcp.cox.net> <45B92332.5060206@zytor.com> <7v3b5yai6c.fsf@assigned-by-dhcp.cox.net> <45B928AD.50508@zytor.com> <Pine.LNX.4.63.0701260029580.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45BBCD27.5050408@zytor.com> <Pine.LNX.4.63.0702011501250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 17:17:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCebv-0007JT-R6
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 17:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXBAQQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 11:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161182AbXBAQQY
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 11:16:24 -0500
Received: from terminus.zytor.com ([192.83.249.54]:57515 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbXBAQQY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 11:16:24 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l11GGCO0012274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Feb 2007 08:16:13 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <Pine.LNX.4.63.0702011501250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV 0.88.7/2511/Thu Feb  1 06:55:18 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.6 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38368>

Johannes Schindelin wrote:
> Hi,
> 
> I just had another idea: why not generate the content of the "cover page" 
> in a cron job, every minute or so, and save it into a static index.html? 
> This should take quite a load from the server, since not even Perl has to 
> be started to serve that page.
> 

Ehm... because it often takes longer than that to generate the page?

We can pre-generate the page before the first hit, but that's not a 
replacement for update-time caching.

	-hpa
