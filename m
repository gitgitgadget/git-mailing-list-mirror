From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The latest commit to add new keybindings
Date: Mon, 26 Sep 2005 15:04:55 -0700
Message-ID: <43387087.60708@zytor.com>
References: <7v4q8b8d5j.fsf@assigned-by-dhcp.cox.net> <17207.16457.551775.470665@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:06:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK16G-0001at-38
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVIZWFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVIZWFZ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:05:25 -0400
Received: from terminus.zytor.com ([209.128.68.124]:47062 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932343AbVIZWFZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 18:05:25 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8QM4uok002528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Sep 2005 15:04:58 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17207.16457.551775.470665@cargo.ozlabs.ibm.com>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9343>

Paul Mackerras wrote:
> Junio C Hamano writes:
> 
> 
>>Do you actually require 8.4, or any reasonably recent wish would
>>do?
> 
> 
> Checking in the change from "wish" to "wish8.4" was a mistake - that
> was a change I made for some tests, and I forgot to change it back.
> However, gitk does need tk 8.4 or later, since it uses the panedwindow
> widget, which tk 8.3 doesn't have.  I have tk8.5a2 installed here,
> which is nice because it does antialiased fonts, although it is a bit
> slower (clock format is much slower because they changed it from being
> implemented in C to Tcl).
> 

It would be good if the dependency then said tk >= 8.4.

	-hpa
