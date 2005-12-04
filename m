From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-update-server-info crashes on hera.kernel.org:/pub/scm/libs/klibc/klibc.git
Date: Sat, 03 Dec 2005 22:27:05 -0800
Message-ID: <43928C39.8050105@zytor.com>
References: <43921DAE.7060606@zytor.com> <7vzmnhtmi1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 07:28:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EinL9-0001dJ-Ux
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 07:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLDG1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 01:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVLDG1M
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 01:27:12 -0500
Received: from terminus.zytor.com ([192.83.249.54]:38586 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750798AbVLDG1M
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Dec 2005 01:27:12 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB46R5Fj024531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 22:27:06 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmnhtmi1.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13182>

Junio C Hamano wrote:
> I made a copy of that repository on hera and tried it but cannot
> reproduce (with or without -f flag -- and running under gdb with
> symbols did not make difference either).  Sorry, I am baffled.
> The same machine, the same set of input and binary.
> 

FWIW, I invoked this as:

hpa@hera:~(0)$ GIT_DIR=/pub/scm/libs/klibc/klibc.git git-update-server-info
Segmentation fault

	-hpa
