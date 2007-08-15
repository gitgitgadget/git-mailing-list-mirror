From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options
   don't work (produce garbage)
Date: Wed, 15 Aug 2007 23:22:04 +0200
Message-ID: <46C36E7C.1080501@dawes.za.net>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com> <3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com> <Pine.LNX.4.64.0708151708570.19222@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Reece Dunn <msclrhd@googlemail.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 23:23:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILQKZ-0003Q4-Pf
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 23:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934285AbXHOVXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 17:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbXHOVXE
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 17:23:04 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:46187 "EHLO
	spunkymail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1763531AbXHOVXB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2007 17:23:01 -0400
Received: from [192.168.201.100] (dsl-146-27-164.telkomadsl.co.za [165.146.27.164])
	by spunkymail-a18.g.dreamhost.com (Postfix) with ESMTP id BD88C5B53A;
	Wed, 15 Aug 2007 14:22:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0708151708570.19222@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55950>

Johannes Schindelin wrote:

> Hmm.  Somehow I doubt that this hack works _outside_ of the Windows 
> console.  I.e. if you call git in rxvt, it will fail, if you ssh into 
> Windows, it will fail.
> 
> Ciao,
> Dscho
> 

I'd say that since Windows doesn't have the concept of terminfo or 
terminal types, and since SSH is mostly only supported through 
cygwin-style "hacks", (or F-Secure, but I have no experience with that) 
that we should not be _too_ concerned about that.

Users that *do* need to use rxvt or SSH should simply disable the color 
mode, or alternatively, use the cygwin version. Color, while useful, is 
hardly critical functionality.

My R0.02.

Regards,

Rogan
