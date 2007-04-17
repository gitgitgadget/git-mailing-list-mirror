From: Rene Herman <rene.herman@gmail.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 19:27:59 +0200
Message-ID: <4625039F.7000804@gmail.com>
References: <4624CD58.90103@gmail.com>	 <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>	 <4624EAAA.6040000@gmail.com>	 <8c5c35580704170855ke426d86vac6e9b3b67fea5ea@mail.gmail.com>	 <4624F18F.6070906@gmail.com> <8c5c35580704171000g74d8944w7c7b3d07228cac2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 19:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdrVV-00013w-Sy
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 19:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbXDQRaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 13:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbXDQRaF
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 13:30:05 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:52196 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161162AbXDQRaD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 13:30:03 -0400
Received: from [213.51.130.190] (port=54758 helo=smtp1.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdrVB-00042o-Ha; Tue, 17 Apr 2007 19:30:01 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:34793 helo=[192.168.0.3])
	by smtp1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1HdrV5-0006zA-JV; Tue, 17 Apr 2007 19:29:55 +0200
User-Agent: Thunderbird 1.5.0.10 (X11/20070221)
In-Reply-To: <8c5c35580704171000g74d8944w7c7b3d07228cac2@mail.gmail.com>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44806>

On 04/17/2007 07:00 PM, Lars Hjemli wrote:

> Ok. Then maybe you want to try something like this:
> 
> $ git clone -l -s -n ../linux-2.6 rene
> $ cd rene
> $ git remote add v20
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.20.y
> $ git fetch v20
> 
> This gives you a tracking branch for 2.6.20.y, named as "v20/master".
> That branch can then be used as a starting point for your a, b and c
> branches, like:
> 
> $ git checkout -b a v20/master    # this _will_ take some time...
> 
> After applying some changes on branch a, you can then merge the latest
> changes on the v20-branch like this
> 
> $ git fetch v20
> $ git merge v20/master
> 
> If you want the merge to occur on a separate branch, do this first:
> 
> $ git checkout -b tmp a

Thanks much! This is very useful.

Rene.
