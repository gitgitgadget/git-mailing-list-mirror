From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 20:35:17 -0800
Message-ID: <437EAB85.7030506@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr>	<200511181926.10357.ismail@uludag.org.tr>	<200511182127.06958.ismail@uludag.org.tr>	<20051118200217.GA2831@vrfy.org> <7v64qpco40.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 05:36:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdKRp-0000TP-Q5
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 05:35:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVKSEfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 23:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKSEfa
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 23:35:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47080 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750889AbVKSEfa
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 23:35:30 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAJ4ZHkt021645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 20:35:17 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64qpco40.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12321>

Junio C Hamano wrote:
> I just looked at the diff this commit introduces:
> 
> 	e6bd23911efd0a2bd756c77d9e7ba6576eb739a1
>         Documentation: asciidoc sources are utf-8
> 
> with gitk (BTW, I pulled from paulus today, so "master" branch
> has the latest gitk) while my locale set to LC_CTYPE=en_US.utf8.
> 
> Surprisingly, the diff to Documentation/git-pack-redundant.txt,
> which changes Lukas' name originally incorrectly encoded in
> iso-8859-1 to utf-8, was shown and both pre-image and post-image
> lines are readable.
> 
> I do not know how tcl/tk does it, but it is doing the right
> thing.
> 

Tcl/Tk assumes that anything that isn't valid UTF-8 is Latin-1.

	-hpa
