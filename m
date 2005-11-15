From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Tue, 15 Nov 2005 12:36:52 -0800
Message-ID: <437A46E4.5010909@zytor.com>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <7vfypxlp8k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 21:40:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec7Yq-00008C-Hv
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 21:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVKOUhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 15:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVKOUhU
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 15:37:20 -0500
Received: from terminus.zytor.com ([192.83.249.54]:16580 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965034AbVKOUhS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 15:37:18 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAFKav1a003551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Nov 2005 12:36:57 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfypxlp8k.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11938>

Junio C Hamano wrote:
> 
> I've applied the patch from HPA to update it to git.spec already
> in my tree, so your script would not work any more ;-)
> 
> But seriously, I suspect we should take a hint from the fact
> that "git.spec.in" has ".in" in its name already.
> 

I'd prefer to have just @@OPENSSH_PACKAGE@@ and @@EXPAT_PACKAGE@@ 
instead of completely virtualizing the dependencies.  Less flexible to 
be sure, but it makes it less confusing to read and fix.

	-hpa
