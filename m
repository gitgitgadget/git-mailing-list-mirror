From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 22:37:36 -0800
Message-ID: <44151330.7020905@zytor.com>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org> <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com> <4414E000.9030902@zytor.com> <4414F6B1.9080107@gmail.com> <Pine.LNX.4.64.0603122103440.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mark Wooding <mdw@distorted.org.uk>
X-From: git-owner@vger.kernel.org Mon Mar 13 07:37:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIgge-0005Nv-Cn
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 07:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWCMGho (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 01:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWCMGhn
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 01:37:43 -0500
Received: from terminus.zytor.com ([192.83.249.54]:63199 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751667AbWCMGhn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 01:37:43 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k2D6baT4025169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 12 Mar 2006 22:37:37 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603122103440.3618@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17553>

On "real" machines, the biggest reason you'd care is that a lot of 
compilers, *especially* in C++ mode, really still define NULL as "0"; 
ostensibly because defining it as "((void *)0)" breaks some obscure C++ 
casting rule.

	-hpa
