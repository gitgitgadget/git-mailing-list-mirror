From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git daemon directory munging?
Date: Sun, 04 Jun 2006 16:10:32 -0700
Message-ID: <44836868.1050700@zytor.com>
References: <E1FmgFV-0001i6-Kc@jdl.com>	<Pine.LNX.4.64.0606031722340.5498@g5.osdl.org> <7vverhcu5n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 01:11:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn1kH-0007cr-Ru
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 01:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWFDXKz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWFDXKz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 19:10:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:710 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932306AbWFDXKy
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 19:10:54 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.6/8.13.4) with ESMTP id k54NAgh7016154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 16:10:43 -0700
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vverhcu5n.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21293>

Junio C Hamano wrote:
> 
> Adding host like HTTP does with Host: header makes sense but I
> think the accept side can usually tell what the port it accepted
> the connection to is.
> 

Yes, but that requires that each hostname has a separate IP address 
and/or port number (and SRV records in DNS, which not all platforms pay 
attention to.)

Now, if the hostname is passed in like this, it needs to be carefully 
canonicalized, and there needs to be provisions for wildcard matches.

	-hpa
