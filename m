From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: use binmode(STDOUT) in git-status
Date: Mon, 28 Nov 2005 08:08:48 -0800
Message-ID: <438B2B90.9010500@zytor.com>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com> <438B2859.6060109@zytor.com> <Pine.LNX.4.63.0511281700100.11362@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 17:12:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EglZ6-0004Eb-6i
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 17:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVK1QJN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 11:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVK1QJN
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 11:09:13 -0500
Received: from terminus.zytor.com ([192.83.249.54]:64490 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751264AbVK1QJM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 11:09:12 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jASG8mYq020211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Nov 2005 08:08:48 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511281700100.11362@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12890>

Johannes Schindelin wrote:
> 
> Of course, here is the problem: git on Windows runs only using cygwin. You 
> can specify the line ending behaviour of cygwin (I think it is an env 
> variable). Activision Perl, being independent of cygwin, does not care 
> about that setting.
> 
> So, to be accurate, you'd have to check what *cygwin* expects, and 
> depending on that execute binmode(STDOUT) or not.
> 

Makes sense, I guess... except if you're running Cygwin, wouldn't 
Cygwin's Perl make a lot more sense?

	-hpa
