From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-am: "Patch fragment without a header"
Date: Mon, 06 Feb 2006 19:32:18 -0800
Message-ID: <43E814C2.6090104@zytor.com>
References: <43E80D23.4070007@zytor.com> <7vwtg73ld7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 04:32:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6Jac-0000AA-Hz
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 04:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWBGDcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 22:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWBGDcX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 22:32:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52147 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964950AbWBGDcX
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2006 22:32:23 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k173WIpC025878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 6 Feb 2006 19:32:19 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtg73ld7.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15683>

Junio C Hamano wrote:
> 
> Linus would have said "Say No to MIME".  I am a bit too busy
> right now so if you are inclined to take a look, the problem is
> in mailinfo.
> 

Unfortunately git-mailinfo is in C, otherwise I'd have suggested using 
the Perl MIME-tools, which seems to have all this stuff in it.

It might just be easier to try to rewrite git-mailinfo in Perl...

	-hpa
