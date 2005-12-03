From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitk does not recognizes ISO-8859-15
Date: Sat, 03 Dec 2005 11:23:39 -0800
Message-ID: <4391F0BB.7000800@zytor.com>
References: <4391C6B8.7010507@yahoo.it> <7v4q5qyp5p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@yahoo.it>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:24:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiczA-0006O8-TL
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVLCTXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLCTXu
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:23:50 -0500
Received: from terminus.zytor.com ([192.83.249.54]:59546 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751294AbVLCTXt
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 14:23:49 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB3JNdLL013461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 11:23:39 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q5qyp5p.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13162>

Junio C Hamano wrote:
> Marco Costalba <mcostalba@yahoo.it> writes:
> 
> 
>>So here we arrive. I see two ways to deal with this:
>>
>>1) *solution* make gitk use IANA names
>>
>>2) *workaround* get from somewhere the list of Tcl/Tk recognized codec names and 
>>teach qgit to do the map from IANA when setting a codec with "git-repo-config 
>>i18n.commitencoding"
> 
> 
> The intent of i18n.commitencoding is to have something that is
> understood by iconv there, so if gitk does not work with these
> things spelled like. ISO8859-1 or ISO-8859-15, and qgit is happy
> with them, I would say that we should fix gitk, which means
> *workaround* should be on the tcl/tk side.
> 
> Tcl/Tk expert may have more thoughts (and I suspect experiences)
> on this, but I am not one of them.
> 

I would say that the only sustainable ruleset is to use IANA rules for 
character name resolutions, if multiple tools are to be able to use them.

	-hpa
