From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 3/3] git --help COMMAND brings up the git-COMMAND man-page.
Date: Wed, 16 Nov 2005 01:24:06 +0100
Message-ID: <437A7C26.5020400@op5.se>
References: <20051115233125.2C0355BF73@nox.op5.se> <7vsltxeakh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 01:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcB64-0002n0-9X
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 01:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVKPAYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 19:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVKPAYJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 19:24:09 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:24466 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S965105AbVKPAYI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 19:24:08 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout1-sn1.fre.skanova.net (7.2.060.1)
        id 4378F0CA0006A6A1 for git@vger.kernel.org; Wed, 16 Nov 2005 01:24:07 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAG0O6f24555
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 01:24:06 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vsltxeakh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11979>

Junio C Hamano wrote:
>>+
>>+	execlp(PATH_TO_MAN, "man", page, NULL);
>>+}
> 
> 
> If you do PATH_TO_MAN absolute, execl would suffice, but just
> saying "man" and have execlp look for it would be easier to
> manage.
> 
> 

Never even occurred to me, actually. I just re-submitted the patch.


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
