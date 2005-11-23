From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Perl version support (was Re: [PATCH] git-mv is not able to handle
 big directories)
Date: Wed, 23 Nov 2005 13:56:04 -0800
Message-ID: <4384E574.8060801@zytor.com>
References: <200511231141.57683.lan@ac-sw.com>	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>	<867jazre78.fsf@blue.stonehenge.com>	<7vu0e369p4.fsf@assigned-by-dhcp.cox.net>	<20051123135604.GB16995@mythryan2.michonline.com> <86mzjvphhj.fsf_-_@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 22:59:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef2bR-0007UR-An
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 22:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVKWV4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 16:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVKWV4a
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 16:56:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:27799 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932554AbVKWV43
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 16:56:29 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jANLu9eu029364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Nov 2005 13:56:09 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86mzjvphhj.fsf_-_@blue.stonehenge.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12652>

Randal L. Schwartz wrote:
> 
> I'd say that 50% of the Perl-using population is at 5.6, with 25% each
> at 5.5 and 5.8.  Those on 5.5 are generally unable to upgrade Perl
> for corporate reasons.
> 
> Targetting Perl 5.6 would assist broad acceptance of git for the
> typical commercial end user.  Targetting 5.5 where possible would
> ensure practical success for everyone.
> 
> However, I have not seen the "target market" of git discussed yet
> (I came late to the party), so if support for 5.6 (or 5.5) is not chosen,
> it merely limits the market.
> 

There are a lot of Perl modules we use, so limiting it to 5.5 is 
probably a showstopper.

I'm very surprised you say that 5.6 is more prevalent than 5.8.

	-hpa
