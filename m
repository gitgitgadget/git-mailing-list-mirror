From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: GIT 0.99.9
Date: Sun, 30 Oct 2005 15:03:20 -0800
Message-ID: <43655138.2000400@zytor.com>
References: <20051030203808.A535B353E3E@atlas.denx.de> <7v4q6ymx9w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:04:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWMD5-0002C1-JT
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 00:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVJ3XD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 18:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbVJ3XD2
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 18:03:28 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39120 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932392AbVJ3XD2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 18:03:28 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9UN3Kbu016296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 30 Oct 2005 15:03:20 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6ymx9w.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10841>

Junio C Hamano wrote:
> 
> I understand some people like CDPATH in their interactive
> shells, but I do not see a good reason to export that to random
> shell scripts you run from your interactive shell session.
> 

No kidding.  Having 'cd' output stuff to stdout is asking for a million 
shell scripts to be broken.

	-hpa
