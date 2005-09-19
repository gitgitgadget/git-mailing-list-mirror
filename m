From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 12:23:59 -0700
Message-ID: <432F104F.8030206@zytor.com>
References: <432E1F28.9060909@bigpond.net.au>    <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net> <53717.10.10.10.28.1127107066.squirrel@linux1> <432E598A.7020306@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 21:26:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHRGJ-0007HZ-0t
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 21:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVISTYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 15:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVISTYw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 15:24:52 -0400
Received: from terminus.zytor.com ([209.128.68.124]:17601 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932600AbVISTYw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 15:24:52 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8JJO3QA006274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 12:24:04 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <432E598A.7020306@bigpond.net.au>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8901>

Peter Williams wrote:
> 
> IMHO rpm shouldn't care how ShellQuote got there unless it (how it got 
> there) is stated as an explicit dependency in the spec file (which it 
> isn't).  So I still think this is a bug in rpm's (automatic) dependency 
> mechanism that needs fixing.
> 

Unfortunately it doesn't work that way (and this is the wrong mailing 
list to discuss it on.)  Anyway, the best way to install CPAN modules on 
an RPM-based system is to use cpan2rpm.

	-hpa
