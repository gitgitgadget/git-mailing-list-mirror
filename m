From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Mon, 31 Oct 2005 08:27:02 -0800
Message-ID: <436645D6.3050506@zytor.com>
References: <43652934.8000308@zytor.com> <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net> <20051031064105.GV8041@shell0.pdx.osdl.net> <43663EEA.5050102@zytor.com> <Pine.LNX.4.64.0510310819290.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Chris Wright <chrisw@osdl.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 17:30:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWcWB-0003m5-HM
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 17:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVJaQ1l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 11:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVJaQ1l
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 11:27:41 -0500
Received: from terminus.zytor.com ([192.83.249.54]:20176 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932454AbVJaQ1k
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 11:27:40 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9VGR2Cx030215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Oct 2005 08:27:03 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510310819290.27915@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10865>

Linus Torvalds wrote:
> 
> Now, I'm not certain how happy RPM would be with having one source RPM 
> generate multiple binary RPM's, so we might have problems with some stupid 
> RPM rules, but I think we should really do this. There's always going to 
> be some extra feature that not everybody needs, but that it would be silly 
> to have its own project for. 
> 

RPM is more than happy to do this.  It's a standard feature of RPM.  The 
current RPM, however, is structured in a way that makes it somewhat 
painful, as it depends a little too much on wildcards.

	-hpa
