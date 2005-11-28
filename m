From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: use binmode(STDOUT) in git-status
Date: Mon, 28 Nov 2005 07:55:05 -0800
Message-ID: <438B2859.6060109@zytor.com>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 16:59:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EglLy-0006A2-D5
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 16:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVK1PzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 10:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbVK1PzW
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 10:55:22 -0500
Received: from terminus.zytor.com ([192.83.249.54]:14253 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750922AbVK1PzV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 10:55:21 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jASFt6Xs019446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Nov 2005 07:55:07 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12888>

Alex Riesen wrote:
> Activision's Perl generates CRLF unless STDOUT is binmoded, which is
> inconsistent with other output of git-status.
> 
> ---
> I assume none _sane_ can want CRLF as line-ending...

Well, if it's a text file we probably should use platform-native 
line-ending, and at least be tolerant of \r\n.

	-hpa
