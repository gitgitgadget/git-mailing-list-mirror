From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/PATCH] git-help: add new options -w (for web) and -i (for
 info)
Date: Sat, 24 Nov 2007 14:03:18 +0100
Message-ID: <47482116.70600@op5.se>
References: <20071124051650.07fd275f.chriscool@tuxfamily.org> <20071124113421.GB2948@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio Hamano <junkio@cox.net>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 14:03:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivufe-0002gu-El
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 14:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbXKXNDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 08:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbXKXNDX
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 08:03:23 -0500
Received: from mail.op5.se ([193.201.96.20]:48471 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbXKXNDW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 08:03:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 3397D1F080BA;
	Sat, 24 Nov 2007 14:03:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.924
X-Spam-Level: 
X-Spam-Status: No, score=-3.924 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.475, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yClDVZ5iKJsG; Sat, 24 Nov 2007 14:03:20 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E1A051F080B9;
	Sat, 24 Nov 2007 14:03:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071124113421.GB2948@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65950>

Alex Riesen wrote:
> Christian Couder, Sat, Nov 24, 2007 05:16:50 +0100:
>> +valid_tool() {
>> +	case "$1" in
>> +		firefox | iceweasel | konqueror | w3m)
>> +			;; # happy
> 
> lynx, links and dillo?
> 

Why bother validating it at all? I might be using a script to
add some formatting and then pass it through the browser of my
choice. A friend of mine who's visually impaired does just that
to strip some CSS tags which can make docs quite unreadable for
him.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
