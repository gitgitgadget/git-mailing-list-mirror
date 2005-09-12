From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Mon, 12 Sep 2005 10:10:48 -0700
Message-ID: <4325B698.1050805@zytor.com>
References: <m3mzmjvbh7.fsf@telia.com>	<Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>	<20050911185711.GA22556@mars.ravnborg.org>	<Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>	<20050911194630.GB22951@mars.ravnborg.org>	<Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>	<52irx7cnw5.fsf@cisco.com>	<Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>	<Pine.LNX.4.58.0509111431400.3242@g5.osdl.org> <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751066AbVILRLh@vger.kernel.org Mon Sep 12 19:12:14 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751066AbVILRLh@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EErqf-00013h-J0
	for glk-linux-kernel-3@gmane.org; Mon, 12 Sep 2005 19:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVILRLh (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Sep 2005 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVILRLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:11:37 -0400
Received: from terminus.zytor.com ([209.128.68.124]:17334 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751063AbVILRLf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:11:35 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8CHArcn028658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Sep 2005 10:10:53 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virx7njxa.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8408>

Junio C Hamano wrote:
> 
> For kernel.org, you could say '/pub/scm/blah' in your alternates
> and expect it to work, only because http://kernel.org/pub
> hierarchy happens to match the absolute path /pub on the
> filesystem...
 >

Actually it doesn't.  /pub in the root directory on kernel.org is just a 
convenience symlink.

	-hpa
